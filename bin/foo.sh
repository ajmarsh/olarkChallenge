#!/bin/bash

SERVER=( $( ec2-describe-instances | grep -v terminated | awk '{ print $2; }' | grep "i-" ) )

echo ${SERVER[0]}
echo ${SERVER[1]}
echo ${SERVER[2]}
echo ${SERVER[3]}
