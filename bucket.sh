#!/bin/bash

# PARAMS
BUCKET_NAME="udagram-code-bucket-df002"
PROFILE_NAME="UdacityAdmin"
REGION="us-west-2"

usage() { 
        echo "Usage $0 [-c | create] [-d | delete] [-h|help]" 
        exit 0
}

while getopts "cd:" opt;
do
   case "${opt}" in
   c)
       OPTION="CREATE"
   ;;
   d)
       OPTION="DELETE"
   ;;
   *)
       usage
   ;;
   esac
done
shift $(($OPTIND-1))

if [ -z "${OPTION}" ];
then
  usage
fi


create(){
  aws s3 mb s3://${1} --profile ${2} --region ${3}
}

delete(){
  aws s3 rb s3://${1} --force --profile ${2}
}

copyToS3(){
  aws s3 cp ./substacks/ s3://${1}/substacks/ --recursive --profile ${2}
  aws s3 cp ./src/ s3://${1}/src/ --recursive --profile ${2}
}

main(){
  [ "${OPTION}" = "CREATE" ] && create "${BUCKET_NAME}" "${PROFILE_NAME}" "${REGION}" && copyToS3 "${BUCKET_NAME}" "${PROFILE_NAME}"   
  [ "${OPTION}" = "DELETE" ] && delete "${BUCKET_NAME}" "${PROFILE_NAME}"
}

main