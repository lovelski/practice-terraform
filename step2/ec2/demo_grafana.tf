resource "aws_instance" "demo_grafana" {
  ami                  = data.aws_ami.ubuntu.id
  availability_zone    = data.aws_availability_zones.available.names[0]
  key_name             = var.ec2["key_pair"]
  instance_type        = var.ec2_grafana["instance_type"]
  vpc_security_group_ids = [
    data.terraform_remote_state.sg_data.outputs.demo_grafana_sg_id,
  ]

  subnet_id                   = data.terraform_remote_state.vpc_data.outputs.demo_public_subnet_1_id
  associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
# grafana install
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common awscli unzip dos2unix


# set password
echo "ubuntu:${var.ec2["password"]}" | chpasswd
sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
service sshd restart
  EOF

  tags = {
    Name = var.ec2_grafana["name"]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = var.ec2["password"]
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo add-apt-repository \"deb https://packages.grafana.com/oss/deb stable main\"",
      "sudo wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -",
      "sudo apt-get update",
      "sudo apt-get install -y grafana",
      "sleep 20",
      "sudo systemctl daemon-reload",
      "sudo systemctl start grafana-server",
      "sudo systemctl enable grafana-server",
    ]
  }

  depends_on = ["aws_instance.demo_es"]
}