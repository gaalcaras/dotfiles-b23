#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Add task with a due date to a vdir calendar.

By Gabriel Alcaras
Uses a modified version of https://github.com/tbabej/taskpirate
"""

import os
import sys
from datetime import datetime
from ics import Calendar, Event

CALENDAR = os.path.join(os.path.expanduser('~'), '.calendars', 'taskwarrior')

def get_command(args):
    """
    Get the command that triggered the hook.
    """

    return args[3][8:]

def hook_default_time(task):
    """
    Create ics file based on task data.
    """

    command = get_command(sys.argv)
    delete = command in ('delete', 'done')
    avoid_tags = ('mutt', 'email', 'followup')

    if any([tag in task['tags'] for tag in avoid_tags]):
        return

    if (task['due'] and delete) or not task['due']:
        ics_path = os.path.join(CALENDAR, task['uuid'] + '.ics')

        if os.path.exists(ics_path):
            os.remove(ics_path)

        print('Removed task from taskwarrior calendar.')

    if task['due'] and not delete:
        cal = Calendar()
        event = Event()
        event.name = task['description']
        due = datetime(year=task['due'].year,
                       month=task['due'].month,
                       day=task['due'].day,
                       hour=task['due'].hour,
                       minute=task['due'].minute,
                       second=task['due'].second)
        event.begin = due
        event.make_all_day()

        cal.events.add(event)

        ics_path = os.path.join(CALENDAR, task['uuid'] + '.ics')

        if not os.path.exists(CALENDAR):
            os.makedirs(CALENDAR)

        with open(ics_path, 'w') as ics_file:
            ics_file.writelines(cal)

        print('Updated taskwarrior calendar.')
