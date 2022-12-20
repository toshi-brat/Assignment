output "instance_profile" {
  value = aws_iam_instance_profile.ec2_cd_instance_profile.name
}
output "codedeploy" {
  value = aws_iam_role.devops_codedeploy_role.arn
}