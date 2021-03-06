resource "aws_instance" "loadbalancer" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet.0.id
  vpc_security_group_ids = [
    aws_security_group.loadbalancer.id
  ]

  key_name = aws_key_pair.jakoberpf.key_name

  tags = {
    Name        = "loadbalancer"
    Environment = var.environment
  }
}
