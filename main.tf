terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "policy_json" {
  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user" "project4_user" {
  name = "project4-user-v2"
}

resource "aws_iam_policy" "s3_read_policy" {
  name   = "Project4S3ReadPolicy"
  policy = var.policy_json
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.project4_user.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}

output "iam_user_name" {
  value = aws_iam_user.project4_user.name
}

output "policy_arn" {
  value = aws_iam_policy.s3_read_policy.arn
}
