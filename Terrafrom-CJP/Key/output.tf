# output.tf
  
output "keypair_name" {
  value       = aws_key_pair.cluster-keys.key_name
  description = "Name of EC2 Key Pair"
}

output "keypair_private_path" {
  value       = [pathexpand(local_file.private_key_pem.filename)]
  description = "Filename of the generated private key"
}

output "keypair_public_path" {
  value       = [pathexpand(local_file.public_key_openssh.filename)]
  description = "Filename of the generated public key"
}
# end of output.tf