output "instance_id" {
  description = "ID of the EC2 Instance"
  value       = aws_instance.obn_devops_nserbin_sbx_ec2.*.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.obn_devops_nserbin_sbx_ec2.*.public_ip
}