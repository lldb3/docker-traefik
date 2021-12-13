#!/bin/sh

## This file will issue the SSH forwarding from the host to the container.
### Put me it /app/gitea/gitea

ssh -p 2222 -o StrictHostKeyChecking=no git@127.0.0.1 "SSH_ORIGINAL_COMMAND=\"$SSH_ORIGINAL_COMMAND\" $0 $@"