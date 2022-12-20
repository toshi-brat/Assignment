######bucket policy
resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:${var.bucket-name}/*",
          ]
      }
    ]
  })
}
resource "aws_iam_role" "ec2-access-to-S3" {
  name = "my_ec2-access-to-S3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "bucket_policy" {
  role       = aws_iam_role.ec2-access-to-S3.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

#####EC2CodeDeploy Role
resource "aws_iam_role" "devops_ec2codedeploy_role" {
  name = "devops2_ec2codedeploy_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  # tags = {
  #   Name = "devops_ec2codedeploy_role"
  # }

}
# resource "aws_iam_role_policy_attachment" "ec2_fullaccess_attach" {
#   role       = aws_iam_role.devops_ec2codedeploy_role.name
#   policy_arn = var.AmazonEC2FullAccess_arn
# }

resource "aws_iam_role_policy_attachment" "ec2_s3fullaccess_attach" {
  role       = aws_iam_role.devops_ec2codedeploy_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

# ---------------------------------
# Attach default Codedeploy policy to Role
# ---------------------------------

resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.devops_ec2codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_role" "devops_codedeploy_role" {
  name = "devops2_codedeploy_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  # #tags = {
  #   Name = "devops_codedeploy_role"
  # }

}

# resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
#   role       = aws_iam_role.devops_codedeploy_role.name
#   policy_arn = var.AWSCodedeploy_arn
# }

resource "aws_iam_instance_profile" "ec2_cd_instance_profile" {
  name = "ec2_cd_instance_profile"
  role = aws_iam_role.devops_ec2codedeploy_role.name
}