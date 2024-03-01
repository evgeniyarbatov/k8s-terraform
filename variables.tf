variable "aws_region" {
  default = "ap-southeast-1"
}

variable "master_instance_type" {
  default = "t2.micro"
}

variable "worker_instance_type" {
  default = "t2.nano"
}

variable "key_name" {
  default = "terraform"
}

variable "worker_count" {
  default = 1
}