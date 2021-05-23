resource "aws_instance" "primary"{
    instance_type                = var.instance_type
    ami                          = data.aws_ami.instance_ami.id
    security_groups              = var.security_groups
    iam_instance_profile         = var.instance_profile
    key_name                     = module.key.keypair_name
    source_dest_check            = var.source_dest_check
    subnet_id                    = module.vpc.vpc_subnet
    user_data                    = base64encode(data.template_file.userdata.rendered)
    associate_public_ip_address  = var.associate_public_ip_address
    availability_zone            = var.availability_zone
    ebs_optimized                = var.ebs_optimized
    monitoring                   = var.monitoring
 
    root_block_device {
        volume_size           = var.root_volume_size
        volume_type           = var.root_volume_type
        delete_on_termination = var.root_delete_on_termination
    }

    ebs_block_device {
        volume_size           = var.ebs_volume_size
        volume_type           = var.ebs_volume_type
        delete_on_termination = var.ebs_delete_on_termination
    }


    tags = {

    }
}