#!/bin/bash

# Prompt for filename (without the .cfg extension)
read -p "Enter the client name (without .cfg extension): " filename

# Add .cfg extension to the filename
filename="${filename}.cfg"

# Define the directory where the file will be written
output_directory="/ansible/playbooks/nagios/clients"

# Check if the directory exists, if not, create it
if [ ! -d "$output_directory" ]; then
    mkdir -p "$output_directory"
fi

# Prompt for hostname
read -p "Enter hostname: " hostname

# Prompt for IP address
read -p "Enter IP address: " ip_address

# Host template content
template="
define host {
    use                             linux-server
    host_name                       ${hostname}
    alias                           My first Apache server
    address                         ${ip_address}
    max_check_attempts              5
    check_period                    24x7
    notification_interval           30
    notification_period             24x7
}


define service {
    use                             generic-service
    host_name                       ${hostname}
    service_description             PING
    check_command                   check_ping!100.0,20%!500.0,60%
}

define service {

use                             generic-service
host_name                       ${hostname}
service_description             SSH
check_command                   check_ssh
notifications_enabled           0
}"



# Write the template content to the specified file
echo "$template" |sudo tee "${output_directory}/$filename" > /dev/null

echo "File $filename created successfully!"

ansible-playbook adding_clients.yml -i inventory.txt                                                    
