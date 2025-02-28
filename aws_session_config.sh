#!/bin/bash

# Declare all environment variables

# DevOps
DEVOPS_AWS_ACCESS_KEY_ID=""
DEVOPS_AWS_SECRET_ACCESS_KEY=""
DEVOPS_AWS_SESSION_TOKEN=""

# Development (Dev)
DEV_AWS_ACCESS_KEY_ID=""
DEV_AWS_SECRET_ACCESS_KEY=""
DEV_AWS_SESSION_TOKEN=""

# Staging (Stg)
STG_AWS_ACCESS_KEY_ID=""
STG_AWS_SECRET_ACCESS_KEY=""
STG_AWS_SESSION_TOKEN=""

# Production (Prd)
PRD_AWS_ACCESS_KEY_ID=""
PRD_AWS_SECRET_ACCESS_KEY=""
PRD_AWS_SESSION_TOKEN=""

# Function to test AWS credentials
test_aws_credentials() {
    local env_prefix=$1
    local access_key_var="${env_prefix}_AWS_ACCESS_KEY_ID"
    local secret_key_var="${env_prefix}_AWS_SECRET_ACCESS_KEY"
    local session_token_var="${env_prefix}_AWS_SESSION_TOKEN"

    export AWS_ACCESS_KEY_ID="${!access_key_var}"
    export AWS_SECRET_ACCESS_KEY="${!secret_key_var}"
    export AWS_SESSION_TOKEN="${!session_token_var}"

    echo "Testando as variáveis para: $env_prefix..."
    
    if aws s3 ls > /dev/null 2>&1; then
        echo "✅ Credenciais AWS para $env_prefix são validas."
    else
        echo "❌ Credenciais AWS para $env_prefix são invalidas ou expiradas."
    fi

    # Unset credentials after testing
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
}

test_aws_credentials "DEVOPS"
test_aws_credentials "DEV"
test_aws_credentials "STG"
test_aws_credentials "PRD"

INPUT_FILE="provider.template"
OUTPUT_FILE="provider.tf"

# Substituir as variáveis no arquivo
cp "$INPUT_FILE" "$OUTPUT_FILE"

# Substituir as variáveis usando sed
sed -i "s|\$DEVOPS_AWS_ACCESS_KEY_ID|$DEVOPS_AWS_ACCESS_KEY_ID|g" "$OUTPUT_FILE"
sed -i "s|\$DEVOPS_AWS_SECRET_ACCESS_KEY|$DEVOPS_AWS_SECRET_ACCESS_KEY|g" "$OUTPUT_FILE"
sed -i "s|\$DEVOPS_AWS_SESSION_TOKEN|$DEVOPS_AWS_SESSION_TOKEN|g" "$OUTPUT_FILE"

sed -i "s|\$DEV_AWS_ACCESS_KEY_ID|$DEV_AWS_ACCESS_KEY_ID|g" "$OUTPUT_FILE"
sed -i "s|\$DEV_AWS_SECRET_ACCESS_KEY|$DEV_AWS_SECRET_ACCESS_KEY|g" "$OUTPUT_FILE"
sed -i "s|\$DEV_AWS_SESSION_TOKEN|$DEV_AWS_SESSION_TOKEN|g" "$OUTPUT_FILE"

sed -i "s|\$STG_AWS_ACCESS_KEY_ID|$STG_AWS_ACCESS_KEY_ID|g" "$OUTPUT_FILE"
sed -i "s|\$STG_AWS_SECRET_ACCESS_KEY|$STG_AWS_SECRET_ACCESS_KEY|g" "$OUTPUT_FILE"
sed -i "s|\$STG_AWS_SESSION_TOKEN|$STG_AWS_SESSION_TOKEN|g" "$OUTPUT_FILE"

sed -i "s|\$PRD_AWS_ACCESS_KEY_ID|$PRD_AWS_ACCESS_KEY_ID|g" "$OUTPUT_FILE"
sed -i "s|\$PRD_AWS_SECRET_ACCESS_KEY|$PRD_AWS_SECRET_ACCESS_KEY|g" "$OUTPUT_FILE"
sed -i "s|\$PRD_AWS_SESSION_TOKEN|$PRD_AWS_SESSION_TOKEN|g" "$OUTPUT_FILE"

echo "✅ Substituição concluída. Arquivo atualizado: $OUTPUT_FILE"
