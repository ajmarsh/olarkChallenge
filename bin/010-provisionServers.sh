#!/bin/bash

# This script will provision 5 servers at Amazon EC2 and assign IP addresses
# to them
# ajmarsh@gmail.com 6/16/2012

# variable block (think about seperate environment file if this gets much longer)
EC2_PRIVATE_KEY=/Users/ajmarsh/olarkSecret/pk-WGOZWJT7ZQ6D2GPF5WFEMI5EMZYBYMYE.pem
EC2_CERT=/Users/ajmarsh/olarkSecret/cert-WGOZWJT7ZQ6D2GPF5WFEMI5EMZYBYMYE.pem
# Number of servers to deploy
n_web=2
n_proxy=1
n_load=2
n_total=$(( $n_web + $n_proxy + $n_load ))


# obtain static IP address for our instances
echo "obtaining your IP addresses, this will take a moment..."

for i in `seq 0 $n_total`; do
    IPADDR[$i]=$( /Users/ajmarsh/ec2-api-tools/bin/ec2-allocate-address | awk '{ print $2; }' )
done

echo " your IP addresses : "

for i in `seq 0 $n_total`; do
	echo "${IPADDR[$i]} "
done

# generate keypair if it does not exist

if [ -f ~ajmarsh/olarkSecret/olarkKey.pem ];
then
	echo "Using existing keys"
else
	echo "Generating new keypair"
	ec2-add-keypair olarkKey >  ~ajmarsh/olarkSecret/olarkKey.pem
	chmod 600  ~ajmarsh/olarkSecret/olarkKey.pem
fi

# launch N webservers
for i in `seq 1 $n_web`; do
	ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey \
		-g olarkSec --instance-type t1.micro -z us-east-1a
done

# launch N haproxy server
for i in `seq 1 $n_proxy`; do
	ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey \
		-g olarkSec --instance-type t1.micro -z us-east-1a
done

# launch N siege load test servers
for i in `seq 1 $n_load`; do
	ec2-run-instances ami-a29943cb -K $EC2_PRIVATE_KEY -C $EC2_CERT -k olarkKey \
		-g olarkSec --instance-type t1.micro -z us-east-1a
done

# assign static IP addresses to our instances
SERVER=( $( ec2-describe-instances | grep -v terminated | awk '{ print $2; }' | grep "i-" ) )

for i in `seq 0 $n_total` ; do
	ec2-associate-address -i ${SERVER[$i]} ${IPADDR[$i]}
done

ec2-describe-addresses


