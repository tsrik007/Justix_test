resource "aws_key_pair" "mykey" {
    key_name = "mykey"
    public_key = "${file("${var.path_to_public_key}")}"
}

resource "aws_instance" "example-instance" {
    ami = "${var.aws_ami}"
    instance_type = "m4.xlarge"
    count = "${var.server_count}"
    key_name = "${aws_key_pair.mykey.key_name}"
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = ["${aws_security_group.sg_vaultier.id}"]
    tags {
        Name = "example-instance-${count.index}"
    }

root_block_device {
    volume_size = 100
}

provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
}

provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/script.sh",
        "sudo /tmp/script.sh"
    ]
}

connection {
    host = "${self.private_ip}"
    user = "${var.username}"
    private_key   = "${file("${var.private_key}")}"
    bastion_host = "${var.bastion_host}"
}

resource "aws_security_group" "sg_example" {
    name        = "sg_vaultier"
    description = "Security Group for vaultier"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port   = 39000
        to_port     = 40000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 59000
        to_port     = 59015
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 1100
        to_port     = 1200
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #SSH
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #ICMP
    ingress {
        from_port = 8
        to_port = 0
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


#Create Route53 entries
data "aws_route53_zone" "selected" {
    zone_id      = "**************"
    private_zone = false
}

resource "aws_route53_record" "example1-record" {
    depends_on = ["aws_instance.vaultier"]
    zone_id    = "${data.aws_route53_zone.selected.zone_id}"
    name       = "exampleinstance.aws.example.com"
    type       = "A"
    ttl        = "300"
    records    = ["${aws_instance.example.private_ip}"]
}
