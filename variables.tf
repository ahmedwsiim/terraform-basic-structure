variable "aws_region" {
  description = "AWS region to deploy"
  type        = string
  default     = "eu-north-1" # Stockholm
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS EC2 Key Pair name (must exist in AWS)"
  type        = string
  default     = "ec2-systems-limited"
}
