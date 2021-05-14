resource "databricks_notebook" "notebook_file" {
  for_each = var.notebook_info

  path           = "${data.databricks_current_user.me.home}/${each.key}"
  language       = lookup(each.value, "language", null)
  content_base64 = filebase64(lookup(each.value, "local_path", null))

}
