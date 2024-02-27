output "master_ssh_command" {
  description = "SSH to master"
  value       = "Master: ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.master.public_ip}"
}

output "worker_ssh_command" {
  description = "SSH to worker"
  value       = { for k, v in aws_instance.worker : k => "Worker: ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${v.public_ip}" }
}