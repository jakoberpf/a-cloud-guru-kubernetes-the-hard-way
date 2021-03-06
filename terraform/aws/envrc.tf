### The Ansible inventory file
resource "local_file" "EnviromentDefinition" {
 content = templatefile("templates/envrc.tmpl",
 {
  bastion-dns = aws_eip.eip-bastion.public_dns,
  bastion-ip-public = aws_eip.eip-bastion.public_ip,
  bastion-ip-private = aws_eip.eip-bastion.private_ip,
  bastion-id = aws_instance.bastion.id,
  loadbalancer-dns = aws_eip.eip-loadbalancer.public_dns,
  loadbalancer-ip-public = aws_eip.eip-loadbalancer.public_ip,
  loadbalancer-ip-private = aws_eip.eip-loadbalancer.private_ip,
  loadbalancer-id = aws_instance.loadbalancer.id,
  masters-dns = aws_instance.master.*.private_dns,
  masters-ip = aws_instance.master.*.private_ip,
  masters-id = aws_instance.master.*.id,
  workers-dns = aws_instance.worker.*.private_dns,
  workers-ip = aws_instance.worker.*.private_ip,
  workers-id = aws_instance.worker.*.id
 }
 )
 filename = "../ansible/.envrc"
}