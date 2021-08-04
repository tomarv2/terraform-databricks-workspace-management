resource "databricks_instance_pool" "instance_nodes" {
  count = var.deploy_instance_pool ? 1 : 0

  instance_pool_name = "${var.teamid}-${var.prjid} (Terraform managed)"
  min_idle_instances = var.min_idle_instances
  max_capacity       = var.max_capacity
  node_type_id       = local.node_type
  preloaded_spark_versions = [
    data.databricks_spark_version.latest.id
  ]

  idle_instance_autotermination_minutes = var.idle_instance_autotermination_minutes
}
