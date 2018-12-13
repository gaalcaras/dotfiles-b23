#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Send command to all listening nvim instances
"""

import argparse
from pynvim import attach
from glob import glob

def execute_command(cmd=''):
    """Execute command"""

    if not cmd:
        return

    files = glob('/tmp/nvim*/0')

    for nvim in files:
        instance = attach('socket', path=nvim)
        instance.command(cmd)

PARSER = argparse.ArgumentParser()
PARSER.add_argument("-c", "--command", help="Command for all nvim insances to execute")

ARGS = PARSER.parse_args()

execute_command(ARGS.command)
