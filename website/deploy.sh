#!/bin/bash

# Equilateral AI Website Deployment Script
# Deploys the website to S3 bucket and invalidates CloudFront cache

echo "🚀 Deploying Equilateral AI Website..."

# Configuration
S3_BUCKET="equilateral"
CLOUDFRONT_DISTRIBUTION_ID="E2ZVEWGDO83XS0"
AWS_PROFILE="media-sso"

# Deploy to S3
echo "📤 Syncing files to S3 bucket: $S3_BUCKET"
aws s3 sync . s3://$S3_BUCKET --profile $AWS_PROFILE --delete

# Invalidate CloudFront cache
echo "🔄 Invalidating CloudFront cache..."
INVALIDATION_ID=$(aws cloudfront create-invalidation \
  --distribution-id $CLOUDFRONT_DISTRIBUTION_ID \
  --paths "/*" \
  --profile $AWS_PROFILE \
  --query 'Invalidation.Id' \
  --output text)

echo "✅ Deployment complete!"
echo "🌐 Site will be live at https://equilateral.ai once cache invalidation completes"
echo "📋 CloudFront Invalidation ID: $INVALIDATION_ID"
echo "⏱️  Cache invalidation typically takes 2-5 minutes"