resource "databricks_notebook" "notebook_file" {
  for_each = var.local_notebooks != null ? { for p in var.local_notebooks : "${p.job_name}-${p.local_path}" => p } : {}

  path           = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.job_name}")
  language       = lookup(each.value, "language", "PYTHON")
  content_base64 = filebase64(lookup(each.value, "local_path", null))
}
