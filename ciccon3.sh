#!/bin/bash

# Output file
output_file="cicconfig.txt"

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
    "/etc/yum.repos.d/*.repo"
    "/etc/postfix/main.cf"
    "/etc/sysconfig/chronyd"
    "/etc/chrony.conf"
    "/etc/ssh/sshd_config"
    "/etc/modprobe.d/*.conf"
    "/etc/default/ufw"
    "/etc/ufw/sysctl.conf"
    "/etc/sysctl.conf"
    "/etc/sysctl.d/*.conf"
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
    "/etc/profile.d/*.sh"
    "/etc/login.defs"
    "/etc/securetty"
    "/etc/security/limits.conf"
    "/etc/security/limits.d/*.conf"
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
    "/etc/dconf/db/*.d"
    "/etc/dconf/profile"
    "/etc/cron.hourly"
    "/etc/cron.daily"
    "/etc/cron.weekly"
    "/etc/cron.monthly"
    "/etc/cron.d"
    "/etc/sudoers.d"
    "/etc/skel"
    "/etc/ssh/sshd_config.d"
    "/etc/sysconfig"
    "/etc/sysconfig/network-scripts/"
    "/etc/sysctl.d/"
    "/etc/dconf/db/*.d"
    "/etc/modprobe.d/"
    "/etc/dconf/db/gdm.d/*"
    "/etc/sysctl.d/"
    "/etc/dconf/db/*.d"
)

# Create or clear the output file
> "$output_file"

# Add current date and time
echo "======================================" >> "$output_file"
echo "Date and Time: $(date)" >> "$output_file"
echo "======================================" >> "$output_file"

# Add system information
echo "======================================" >> "$output_file"
echo "System Information:" >> "$output_file"
uname -a >> "$output_file"
echo "======================================" >> "$output_file"

# Loop through configuration files
for path in "${config_files[@]}"; do
    # Find all matching files if the path contains a wildcard
    for file in $path; do
        if [ -e "$file" ]; then
            echo "======================================" >> "$output_file"
            echo "#*#*" >> "$output_file"
            echo "File: $file" >> "$output_file"
            echo "#*#*" >> "$output_file"
            echo "======================================" >> "$output_file"
            
            # Check if the file is /etc/default/ufw
            if [ "$file" == "/etc/default/ufw" ]; then
                # Check if ufw is enabled
                if ufw status | grep -q "Status: active"; then
                    cat "$file" >> "$output_file"
                else
                    echo "UFW is not enabled" >> "$output_file"
                fi
            else
                cat "$file" >> "$output_file"
            fi
        else
            echo "File not found: $file" 1>&2  # Print warning to terminal
        fi
    done
done

echo "Configuration files have been saved in: $output_file"
