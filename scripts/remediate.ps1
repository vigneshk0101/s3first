param (
    [string]$BUCKET_NAME
)

Write-Output "Fixing public access for $BUCKET_NAME"

aws s3api put-public-access-block `
  --bucket $BUCKET_NAME `
  --public-access-block-configuration `
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

Write-Output "Remediation completed"
