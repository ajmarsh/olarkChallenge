#!/bin/bash

# assign static IP addresses to our instances
array=( $( ec2-describe-addresses | awk '{ print $2; }' ) )
IPADDR0=${array[0]}
IPADDR1=${array[1]}
IPADDR2=${array[2]}
IPADDR3=${array[3]}
IPADDR4=${array[4]}

ssh -i ~ajmarsh/olarkSecret/olarkKey.pem ubuntu@$IPADDR0 "sudo apt-get -y install puppet"
ssh -i ~ajmarsh/olarkSecret/olarkKey.pem ubuntu@$IPADDR1 "sudo apt-get -y install puppet"
ssh -i ~ajmarsh/olarkSecret/olarkKey.pem ubuntu@$IPADDR3 "sudo apt-get -y install puppet"
ssh -i ~ajmarsh/olarkSecret/olarkKey.pem ubuntu@$IPADDR4 "sudo apt-get -y install puppet"
ssh -i ~ajmarsh/olarkSecret/olarkKey.pem ubuntu@$IPADDR5 "sudo apt-get -y install puppet"


