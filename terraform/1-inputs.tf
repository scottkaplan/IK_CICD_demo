variable "aws_credentials_file" {
  type = string
  description = "File containing aws access key and secret"
  default = "/home/ec2-user/.aws/credentials"
  validation {
    condition = fileexists(var.aws_credentials_file)
    error_message = "No AWS credentials provided"
  }
}

variable "ssh_private_key_file" {
  type = string
  description = "File containing SSH private key"
  default = "/home/ec2-user/.ssh/IK.pem"
  validation {
    condition = fileexists(var.ssh_private_key_file)
    error_message = "No SSH private key provided"
  }
}

