variable "aws_region" {
  description = "AWS region to launch instance in"
  type        = string
  default     = "eu-north-1" # Stockholm
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04 in Stockholm"
  type        = string
  default     = "ami-01b64b6deccb0e0a2" # check if valid in eu-north-1
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}
