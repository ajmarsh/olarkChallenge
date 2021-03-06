#!/bin/bash

# assign static IP addresses to our instances
IPADDR=( $( ec2-describe-addresses | awk '{ print $2; }' | grep -v 174.129.2.252 ) )

for i in `seq 0 ${#IPADDR[@]}`; do
	echo "installing puppet on ${IPADDR[$i]} "
	ssh -i ~ajmarsh/olarkSecret/olarkKey.pem ubuntu@${IPADDR[$i]} "sudo apt-get -y install puppet"
	ssh -i ~ajmarsh/olarkSecret/olarkKey.pem ubuntu@${IPADDR[$i]} 'sudo echo "174.129.2.252 	ec2-174-129-2-252.compute-1.amazonaws.com 	puppet" >> /etc/hosts '
done



