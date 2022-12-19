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
          "arn:aws:s3:::mylab321/*",
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
resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2-access-to-S3.name
}
