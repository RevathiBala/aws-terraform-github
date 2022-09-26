resource "aws_instance" "app_server" {
  count                  = 1
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.example.key_name
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  provisioner "file" {
    source      = "staging"
    destination = "/tmp/staging"
  } 
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install java-1.8.0-openjdk",
      "cd /tmp/staging",
      "java -jar aws-terraform-github-0.0.1-SNAPSHOT.jar"
    ]
  }
  tags = {
    Name = var.tags 
  }
  connection {
    type    = "ssh"
    host    = self.public_ip
    port	= 22
    user    = "ec2-user"
    timeout = "2m"
    agent 	= false
    private_key = var.private_key
  }

}

data "aws_security_group" "selected" {
  name = var.security_group 
}

data "aws_key_pair" "example" {
  key_name           = var.key_name 
}
