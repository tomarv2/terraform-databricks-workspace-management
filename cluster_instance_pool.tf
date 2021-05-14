resource "databricks_instance_pool" "instance_nodes" {
  count = var.deploy_instance_pool ? 1 : 0

  instance_pool_name = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  min_idle_instances = var.min_idle_instances
  max_capacity       = var.max_capacity
  node_type_id       = join("", data.databricks_node_type.cluster_node_type.*.id)
  preloaded_spark_versions = [
    data.databricks_spark_version.latest.id
  ]

  idle_instance_autotermination_minutes = var.idle_instance_autotermination_minutes
}
