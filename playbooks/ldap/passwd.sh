!#/bin/bash


passwd=$(tail -n 1 ldap_user_passwd)
echo "olcRootPW: $passwd" >> hdb.ldif.j2
