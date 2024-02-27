output "instance_ssh_command" {
  description = "Command to SSH to AWS instance"
  value       = "ssh -i ~/.ssh/terraform.pem ubuntu@${aws_instance.app_server.public_ip} 'tail -f /var/log/cloud-init-output.log'"
}