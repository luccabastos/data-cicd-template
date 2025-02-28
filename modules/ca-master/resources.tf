resource "random_pet" "bucket_suffix" {
    length = 5
}

locals {
    buckets = ["artifact_bucket", "cache_bucket"]
}

# Bucket Resources

resource "aws_s3_bucket" "this" {
    for_each = toset(local.buckets)

    bucket = "${var.customer}-${each.value}-${random_pet.bucket_suffix[each.value].id}"
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
    for_each = aws_s3_bucket.this

    bucket = each.value.id

    rule {
        id = "auto-cleanup"
        status = "Enabled"
        expiration {
            days = 30
        }
    }
}

resource "aws_s3_bucket_versioning" "this" {
    for_each = aws_s3_bucket.this

    bucket = each.value.id

    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_acl" "this" {
  for_each = aws_s3_bucket.this

  bucket = each.value.id

  acl = "private"
}

# Bucket Polices

# data "aws_iam_policy_document" "artifact_bucket_policy" {
#     statement {
#         sid = "DenyUnEncryptedObjectUploads"
#         effect = "Deny"
#         principals {
#             type = "*"
#             identifiers = ["*"]
#         }
#         actions = ["s3:*"]
#         resources = ["${aws_s3_bucket.this["artifact_bucket"].arn}/*"]
#         condition {
#             test = "Bool"
#             variable = "aws:SecureTransport"
#             values = ["false"]
#         }
#     }
# }


