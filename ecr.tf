
resource "aws_ecr_repository" "bitcube_repository" {
  name                 = var.image_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  lifecycle {
    prevent_destroy = false
  }
}