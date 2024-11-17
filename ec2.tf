/* ====== CodeDeploy Public EC2 ====== */
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "karmah-ec2"

  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.key_name.key_name
  monitoring                  = false
  vpc_security_group_ids      = [module.bitcube_ec2_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  ami                         = var.ami
  iam_instance_profile        = aws_iam_instance_profile.karmah_ec2_instance_profile.name

  user_data = file("public _user-data.sh")
  tags = {
    Name        = "karmah-ec2"
    Environment = "karmahCodeDeploy"
  }
}


/* ====== Backend Private EC2 ====== */
module "backend_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "karmah-backend"

  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.key_name.key_name
  monitoring                  = false
  vpc_security_group_ids      = [module.bitcube_ec2_sg.security_group_id]
  subnet_id                   = module.vpc.private_subnets[0]
  associate_public_ip_address = false
  ami                         = var.ami
  iam_instance_profile        = aws_iam_instance_profile.karmah_ec2_instance_profile.name

  user_data = file("private_user_data.sh")
}

/* ====== Key_pair ====== */
data "aws_key_pair" "key_name" {
  key_name = "karma_ec2_kp"  
}