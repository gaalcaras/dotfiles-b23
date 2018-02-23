#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Append an email address to a mailing lists file
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


def get_msg_sender(message):
    """Return message sender name"""

    sender_header = message['From']
    sender = ''

    # Decode sender
    parts = email.header.decode_header(sender_header)
    for part in parts:
        if not isinstance(part[0], str):
            str_part = part[0].decode('utf-8')
        else:
            str_part = part[0]

        sender += str_part

    sender_pat = re.compile(r'<(.*)>')
    sender_match = re.search(sender_pat, sender)

    if sender_match:
        sender = sender_match.group(1)

    return sender

MUTT_OUTPUT = sys.stdin.read()
MESSAGE = email.message_from_string(MUTT_OUTPUT)

MLISTS = os.path.join(os.path.expanduser('~'), '.dotfiles', 'mutt', 'mlists')
SENDER = get_msg_sender(MESSAGE)
print(SENDER)

with open(MLISTS, 'a') as mlists_file:
    mlists_file.write('\nsubscribe -group lists {}'.format(SENDER))
