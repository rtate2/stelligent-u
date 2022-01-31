#!/bin/bash -x

## figure out which environment are we in (dev/test/prod/infra), store that as
## a variable $ENV. Pass the value of that variable through the remainder of
## this userdata script.
# HOST="$(curl -s http://169.254.169.254/latest/meta-data/instance-id | cut -d "-" -f2)"
# REGION="$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document/ | grep region | awk '{print $3}' | tr -d '"' | tr -d ',')"
# ENV="$(echo "$(curl -s http://169.254.169.254/latest/meta-data/public-keys/ | cut -d "=" -f2)" | awk '{print tolower($0)}')"
# ENV_dash=${ENV/_/-}
REGION="$(aws configure get region)"
echo $REGION

echo "BEGIN USER DATA SCRIPT"

set +o xtrace       # Switch xtrace off

declare -a secureString_array
secureString_array=(item1 item2 item3 item4)

#### Type: SecureString Parameters ####
secureString_array[0]=/atate_aa/stelligent-u/lab11/middle-name
secureString_array[1]=/atate_aa/stelligent-u/lab11/first-name
secureString_array[2]=/atate_aa/stelligent-u/lab11/last-name
secureString_array[3]=/atate_aa/stelligent-u/lab11/nick-name


declare -a String_array
String_array=(item1 item2 item3 item4)

#### Type: String Parameters ####
String_array[0]=/etate_aa/stelligent-u/lab11/middle-name
String_array[1]=/etate_aa/stelligent-u/lab11/first-name
String_array[2]=/etate_aa/stelligent-u/lab11/last-name
String_array[3]=/etate_aa/stelligent-u/lab11/nick-name

set -o xtrace       # Switch xtrace back on

echo "Current parameters in Parameter Store"
echo ${secureString_array[@]}
echo ${String[@]}

if [[ $REGION = us-east-1 ]]
then
  for i in "${secureString_array[@]}"
  do
    aws ssm put-parameter --name $i --description 'CHANGE_ME' --value CHANGE_ME --type SecureString --key-id alias/aws/ssm
  done

  for j in "${String_array[@]}"
  do
    aws ssm put-parameter --name $j --description 'CHANGE_ME' --value CHANGE_ME --type SecureString --key-id alias/aws/ssm
  done
# elif [[]]
# else
fi




## SecureString
# aws ssm put-parameter --name <Add Parameter Name> --description <Optional> --value <CHANGE_ME> --type SecureString --key-id <Optional>

## String
# aws ssm put-parameter --name <Add Parameter Name> --description <Optional> --value <CHANGE_ME> --type String


echo "END USER DATA SCRIPT"

# When/where will this script be run?
# How to get environment variables
# If ENV = uep_dev
# run this code
#  Else 