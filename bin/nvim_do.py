#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Send command to all listening nvim instances
"""

import argparse
from glob import glob
from pynvim import attach

def execute_command(cmd='', bfr='', pid=''):
    """Execute command"""

    if not cmd:
        return

    files = glob('/tmp/nvim*/*')
    print(files)

    print(1)

    for nvim in files:
        print(2)
        instance = attach('socket', path=nvim)

        if pid:
            print('coucou')
            print(instance.api.get_api_info())

        if not bfr:
            instance.command(cmd)

        if instance.eval(f"bufexists('{bfr}')") == 1:
            instance.command(cmd)

PARSER = argparse.ArgumentParser()
PARSER.add_argument("-c", "--command", help="Command for all nvim insances to execute")
PARSER.add_argument("-b", "--buffer", help="Name of current buffer")
PARSER.add_argument("-p", "--pid", help="PID")

ARGS = PARSER.parse_args()

execute_command(ARGS.command, ARGS.buffer, ARGS.pid)
