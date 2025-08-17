variable "aws_region" {
  description = "AWS region to deploy EC2"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 (Amazon Linux 2)"
  default     = "ami-0cca134ec43cf708f" # ap-south-1 Amazon Linux 2 AMI
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}
