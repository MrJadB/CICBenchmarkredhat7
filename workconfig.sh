#!/bin/bash

# Create the Configsave directory if it doesn't exist
mkdir -p Configsave

# Define the file list
files=(
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
    "/etc/rsyslog.conf"
    "/etc/ntp.conf"
    "/etc/snmp/snmpd.conf"
    "/etc/snmpd.conf"
    "/etc/motd"
    "/etc/ssh/sshd_config"
    "/etc/issue"
    "/etc/sysctl.conf"
)

# Get the current date and time
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Get system information
sys_info=$(uname -a)

# Save system information
echo "=$timestamp" > Configsave/systeminfo.txt
echo "System Information:" >> Configsave/systeminfo.txt
echo "$sys_info" >> Configsave/systeminfo.txt

# Iterate over the file list and save their contents
for file in "${files[@]}"; do
    # Check if the file exists
    if [[ -f "$file" ]]; then
        # Get the base name of the file
        filename=$(basename "$file")

        # Save the file contents
        echo "=" >> "Configsave/configsave${filename}.txt"
        echo "Contents of $file:" >> "Configsave/configsave${filename}.txt"
        cat "$file" >> "Configsave/configsave${filename}.txt"
    else
        echo "File $file does not exist."
    fi
done

echo "Configuration files have been saved."
