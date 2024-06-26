#!/bin/bash

# Output file
output_file="Configsave/cisavecon.txt"

# List of configuration files
config_files=(
    "/etc/login.defs"
    "/etc/pam.d/system-auth"
    "/etc/security/pwquality.conf"
    "/etc/securetty"
    "/etc/security/faillock.conf"
    "/etc/passwd"
    "/etc/group"
    "/etc/audit/auditd.conf"
    "/var/log/secure"
    "/etc/rsyslog.conf"
    "/etc/ntp.conf"
    "/etc/snmp/snmpd.conf"
    "/etc/snmpd.conf"
    "/etc/motd"
    "/etc/ssh/sshd_config"
    "/etc/issue"
    "/etc/sysctl.conf"
)

# Create the Configsave directory if it doesn't exist
mkdir -p Configsave

# Get the current date and time
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Get system information
sys_info=$(uname -a)

# Save system information and date/time to the output file
{
    echo "="
    echo "Date and Time: $timestamp"
    echo "="
    echo "System Information:"
    echo "$sys_info"
    echo "="
} >> "$output_file"

# Iterate over the file list and save their contents to the output file
for file in "${config_files[@]}"; do
    # Check if the file exists
    if [[ -f "$file" ]]; then
        # Save the file contents
        {
            echo "="
            echo "#*#*"
            echo "File: $file"
            echo "#*#*"
            echo "="
            cat "$file"
            echo "="
        } >> "$output_file"
    else
        {
            echo "="
            echo "#*#*"
            echo "File: $file"
            echo "#*#*"
            echo "="
            echo "File not found: $file"
            echo "="
        } >> "$output_file"
        echo "File not found: $file" 1>&2  # Print warning to terminal
    fi
done

echo "Configuration files and system information have been saved in: $output_file"
