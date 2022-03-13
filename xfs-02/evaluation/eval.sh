#!/bin/sh
grep -B 5 -A 5 "XFS_REPAIR Summary" log-*.txt | grep -v -E '\.txt-(Phase|No modify flag)' | grep -v -E -- '(- traversal finished|- moving disconnected inodes|XFS_REPAIR Summary)' | grep -v -E '^(log-[0-9]*\.txt-|--)$'

