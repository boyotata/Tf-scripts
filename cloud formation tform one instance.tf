provider "aws" { 
  region = "eu-west-2" 
  profile = "thomas"
  }


resource "aws_instance" "my_instance" {
  ami           = "ami-01e479df1702f1d13" # Replace with a valid AMI ID
  instance_type = "t2.micro" # Change instance type as needed
  
  tags = {
    Name = "MyTerraformInstance"
  }
}

output "instance_id" {
  value = aws_instance.my_instance.id
}