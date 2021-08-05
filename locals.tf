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

  # WORKER NODE TYPE
  worker_node_type = var.worker_node_type_id != null ? var.worker_node_type_id : join("", data.databricks_node_type.cluster_node_type.*.id)

  # DRIVER NODE TYPE
  driver_node_type = var.driver_node_type_id != null ? var.driver_node_type_id : join("", data.databricks_node_type.cluster_node_type.*.id)
}
