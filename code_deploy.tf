#CodeDeploy application
resource "aws_codedeploy_app" "karmah" {
  name             = var.app_name
  compute_platform = "Server"
}


#CodeDeployment group
resource "aws_codedeploy_deployment_group" "karmah_deployment_group" {
  app_name              = aws_codedeploy_app.karmah.name
  deployment_group_name = "${var.app_name}-DeploymentGroup"
  service_role_arn      = aws_iam_role.codedeploy_default_role.arn

  ec2_tag_filter {
    key   = "Environment"
    value = "karmahCodeDeploy"
    type  = "KEY_AND_VALUE"
  }


  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
