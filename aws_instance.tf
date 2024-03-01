resource "aws_instance" "master" {
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.tf-k8s-sec-gr.id]

  user_data = file("master-init-script.sh")

  tags = {
    Name = "k8s-master"
  }
}

resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.tf-k8s-sec-gr.id]

  user_data = templatefile(
    "worker-init-script.tftpl",
    {
      region         = var.aws_region
      master-id      = aws_instance.master.id
      master-private = aws_instance.master.private_ip
    }
  )

  tags = {
    Name = "k8s-worker-${count.index + 1}"
  }
  depends_on = [aws_instance.master]
}