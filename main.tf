provider "aws" {
 region = "us-west-2"
}
resource "aws_security_group" "instance" {
 name = "terraform-example-instance"
 ingress {
 from_port = 8080
 to_port = 8080
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "example" {
 ami = "ami-066333d9c572b0680"
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.instance.id]
 user_data = <<-EOF
 #!/bin/bash
 echo "Hello, World. nice week" > index.html
 nohup busybox httpd -f -p 8080 &
 EOF
 tags = {
 Name = "terraform-example"
 }
}


