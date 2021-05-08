locals {
  shared_tags = tomap(
    {
      "Team"    = var.teamid,
      "Project" = var.prjid
    }
  )

  # JOBS CLUSTER
  cluster_info = var.cluster_id == null ? join("", databricks_cluster.cluster.*.id) : var.cluster_id

  # JOBS SECURITY
  #databricks_job = join("", databricks_job.databricks_job.*.id) != null ? join("", databricks_job.databricks_new_cluster_job.*.id) : join("", databricks_job.databricks_job.*.id)

  # USERS
  databricks_username    = var.databricks_username != null ? var.databricks_username : "${data.databricks_current_user.me.alphanumeric}@example.com"
  databricks_displayname = var.databricks_username != null ? var.databricks_username : "${var.teamid}-${var.prjid} ${data.databricks_current_user.me.alphanumeric}"

  # GROUP NAME
  databricks_groupname = var.databricks_groupname != null ? var.databricks_groupname : "${var.teamid}-${var.prjid} (by ${data.databricks_current_user.me.alphanumeric})"

  # SCOPE NAME
  scope_name = "${var.teamid}-${var.prjid}" != null ? "${var.teamid}-${var.prjid}" : databricks_secret_scope.this.name
}
