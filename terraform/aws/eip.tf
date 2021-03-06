### The Elastic IP for the Loadbalancer
resource "aws_eip" "eip-loadbalancer" {
 vpc = true
 instance = aws_instance.loadbalancer.id
 associate_with_private_ip = aws_instance.loadbalancer.private_ip

 tags = {
  Name = "loadbalancer"
#   Projet = var.projet
#   Application = var.Application
 }
}

### The Elastic IP for the Bastion
resource "aws_eip" "eip-bastion" {
 vpc = true
 instance = aws_instance.bastion.id
 associate_with_private_ip = aws_instance.bastion.private_ip

 tags = {
  Name = "bastion"
#   Projet = var.projet
#   Application = var.Application
 }
}