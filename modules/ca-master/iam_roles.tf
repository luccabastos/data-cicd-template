# resource "aws_iam_role" "cloudformation_role" {
#   name               = "CloudFormationRole"
#   assume_role_policy = jsonencode({
#     Statement = [{
#       Effect = "Allow"
#       Principal = {
#         Service = "cloudformation.amazonaws.com"
#       }
#       Action = "sts:AssumeRole"
#     }]
#     Version = "2012-10-17"
#   })

#   managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
# }

# resource "aws_iam_role" "codebuild_role" {
#   name               = "CodeBuildRole"
#   assume_role_policy = jsonencode({
#     Statement = [{
#       Effect = "Allow"
#       Principal = {
#         Service = "codebuild.amazonaws.com"
#       }
#       Action = "sts:AssumeRole"
#     }]
#     Version = "2012-10-17"
#   })
  
#   inline_policy {
#     name = "codebuild-service"
#     policy = jsonencode({
#       Version = "2012-10-17"
#       Statement = [{
#         Effect   = "Allow"
#         Action   = "*"
#         Resource = "*"
#       }]
#     })
#   }
# }

# resource "aws_iam_role" "codepipeline_role" {
#   name               = "CodePipelineRole"
#   assume_role_policy = jsonencode({
#     Statement = [{
#       Effect = "Allow"
#       Principal = {
#         Service = "codepipeline.amazonaws.com"
#       }
#       Action = "sts:AssumeRole"
#     }]
#     Version = "2012-10-17"
#   })

#   inline_policy {
#     name = "codepipeline-service"
#     policy = jsonencode({
#       Version = "2012-10-17"
#       Statement = [{
#         Effect   = "Allow"
#         Action   = [
#           "codecommit:GetBranch",
#           "codecommit:GetCommit",
#           "codecommit:UploadArchive",
#           "codecommit:GetUploadArchiveStatus",
#           "codecommit:CancelUploadArchive",
#           "codebuild:*"
#         ]
#         Resource = "*"
#       }]
#     })
#   }
# }
