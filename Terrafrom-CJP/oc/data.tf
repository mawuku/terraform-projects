data "aws_ami" "instance_ami" {
    most_recent = true
    owners = ["amazon"]


    filter {
        name = "name"
        values = ["amzn2-ami-hvm*"]
    }
  
}

data "template_file" "userdata" {
    template = "${file("${path.module}/userdata.sh.tpl")}"

    vars = {
      "ci_version" = var.ci_version
      "java_version" = var.java_version
    }
  
}