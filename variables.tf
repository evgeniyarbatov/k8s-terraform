variable "aws_region" {
  default = "ap-southeast-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "terraform"
}

variable "worker_count" {
  default = 1
}