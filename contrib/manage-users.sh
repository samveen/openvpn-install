#!/bin/bash
# Succinct wrapper for OpenVPN user management using openvpn-install.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
INSTALL_SCRIPT="${SCRIPT_DIR}/../openvpn-install.sh"

function usage() {
    echo "Usage: $0 {create|revoke|status} [username]"
    exit 1
}

if [[ $# -lt 1 ]]; then
    usage
fi

ACTION=$1
CLIENT=$2

case "$ACTION" in
    create)
        if [[ -z "$CLIENT" ]]; then usage; fi
        sudo "${INSTALL_SCRIPT}" client add "$CLIENT"
        ;;
    revoke)
        if [[ -z "$CLIENT" ]]; then usage; fi
        sudo "${INSTALL_SCRIPT}" client revoke --force "$CLIENT"
        ;;
    status)
        sudo "${INSTALL_SCRIPT}" client list
        ;;
    *)
        usage
        ;;
esac
