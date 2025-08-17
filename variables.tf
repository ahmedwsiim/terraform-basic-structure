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
