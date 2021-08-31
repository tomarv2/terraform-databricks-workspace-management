resource "databricks_notebook" "notebook_file" {
  for_each = var.local_notebook_info != null ? { for p in var.local_notebook_info : "${p.name}-${p.local_path}" => p } : {}

  path           = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.name}")
  language       = lookup(each.value, "language", "PYTHON")
  content_base64 = filebase64(lookup(each.value, "local_path", null))
}
