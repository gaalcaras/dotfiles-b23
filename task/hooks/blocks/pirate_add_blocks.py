#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Enable setting a dependency from the blocking task itself

By Gabriel Alcaras
Uses a modified version of https://github.com/tbabej/taskpirate
"""

from tasklib import TaskWarrior

TW = TaskWarrior('~/.task')

def hook_blocks(task):
    """
    Set dependency from current task
    """

    if task['blocks']:
        blocked_ids = task['blocks'].split(',')
        task.save()

        for blocked_id in blocked_ids:
            blocked = TW.tasks.get(id=blocked_id)
            blocked['depends'] = set([task])
            blocked.save()

            print(f"This task nows blocks task {blocked['id']} '{blocked['description']}'.")
