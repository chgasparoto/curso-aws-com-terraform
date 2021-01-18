locals {
  conn_type    = "ssh"
  conn_user    = "ec2-user"
  conn_timeout = "1m"

  # conn_key     = "${tls_private_key.pkey.private_key_pem}"

  conn_key = file("~/Downloads/Firefox/cleber.pem")
}
