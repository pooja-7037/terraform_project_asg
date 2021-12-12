data "aws_ami" "ubuntu_20" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}
 
data "aws_vpc" "default" {
  default = true
} 

data "aws_subnet_ids" "test_subnet_ids" {
  vpc_id = data.aws_vpc.default.id
}
# data "aws_subnet" "test_subnet" {
#   count = "${length(data.aws_subnet_ids.test_subnet_ids.ids)}"
#   id    = "${tolist(data.aws_subnet_ids.test_subnet_ids.ids)[count.index]}"
# }

# data "aws_security_group" "sg_20" {
#   id = var.security_group_id
# }