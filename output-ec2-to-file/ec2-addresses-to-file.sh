#! /bin/bash

aws ec2 describe-instances \
   --query 'Reservations[*].Instances[*].PublicIpAddress' \
   --output text >> inventory