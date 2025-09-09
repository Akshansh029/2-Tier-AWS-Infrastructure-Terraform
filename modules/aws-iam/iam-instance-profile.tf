resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.iam-profile-name
  role = aws_iam_role.iam_role.name
}