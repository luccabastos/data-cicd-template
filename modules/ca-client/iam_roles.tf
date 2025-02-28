locals {
  name = "${var.customer}"
}

# Deployer Role Resources

data "aws_iam_policy_document" "policy_data" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "CustomAdministratorAccess"
  description = "Policy with full access"
  policy      = data.aws_iam_policy_document.policy_data.json
}

resource "aws_iam_policy_attachment" "attachment" {
    name = "${local.name}-attachment"
    roles = ["${aws_iam_role.deployer_role.name}"]
    policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_role" "deployer_role" {
    name = "${local.name}-deployer-role"
    path = "/service-role/"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = "CrossAccountPolicy"
                Principal = {
                    AWS = "arn:aws:iam::${var.devops_account_id}:root"
                }
            }
        ]
    })
}

