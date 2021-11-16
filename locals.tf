locals {
  single_node_tags = tomap(
    {
      "ResourceClass" = "SingleNode"
    }
  )

  # CLUSTER

  type_of_cluster = var.fixed_value == 0 ? join("", databricks_cluster.single_node_cluster.*.id) : join("", databricks_cluster.cluster.*.id)

  cluster_info = var.cluster_id == null ? local.type_of_cluster : var.cluster_id

  # USERS
  databricks_username    = var.databricks_username != "" ? var.databricks_username : data.databricks_current_user.me.alphanumeric
  databricks_displayname = var.databricks_username != "" ? "${var.databricks_username} (Terraform managed)" : data.databricks_current_user.me.alphanumeric

  # WORKER NODE TYPE
  worker_node_type = var.worker_node_type_id != null ? var.worker_node_type_id : join("", data.databricks_node_type.cluster_node_type.*.id)

  # DRIVER NODE TYPE
  driver_node_type = var.driver_node_type_id != null ? var.driver_node_type_id : join("", data.databricks_node_type.cluster_node_type.*.id)
}
