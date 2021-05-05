locals {
  shared_tags = tomap(
    {
      "Team"    = var.teamid,
      "Project" = var.prjid
    }
  )

  # NOTEBOOK
  notebook_name = var.notebook_name != null ? var.notebook_name : "${var.teamid}-${var.prjid}"

  # JOBS CLUSTER
  cluster_info = var.use_existing_cluster != true ? join("", databricks_cluster.cluster.*.id) : var.existing_cluster_id

  # NOTEBOOK SECURITY
  notebook = join("",databricks_notebook.notebook_file.*.id) != null ? join("",databricks_notebook.notebook_file.*.id) : join("", databricks_notebook.notebook_local.*.id)

  # JOBS SECURITY
  databricks_job = join("", databricks_job.databricks_job.*.id) != null ? join("", databricks_job.databricks_new_cluster_job.*.id) : join("", databricks_job.databricks_job.*.id)

  # USERS
  databricks_username = var.databricks_username != null ? var.databricks_username : "${data.databricks_current_user.me.alphanumeric}@example.com"
  databricks_displayname = var.databricks_username != null ? var.databricks_username : "${var.teamid}-${var.prjid} ${data.databricks_current_user.me.alphanumeric}"

  # GROUP NAME
  databricks_groupname = var.databricks_groupname != null ? var.databricks_groupname : "${var.teamid}-${var.prjid} (by ${data.databricks_current_user.me.alphanumeric})"

  # SCOPE NAME
  scope_name = "${var.teamid}-${var.prjid}" != null ? "${var.teamid}-${var.prjid}" : databricks_secret_scope.this.name
}
