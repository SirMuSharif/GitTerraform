output "instance_ip_addr" {
  value     = tls_private_key.example_ssh3.private_key_pem
  sensitive = true

}

