#!/bin/bash

LOG_FILE="reports/remediation.log"
LOG_BUCKET="s3first-project-all-files"   
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo "🔍 S3 Security Scan Started at $(date)" | tee -a $LOG_FILE
echo "-----------------------------------" | tee -a $LOG_FILE

BUCKETS=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

for BUCKET in $BUCKETS; do
  echo "Checking bucket: $BUCKET" | tee -a $LOG_FILE

  BLOCK=$(aws s3api get-public-access-block \
    --bucket $BUCKET \
    --query "PublicAccessBlockConfiguration.BlockPublicAcls" \
    --output text 2>/dev/null || echo "false")

  if [ "$BLOCK" != "True" ]; then
    echo "🚨 Public access issue found in $BUCKET — fixing..." | tee -a $LOG_FILE

    aws s3api put-public-access-block \
      --bucket $BUCKET \
      --public-access-block-configuration \
      BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

    if [ $? -eq 0 ]; then
      echo "✅ Fixed: $BUCKET" | tee -a $LOG_FILE
    else
      echo "❌ Failed to fix: $BUCKET" | tee -a $LOG_FILE
    fi
  else
    echo "🔒 Already secure: $BUCKET" | tee -a $LOG_FILE
  fi

  echo "-----------------------------" | tee -a $LOG_FILE
done

echo "-----------------------------------" | tee -a $LOG_FILE
echo "📤 Uploading logs to S3..." | tee -a $LOG_FILE

aws s3 cp $LOG_FILE s3://$LOG_BUCKET/remediation-$TIMESTAMP.log

if [ $? -eq 0 ]; then
  echo "✅ Logs uploaded successfully to s3://$LOG_BUCKET/" | tee -a $LOG_FILE
else
  echo "❌ Failed to upload logs to S3" | tee -a $LOG_FILE
fi

echo "✅ Scan completed at $(date)" | tee -a $LOG_FILE