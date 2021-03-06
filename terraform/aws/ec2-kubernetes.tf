resource "aws_instance" "master" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.private_subnet.0.id
  vpc_security_group_ids = [
    aws_security_group.ass_open.id
  ]
  key_name = aws_key_pair.jakoberpf.key_name

  tags = {
    Name        = "master-${count.index}"
    Environment = var.environment
  }

  count = 3
}

resource "aws_instance" "worker" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.private_subnet.0.id
  vpc_security_group_ids = [
    aws_security_group.ass_open.id
  ]
  key_name = aws_key_pair.jakoberpf.key_name

  tags = {
    Name        = "worker-${count.index}"
    Environment = var.environment
  }

  count = 3
}

