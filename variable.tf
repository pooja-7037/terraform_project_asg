variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ssh_key" {
    type = string
    default = "terraform_course"
}
#
# variable "security_group_id" {}

# variable "vpcid" {
#     type = string
#     default = "vpc-07e733e21a5755e17"
# }