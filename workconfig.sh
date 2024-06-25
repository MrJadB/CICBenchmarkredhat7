#!/bin/bash

# Directory to save the config files
output_dir="Configsave"

# List of configuration files
config_files=(
    "/etc/login.defs"
    "/etc/pam.d/system-auth"
    "/etc/security/pwquality.conf"
    "/etc/securetty"
    "/etc/security/faillock.conf"
    "/etc/passwd"
    "/etc/group"
    "/etc/audit/audit.conf"
    "/var/log/secure"
    "/etc/syslog.conf"
    "/etc/rsyslog.conf"
    "/etc/ntp.conf"
    "/etc/snmp/snmpd.conf"
    "/etc/snmpd.conf"
    "/etc/motd"
    "/etc/ssh/sshd_config"
    "/etc/issue"
    "/etc/sysctl.conf"
)

# Create output directory if it does not exist
mkdir -p "$output_dir"

# Function to add section separator
add_separator() {
    echo "======================================" >> "$1"
}

# Function to save configuration file content
save_config() {
    local file=$1
    local output_file="$output_dir/configsave$(basename $file).txt"

    # Add current date and time
    add_separator "$output_file"
    echo "Date and Time: $(date)" >> "$output_file"

    # Add system information
    add_separator "$output_file"
    echo "System Information:" >> "$output_file"
    uname -a >> "$output_file"

    # Add file content
    add_separator "$output_file"
    echo "File: $file" >> "$output_file"
    if [ -f "$file" ]; then
        cat "$file" >> "$output_file"
    else
        echo "File not found: $file" >> "$output_file"
    fi
}

# Loop through the list of configuration files and save their content
for file in "${config_files[@]}"; do
    save_config "$file"
done
