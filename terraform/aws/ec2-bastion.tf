data "template_file" "bastion" {
  template = templatefile("templates/b_cloud_config.tmpl",
    {
      private_key = file("~/.ssh/id_rsa")
      public_key  = file("~/.ssh/id_rsa.pub")
    }
  )
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet.0.id
  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]
  key_name = aws_key_pair.jakoberpf.key_name

  user_data = data.template_file.bastion.rendered

  tags = {
    Name        = "bastion"
    Environment = var.environment
  }
}
