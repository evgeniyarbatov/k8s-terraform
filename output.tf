output "master_ssh" {
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.master.public_ip}"
}

output "worker_ssh" {
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.worker[0].public_ip}"
}


output "master_logs" {
  value       = "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${aws_instance.master.public_ip} 'tail -f /var/log/cloud-init-output.log'"
}

output "worker_logs" {
  value       = [for instance in aws_instance.worker : "ssh -i ~/.ssh/terraform.pem -o 'StrictHostKeyChecking no' ubuntu@${instance.public_ip} 'tail -f /var/log/cloud-init-output.log'"]
}