locals {
  devops_account_id = var.devops_account_id
}

module "ca-client-prd" {
    source = "./modules/ca-client"
    providers = {
      aws = aws.prd_account
    }

    customer = "${var.customer}-prd"
    devops_account_id = local.devops_account_id
    artifact_bucket_kms_key_arn = "x"
    artifact_bucket_name = "x"
}

module "ca-client-stg" {

    customer = "${var.customer}-stg"
    source = "./modules/ca-client"
    providers = {
      aws = aws.stg_account
    }

    devops_account_id = local.devops_account_id
    artifact_bucket_kms_key_arn = "x"
    artifact_bucket_name = "x"
}

module "ca-client-dev" {

    customer = "${var.customer}-dev"
    source = "./modules/ca-client"
    providers = {
      aws = aws.dev_account
    }

    devops_account_id = local.devops_account_id
    artifact_bucket_kms_key_arn = "x"
    artifact_bucket_name = "x"
}