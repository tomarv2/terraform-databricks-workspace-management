resource "databricks_notebook" "this" {
  path     = "${data.databricks_current_user.me.home}/${local.notebook_name}-local"
  language = var.language
  content_base64 = base64encode(<<-EOT
    token = dbutils.secrets.get('${databricks_secret_scope.this.name}', '${databricks_secret.token.key}')
    print(f'This should be redacted: {token}')
    EOT
  )
}
