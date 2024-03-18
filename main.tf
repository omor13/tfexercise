resource "aws_instance" "webserver" {
    count = 3
    ami = var.ami_image
    instance_type = var.ins_type
    lifecycle {
        create_before_destroy = true
    }

    tags = {
      Name = "webserver${count.index+1}"
    }
}

