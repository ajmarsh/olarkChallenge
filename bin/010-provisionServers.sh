#!/bin/bash

# This script will provision 5 servers at Amazon EC2 and assign IP addresses to them
# ajmarsh@gmail.com 6/16/2012

# set up some variables
EC2_PRIVATE_KEY=/Users/ajmarsh/olarkSecret/pk-WGOZWJT7ZQ6D2GPF5WFEMI5EMZYBYMYE.pem
EC2_CERT=/Users/ajmarsh/olarkSecret/cert-WGOZWJT7ZQ6D2GPF5WFEMI5EMZYBYMYE.pem

# rewrite as loop in case you want to expand the numebr of servers
# obtain static IP address for our instances

#IPADDR0=$(/Users/ajmarsh/ec2-api-tools/bin/ec2-allocate-address | awk '{ print $2; }' )
#IPADDR1=$(/Users/ajmarsh/ec2-api-tools/bin/ec2-allocate-address | awk '{ print $2; }' )
#IPADDR2=$(/Users/ajmarsh/ec2-api-tools/bin/ec2-allocate-address | awk '{ print $2; }' )
#IPADDR3=$(/Users/ajmarsh/ec2-api-tools/bin/ec2-allocate-address | awk '{ print $2; }' )
#IPADDR4=$(/Users/ajmarsh/ec2-api-tools/bin/ec2-allocate-address | awk '{ print $2; }' )
#
#echo $IPADDR1 $IPADDR2 $IPADDR3 $IPADDR4 $IPADDR5

# generate keypair if it does not exist
if [ -f ~ajmarsh/olarkSecret/olarkKey.pem ];
then
	echo "Using existing keys"
else
	echo "Generating new keypair"
	ec2-add-keypair olarkKey >  ~ajmarsh/olarkSecret/olarkKey.pem
	chmod 600  ~ajmarsh/olarkSecret/olarkKey.pem
fi

# launch 2 webservers 
# rewrite as loop in case you want to chage number of servers
ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey -g olarkWeb --instance-type t1.micro -z us-east-1a
ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey -g olarkWeb --instance-type t1.micro -z us-east-1a

# launch 1 haproxy server
# rewrite as loop in case you want to chage number of servers
ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey -g olarkWeb --instance-type t1.micro -z us-east-1a

# launch 2 siege util servers
# rewrite as loop in case you want to chage number of servers
ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey -g olarkWeb --instance-type t1.micro -z us-east-1a
ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey -g olarkWeb --instance-type t1.micro -z us-east-1a

# assign static IP addresses to our instances
array=( $( ec2-describe-instances | awk '{ print $2; }' | grep "i-" ) )
SERVER0=${array[0]}
SERVER1=${array[1]}
SERVER2=${array[2]}
SERVER3=${array[3]}
SERVER4=${array[4]}

# not sure what my probelm is with loops today
ec2-associate-address -i $SERVER0 $IPADDR0
ec2-associate-address -i $SERVER1 $IPADDR1
ec2-associate-address -i $SERVER2 $IPADDR2
ec2-associate-address -i $SERVER3 $IPADDR3
ec2-associate-address -i $SERVER4 $IPADDR4




