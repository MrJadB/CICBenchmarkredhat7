#!/bin/bash

# Directory to save configuration files
output_dir="cisavecon"

# List of configuration files
config_files=(
    "/etc/selinux/config"
    "/boot/grub2/grub.cfg"
    "/boot/grub2/user.cfg"
    "/etc/fstab"
    "/etc/gdm/custom.conf"
    "/etc/motd"
    "/etc/issue"
    "/etc/issue.net"
    "/etc/yum.conf"
    "/etc/yum.repos.d"
    "/etc/postfix/main.cf"
    "/etc/sysconfig/chronyd"
    "/etc/chrony.conf"
    "/etc/ssh/sshd_config"
    "/etc/modprobe.d"
    "/etc/default/ufw"
    "/etc/ufw/sysctl.conf"
    "/etc/sysctl.conf"
    "/etc/sysctl.d"
    "/etc/nftables/nftables.rules"
    "/etc/sysconfig/nftables.conf"
    "/etc/sysconfig/iptables"
    "/etc/sysconfig/ip6tables"
    "/etc/sysconfig/iptables.conf"
    "/etc/crontab"
    "/etc/audit/auditd.conf"
    "/etc/audit/audit.rules"
    "/etc/sudoers"
    "/etc/passwd"
    "/etc/shadow"
    "/etc/rsyslog.conf"
    "/etc/pam.d/system-auth"
    "/etc/pam.d/password-auth"
    "/etc/security/pwquality.conf"
    "/etc/bashrc"
    "/etc/profile"
    "/etc/profile.d"
    "/etc/login.defs"
    "/etc/securetty"
    "/etc/security/limits.conf"
    "/etc/security/limits.d"
    "/etc/systemd/system.conf"
    "/etc/systemd/user.conf"
    "/etc/gshadow"
    "/etc/hosts"
    "/etc/sysconfig/network"
    "/etc/security/opasswd"
    "/etc/bash.bashrc"
    "/etc/shells"
    "/etc/printcap"
    "/etc/sysctl.conf"
    "/etc/dconf/profile"
    "/etc/default/ufw"
    "/etc/ufw/sysctl.conf"
    "/var/log/messages"
    "/var/log/secure"
    "/var/log/audit/audit.log"
    "/var/log/firewalld"
    "/var/log/cron"
    "/var/log/maillog"
    "/boot/grub2/grubenv"
    "/var/log/tallylog"
    "/var/log/faillog"
    "/var/log/lastlog"
    "/etc/dconf/db"
    "/etc/cron.hourly"
    "/etc/cron.daily"
    "/etc/cron.weekly"
    "/etc/cron.monthly"
    "/etc/cron.d"
    "/etc/sudoers.d"
    "/etc/skel"
    "/etc/ssh/sshd_config.d"
    "/etc/sysconfig"
    "/etc/sysconfig/network-scripts"
)

# Create output directory if it does not exist
mkdir -p "$output_dir"

# Function to add section separator
add_separator() {
    echo "======================================" >> "$1"
}

# Function to save file content
save_file_content() {
    local file_path="$1"
    local output_file="$2"
    
    add_separator "$output_file"
    echo "File: $file_path" >> "$output_file"
    
    if [ -f "$file_path" ]; then
        # Check if the file is /etc/default/ufw
        if [ "$file_path" == "/etc/default/ufw" ]; then
            # Check if ufw is enabled
            if ufw status | grep -q "Status: active"; then
                cat "$file_path" >> "$output_file"
            else
                echo "UFW is not enabled" >> "$output_file"
            fi
        else
            cat "$file_path" >> "$output_file"
        fi
    else
        echo "File not found: $file_path" >> "$output_file"
    fi
}

# Loop through configuration files
for path in "${config_files[@]}"; do
    if [ -d "$path" ]; then
        find "$path" -type f -name "*.conf" | while read -r file; do
            filename=$(basename "$file")
            output_file="$output_dir/configsave$filename.txt"
            save_file_content "$file" "$output_file"
        done
    else
        filename=$(basename "$path")
        output_file="$output_dir/configsave$filename.txt"
        save_file_content "$path" "$output_file"
    fi
done

echo "Configuration files have been saved in directory: $output_dir"
