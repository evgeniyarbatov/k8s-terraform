data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "tf-k8s-sec-gr" {
  name = "tf-k8s-sec-gr"
  tags = {
    Name = "tf-k8s-sec-gr"
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    self      = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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