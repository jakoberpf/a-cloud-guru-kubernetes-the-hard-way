### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("templates/inventory.tmpl",
 {
  bastion-dns = aws_eip.eip-bastion.public_dns,
  bastion-ip = aws_eip.eip-bastion.public_ip,
  bastion-id = aws_instance.bastion.id,
  loadbalancer-dns = aws_eip.eip-loadbalancer.private_dns,
  loadbalancer-ip = aws_eip.eip-loadbalancer.private_ip,
  loadbalancer-id = aws_instance.loadbalancer.id,
  masters-dns = aws_instance.master.*.private_dns,
  masters-ip = aws_instance.master.*.private_ip,
  masters-id = aws_instance.master.*.id,
  workers-dns = aws_instance.worker.*.private_dns,
  workers-ip = aws_instance.worker.*.private_ip,
  workers-id = aws_instance.worker.*.id
 }
 )
 filename = "../ansible/inventory"
}