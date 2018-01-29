#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Add a mail as task to taskwarrior.
# Works best in conjuction with taskopen script.
#
# Adapted from https://github.com/artur-shaik/mutt2task to python3.
#
# Add this to your .muttrc:
# macro index,pager t "<pipe-message>mutt2task.py<enter>"
"""

import os
import sys
import email
import re
import argparse

from subprocess import call, Popen, PIPE

def get_notes_dir():
    """Get task notes directory """

    home = os.path.expanduser('~')
    notes_dir = os.path.join(home, '.tasknotes')
    notes_dir_pat = re.compile(r'^NOTES_FOLDER\s*=\s*(.*)$')

    os.makedirs(notes_dir, exist_ok=True)

    for line in open(os.path.join(home, '.taskopenrc'), 'r'):
        dir_match = notes_dir_pat.match(line)

        if dir_match:
            notes_dir = dir_match.group(1).replace('"', '')
            notes_dir = os.path.expandvars(notes_dir)

    return notes_dir

def get_msg_body(message):
    """Return message body"""

    body = None
    html = None
    out = ""

    for part in message.walk():
        if part.get_content_type() == "text/plain":
            if body is None:
                body = ""
            body += str(part.get_payload(decode=True))
            body += str(part.get_content_charset())
        elif part.get_content_type() == "text/html":
            if html is None:
                html = ""
            html += part.get_payload(decode=True).decode('utf-8')

    if html:
        html_tmp_f = Popen('mktemp', stdout=PIPE).stdout.read().strip().decode('utf-8')
        with open(html_tmp_f, "w") as html_f:
            html_f.write(html)

        cat = Popen(['cat', html_tmp_f], stdout=PIPE)
        w3m = Popen(['w3m', '-T', 'text/html'], stdin=cat.stdout, stdout=PIPE)
        out = w3m.stdout.read().decode('utf-8')
    else:
        out = body

    return out

def get_msg_subject(message):
    """Return message subject line"""

    subject = message['Subject']

    # Decode subject line
    subject = email.header.decode_header(subject)[0][0]
    if not isinstance(subject, str):
        subject = subject.decode('utf-8')

    return subject

def get_msg_sender(message):
    """Return message sender name"""

    sender = message['From']

    # Decode sender
    sender = email.header.decode_header(sender)[0][0]
    if not isinstance(sender, str):
        sender = sender.decode('utf-8')

    sender_pat = re.compile(r'(.*)\s*<.*')
    sender_match = re.match(sender_pat, sender)

    if sender_match:
        sender = sender_match.group(1)

    return sender

def modify(subject):
    """Open subject line in $EDITOR and return the result"""

    tmp_subject = Popen('mktemp', stdout=PIPE).stdout.read().strip().decode('utf-8')

    with open(tmp_subject, "w") as subject_f:
        subject_f.write(subject)

    call([os.path.expandvars('$EDITOR'), tmp_subject])

    tmp_sub_f = open(tmp_subject, "r")
    subject = tmp_sub_f.read().rstrip()
    tmp_sub_f.close()

    return subject

def add_task(subject):
    """Add task and return its id if it worked"""

    task = Popen(['task', 'add', '+email', '--', subject], stdout=PIPE)
    task_id = re.match(r'Created task (\d+)\.', task.stdout.read().decode('utf-8'))

    if not task_id:
        return None

    return task_id.group(1)

def annotate_task(task_id, note):
    """Annotate task with task_id with note string"""

    uuid = Popen(['task', task_id, 'uuids'], stdout=PIPE).stdout.read().strip().decode('utf-8')
    call(['task', task_id, 'annotate', '--', 'email:', 'Notes'])

    notes_dir = get_notes_dir()
    note_file = os.path.join(notes_dir, '{}.txt'.format(uuid))

    with open(note_file, 'w') as note_f:
        note_f.write(note)

def create_task(args, message):
    """Create task from message according to args options"""

    body = get_msg_body(message)
    task_name = get_msg_subject(message)

    if args.answer:
        sender = get_msg_sender(message)
        task_name = args.answer + sender

    if args.modify:
        task_name = modify(task_name)

    task_id = add_task(task_name)

    if task_id is not None or not args.answer:
        annotate_task(task_id, body)

PARSER = argparse.ArgumentParser()
PARSER.add_argument("-m", "--modify", help="modify task name in your $EDITOR",
                    action="store_true")
PARSER.add_argument("-a", "--answer", help="create task with sender name"
                                           "prefixed with string as argument value")


ARGS = PARSER.parse_args()

MUTT_OUTPUT = sys.stdin.read()
MESSAGE = email.message_from_string(MUTT_OUTPUT)

create_task(ARGS, MESSAGE)
