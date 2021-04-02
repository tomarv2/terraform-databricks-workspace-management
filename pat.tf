resource "databricks_secret_scope" "this" {
  name = data.databricks_current_user.me.alphanumeric
}

resource "databricks_token" "pat" {
  comment          = "Created from ${abspath(path.module)}"
  lifetime_seconds = var.dapi_token_duration
}

resource "databricks_secret" "token" {
  string_value = databricks_token.pat.token_value
  scope        = databricks_secret_scope.this.name
  key          = var.databricks_secret_key
}
