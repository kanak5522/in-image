provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0fa8fe6f147dc938b"  # Replace with a valid AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
