resource "databricks_instance_pool" "smallest_nodes" {
  instance_pool_name = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  min_idle_instances = var.min_idle_instances
  max_capacity       = var.max_capacity
  node_type_id       = data.databricks_node_type.smallest.id
  preloaded_spark_versions = [
    data.databricks_spark_version.latest.id
  ]

  idle_instance_autotermination_minutes = var.idle_instance_autotermination_minutes
}

