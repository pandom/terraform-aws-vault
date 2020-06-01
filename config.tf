data template_file "userdata" {
  template = file("${path.module}/templates/userdata.yaml")

  vars = {
    ip_address       = module.vault.private_ip[0],
    vault_conf       = base64encode(templatefile("${path.module}/templates/vault.conf",
      {
        listener     = module.vault.private_ip[0]
        ip_addresses = [module.vault.private_ip[0]]
        node_id      = var.hostname
        leader_ip    = module.vault.private_ip[0]
        kms_key_id   = aws_kms_key.this.id
      }
    ))
    slack_webhook    = var.slack_webhook
  }
}