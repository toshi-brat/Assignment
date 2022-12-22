module "uat_vpc" {

  source          = "../modules/network"
  cidr            = var.cidr
  pri-snet        = var.pri-snet
  pub-snet        = var.pub-snet
  is_nat_required = true

}

resource "aws_flow_log" "vpc_flow_logs" {
  iam_role_arn         = aws_iam_role.vpc_logs_role.arn
  log_destination      = module.log_bucket.bucker_arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = module.uat_vpc.vpc-id

}

resource "aws_cloudwatch_log_group" "vpc_flow_logs_group" {
  name = "UAT_VPC_FLOW_LOGS"
}

resource "aws_iam_role" "vpc_logs_role" {
  name = "VPC_FLOW_LOGS_ROLE"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "vpc_log_policy" {
  name = "VPC_FLOW_LOGS_POLICY"
  role = aws_iam_role.vpc_logs_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}