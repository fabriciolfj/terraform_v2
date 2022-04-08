provider "aws" {
  region = "sa-east-1"
}

resource "aws_iam_role" "role_sqs" {
  name = "role_sqs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
            "ec2.amazonaws.com",
            "sqs.amazonaws.com"
          ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy_sqs" {
  name        = "policy_sqs"
  description = "Policy sqs e kms"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "kms:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.role_sqs.name
  policy_arn = aws_iam_policy.policy_sqs.arn
}