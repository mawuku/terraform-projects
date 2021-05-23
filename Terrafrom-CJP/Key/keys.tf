# keys.tf
  
locals {
  public_key_filename  = "${var.keypair_path}/${var.keypair_name}.pub"
  private_key_filename = "${var.keypair_path}/${var.keypair_name}.pem"
}

# Generating RSA private & public keys.
resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "cluster-keys" {
  depends_on = [tls_private_key.default]
  keyname = "cluster-keys"   # Move to variable
  public_key = tls_private_key.default.public_key_openssh
}

resource "local_file" "public_key_openssh" {
  depends_on = [tls_private_key.default]
  content    = tls_private_key.default.public_key_openssh
  filename   = local.public_key_filename
}

resource "local_file" "private_key_pem" {
  depends_on = [tls_private_key.default]
  content    = tls_private_key.default.private_key_pem
  filename   = local.private_key_filename
}

resource "null_resource" "chmod" {
  depends_on = [local_file.private_key_pem]
  provisioner "local-exec" {
    command = format("chmod 600 %v", local.private_key_filename)
  }
}
# End on keys.tf