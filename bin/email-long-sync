#!/bin/bash

# ==========================================
# Email cron script
#
# Send emails in queue and retrieve emails
# from IMAP servers, only when connected to
# the Internet.
# ==========================================

# Thanks to msabramo:
# https://github.com/msabramo/dotfiles-1/blob/master/_mutt/msmtp-cron.sh

# Syncing email command with offlineimap:
#   -o run only once
#   -u choose interface to be quiet except in case of errors
#   -l log it to file
sync_email="offlineimap -o -u quiet -l $HOME/.offlineimap-cron.log"

# Send emails in queue with msmtp-runqueue
send_email="msmtp-runqueue.sh"

# Check connection status
if ! ping -c1 www.google.com > /dev/null 2>&1; then 
    # Ping could be firewalled ...
    # '-O -' will redirect the actual html to stdout and thus to /dev/null
    if ! wget -O - www.google.com > /dev/null 2>&1; then
        # Both tests failed. We are probably offline 
        # (or google is offline, i.e. the end has come)
        exit 1;
    fi
fi

# We are online: So let's get mail going first
(${send_email} &> ~/.msmtp-queue.log) &

# Check if offlineimap is running:
pid=$(pgrep -f offlineimap)
if [[ ${pid} -gt 0 ]] ; then
    echo "Offlineimap is running with pid ${pid}"
    exit 1
fi

# If offlineimap is not running, then:
exec ${sync_email}
