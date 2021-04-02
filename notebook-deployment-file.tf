resource "databricks_notebook" "notebook_from_file" {
  path           = "${data.databricks_current_user.me.home}/${local.notebook_name}-file"
  language       = var.language
  content_base64 = filebase64(var.notebook_path)

}
