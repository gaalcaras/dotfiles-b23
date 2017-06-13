#!/usr/bin/env bash

# ==========================================
# Msmtp list queue
#
# List emails still in the queue.
# ==========================================

QUEUEDIR=$HOME/.msmtpqueue

for i in $QUEUEDIR/*.mail; do
  egrep -s --colour -h '(^From:|^To:|^Subject:)' "$i" || echo "No mail in queue";
  echo " "
done
