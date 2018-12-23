provider "vault" {
  address = "http://127.0.0.1:8200"
}

provider "aws" {
  access_key           = "${data.vault_generic_secret.state.data["access_key"]}"
  secret_key           = "${data.vault_generic_secret.state.data["secret_key"]}"
  region     = "us-east-1"
}



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}