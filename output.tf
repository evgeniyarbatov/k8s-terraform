output "master_ssh_command" {
  description = "SSH to master"
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.master.public_ip} 'tail -f /var/log/cloud-init-output.log'"
}

output "worker_ssh_command" {
  description = "SSH to worker"
  value       = [for instance in aws_instance.worker : "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${instance.public_ip} 'tail -f /var/log/cloud-init-output.log'"]
}