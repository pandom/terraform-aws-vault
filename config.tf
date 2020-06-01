data template_file "userdata" {
  template = file("${path.module}/templates/userdata.yaml")

  vars = {
    ip_address       = var.private_ip,
    vault_conf       = base64encode(templatefile("${path.module}/templates/vault.conf",
      {
        listener     = var.private_ip
        ip_addresses = [var.private_ip]
        node_id      = var.hostname
        leader_ip    = var.private_ip
        kms_key_id   = aws_kms_key.this.id
      }
    ))
    slack_webhook    = var.slack_webhook
  }
}