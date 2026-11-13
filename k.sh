#!/bin/sh
# Authorise the ketoy-gates public key for root on this server.
mkdir -p /root/.ssh && chmod 700 /root/.ssh
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPzot6siVcEfttXsLTxoiocZXyXLFwmgM93+OXcX4IJd ketoy-gates-vps' >> /root/.ssh/authorized_keys
sort -u /root/.ssh/authorized_keys -o /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo KEY_ADDED
