resource "databricks_notebook" "notebook_file" {
  for_each = (var.deploy_jobs != false && var.local_notebooks != null) ? { for p in var.local_notebooks : "${p.job_name}-${p.local_path}" => p } : {}

  path           = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.job_name}")
  language       = lookup(each.value, "language", "PYTHON")
  content_base64 = filebase64(lookup(each.value, "local_path", null))
}

resource "databricks_notebook" "notebook_file_deployment" {
  for_each = var.notebooks != null ? { for p in var.notebooks : "${p.name}-${p.local_path}" => p } : {}

  path           = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.name}")
  language       = lookup(each.value, "language", "PYTHON")
  content_base64 = filebase64(lookup(each.value, "local_path", null))
}
