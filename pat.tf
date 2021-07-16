resource "databricks_secret_scope" "this" {
  count = var.deploy_cluster ? 1 : 0
  name  = "${var.teamid}-${var.prjid}"
}

/*
resource "databricks_token" "pat" {
  count = var.deploy_cluster ? 1 : 0

  comment          = "Created from ${abspath(path.module)}"
  lifetime_seconds = var.dapi_token_duration
}

resource "databricks_secret" "token" {
  count = var.deploy_cluster ? 1 : 0

  string_value = join("", databricks_token.pat.*.token_value)
  scope        = "${var.teamid}-${var.prjid}"
  key          = var.databricks_secret_key
}
*/
