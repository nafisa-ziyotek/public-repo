#!/bin/bash
#DNS script

clear
read -p "Please enter record type:" a
read -p "Enter server name:" b
read -p "Enter short name:" c
read -p "Enter IP address:" d
read -p "Enter last number of IP address:" e
 
echo "$b		IN	$a	$d">> /ansible/playbooks/dns/ziyotek.flz
echo "$c		IN	CNAME	$b.ziyotek.local.">> /ansible/playbooks/dns/ziyotek.flz
echo "$e	   IN	   PTR	   $b.ziyotek.local.">> /ansible/playbooks/dns/ziyotek.rlz

#systemctl restart named
echo "Thank you forward and lookup zones are updated!"

ansible-playbook dns_ansible.yml -i inventory.txt
