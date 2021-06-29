locals {
  shared_tags = tomap(
    {
      "Team"    = var.teamid,
      "Project" = var.prjid
    }
  )

  # JOBS CLUSTER
  cluster_info = var.cluster_id == null ? join("", databricks_cluster.cluster.*.id) : var.cluster_id

  # USERS
  databricks_username    = var.databricks_username != "" ? var.databricks_username : "${data.databricks_current_user.me.alphanumeric}@example.com"
  databricks_displayname = var.databricks_username != "" ? "${var.databricks_username} (Terraform managed)" : data.databricks_current_user.me.alphanumeric

  # GROUP NAME
  databricks_groupname = var.databricks_groupname != null ? var.databricks_groupname : "${var.teamid}-${var.prjid}  (Terraform managed)"

  # SCOPE NAME
  scope_name = "${var.teamid}-${var.prjid}" != null ? "${var.teamid}-${var.prjid}" : databricks_secret_scope.this.name

  user_name = var.databricks_username != "" ? var.databricks_username : join("", databricks_user.users.*.id)
}
