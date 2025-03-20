#!/bin/bash

# Navigate to the terraform folder
echo "Getting terraform outputs..."
cd ../../terraform/environments/dev || exit

# Read terraform outputs
ADMIN_SITE_BUCKET=$(terraform output -raw admin_site_bucket)
ADMIN_SITE_URL=$(terraform output -raw admin_site_url)
ADMIN_APIGATEWAYURL=$(terraform output -raw admin_api_gateway_url)
LANDING_APP_SITE_BUCKET=$(terraform output -raw landing_site_bucket)
LANDING_APP_SITE_URL=$(terraform output -raw landing_site_url)
ADMIN_USERPOOL_ID=$(terraform output -raw admin_user_pool_id)
ADMIN_APPCLIENTID=$(terraform output -raw admin_app_client_id)

# Get AWS region
REGION=$(aws configure get region)

# Navigate back to the original directory
cd ../ || exit


# Configuring admin UI

echo "aws s3 ls s3://$ADMIN_SITE_BUCKET"
if ! aws s3 ls "s3://${ADMIN_SITE_BUCKET}"; then
echo "Error! S3 Bucket: $ADMIN_SITE_BUCKET not readable"
exit 1
fi

cd ../../src/client/Admin/ || exit # stop execution if cd fails

echo "Configuring environment for Admin Client"
cat <<EoF >./src/environments/environment.prod.ts
export const environment = {
  production: true,
  apiUrl: '$ADMIN_APIGATEWAYURL',
};
EoF

cat <<EoF >./src/environments/environment.ts
export const environment = {
  production: false,
  apiUrl: '$ADMIN_APIGATEWAYURL',
};
EoF

cat <<EoF >./src/aws-exports.ts
const awsmobile = {
    "aws_project_region": "$REGION",
    "aws_cognito_region": "$REGION",
    "aws_user_pools_id": "$ADMIN_USERPOOL_ID",
    "aws_user_pools_web_client_id": "$ADMIN_APPCLIENTID",
};

export default awsmobile;
EoF

npm install && npm run build

echo "aws s3 sync --delete --cache-control no-store dist s3://${ADMIN_SITE_BUCKET}"
aws s3 sync --delete --cache-control no-store dist "s3://${ADMIN_SITE_BUCKET}"

if [[ $? -ne 0 ]]; then
exit 1
fi

echo "Completed configuring environment for Admin Client"

# Configuring landing UI

echo "aws s3 ls s3://${LANDING_APP_SITE_BUCKET}"
if ! aws s3 ls "s3://${LANDING_APP_SITE_BUCKET}"; then
echo "Error! S3 Bucket: $LANDING_APP_SITE_BUCKET not readable"
exit 1
fi

cd ../

cd Landing || exit # stop execution if cd fails

echo "Configuring environment for Landing Client"

cat <<EoF >./src/environments/environment.prod.ts
export const environment = {
  production: true,
  apiGatewayUrl: '$ADMIN_APIGATEWAYURL'
};
EoF
  cat <<EoF >./src/environments/environment.ts
export const environment = {
  production: false,
  apiGatewayUrl: '$ADMIN_APIGATEWAYURL'
};
EoF

npm install && npm run build

echo "aws s3 sync --delete --cache-control no-store dist s3://${LANDING_APP_SITE_BUCKET}"
aws s3 sync --delete --cache-control no-store dist "s3://${LANDING_APP_SITE_BUCKET}"

if [[ $? -ne 0 ]]; then
exit 1
fi

echo "Completed configuring environment for Landing Client"
echo "Successfully completed deploying Admin UI and Landing UI"
cd ../../../terraform/environments/dev/
echo "Admin site URL: https://$ADMIN_SITE_URL"
echo "Landing site URL: https://$LANDING_APP_SITE_URL"
