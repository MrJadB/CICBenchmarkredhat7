
#!/bin/bash

# Output directory
output_directory="cisavecon"

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
    "/etc/security/limits.d"
    "/etc/sysconfig"
    "/etc/sysconfig/network-scripts/"
    "/etc/sysctl.d/"
    "/etc/dconf/db/*.d"
    "/etc/modprobe.d/"
    "/etc/dconf/db/gdm.d/*"
    "/etc/sysctl.d/"
    "/etc/dconf/db/*.d"
)

# Function to add section separator
add_separator() {
    echo "======================================" >> "$output_file"
}

# Loop through configuration files
for file_path in "${config_files[@]}"; do
    # Get base filename
    file_name=$(basename "$file_path")
    
    # Output file path
    output_file="$output_directory/configsave_$file_name.txt"

    # Create or clear output file
    > "$output_file"

    # Add current date and time
    echo "Date and Time: $(date)" >> "$output_file"

    # Add system information
    echo "System Information:" >> "$output_file"
    uname -a >> "$output_file"

    # Add file list and contents
    echo "File: $file_path" >> "$output_file"
    if [ -f "$file_path" ]; then
        cat "$file_path" >> "$output_file"
    else
        echo "File not found: $file_path" >> "$output_file"
    fi
done
