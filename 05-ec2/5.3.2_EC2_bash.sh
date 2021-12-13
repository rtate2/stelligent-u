#!/bin/bash

cd /tmp
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm

sudo apt install rpm -y

rpm -U amazon-cloudwatch-agent.rpm --nodeps

touch /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

printf "{\n  \"agent\": {\n    \"metrics_collection_interval\": 60,\n    \"run_as_user\": \"cwagent\"\n  },\n  \"metrics\": {\n    \"append_dimensions\": {\n        \"InstanceId\": \"${aws:InstanceId}\"\n    },\n    \"metrics_collected\": {\n      \"disk\": {\n        \"measurement\": [\n          \"used_percent\"\n        ],\n        \"metrics_collection_interval\": 60,\n        \"resources\": [\n          \"/\"\n        ]\n      }\n    }\n  }\n}\n" | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

systemctl restart amazon-cloudwatch-agent