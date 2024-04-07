resource "aws_instance" "my_vm" {
  count         = 2
  ami           = var.ec2_ami
  instance_type = var.instance_type
  tags = {
    Name = "Roksolana Protsiv ${count.index + 1}"
  }
}

resource "local_file" "tf_ip" {
  content  = "[ALL]\n${join("\n", [for vm in aws_instance.my_vm: vm.public_ip])}\nansible_ssh_user=ubuntu"
  filename = "./inventory"
}