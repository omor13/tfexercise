

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

resource "aws_instance" "webserver" {
    count = 3
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.testsubnet.id

    vpc_security_group_ids = [aws_security_group.test-sg.id]

    tags = {
      Name = "Webserver-${count.index+1}"
    }
}

resource "aws_vpc" "testvpc" {
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "testsubnet" {
  cidr_block = "10.0.1.0/27"
  vpc_id = aws_vpc.testvpc.id
}

resource "aws_security_group" "test-sg" {
    name = "test-sg"
    description = "security group fo testing"
    vpc_id = aws_vpc.testvpc.id
    dynamic "ingress" {
      for_each = var.rules_map 
      content {
        from_port = ingress.key
        to_port = ingress.key
        protocol = "tcp"
        cidr_blocks = [ingress.value]
      }
    }
}

