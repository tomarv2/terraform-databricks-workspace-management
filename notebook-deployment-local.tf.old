resource "databricks_notebook" "notebook_local" {
  count = var.deploy_notebook == true ? 1 : 0

  path     = "${data.databricks_current_user.me.home}/${local.notebook_name}-local"
  language = var.language
  content_base64 = base64encode(<<-EOT
    token = dbutils.secrets.get('${databricks_secret_scope.this.name}', '${databricks_secret.token.key}')
    print(f'This should be redacted: {token}')
    EOT
  )
}
