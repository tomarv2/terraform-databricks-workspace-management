resource "databricks_notebook" "notebook_file" {
  count = var.deploy_notebook == true ? 1 : 0

  path           = "${data.databricks_current_user.me.home}/${local.notebook_name}-file"
  language       = var.language
  content_base64 = filebase64(var.notebook_path)

}
