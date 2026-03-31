#!/bin/bash

echo "Fixing S3 public access..."

BUCKETS=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

for BUCKET in $BUCKETS; do
  aws s3api put-public-access-block \
    --bucket $BUCKET \
    --public-access-block-configuration \
    BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

  echo "Secured: $BUCKET"
done