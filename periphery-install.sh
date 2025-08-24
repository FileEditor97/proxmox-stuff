#!/usr/bin/env bash

# Copyright (c) 2021-2025 community-scripts ORG
# Author: FileEditor97
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://github.com/moghtech/komodo

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Setup Python3"
$STD apt-get install -y python3-venv
msg_ok "Setup Python3"

msg_info "Setup Periphery"
curl -fsSL -o setup-periphery.py https://raw.githubusercontent.com/moghtech/komodo/main/scripts/setup-periphery.py
$STD python3 setup-periphery.py
msg_ok "Setup Periphery"

msg_info "Starting Service"
systemctl enable -q --now periphery
msg_ok "Started Service"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
