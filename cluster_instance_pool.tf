resource "databricks_instance_pool" "worker_instance_nodes" {
  count = var.deploy_worker_instance_pool ? 1 : 0

  instance_pool_name = "${var.teamid}-${var.prjid}-worker (Terraform managed)"
  min_idle_instances = var.min_idle_instances
  max_capacity       = var.max_capacity
  node_type_id       = local.worker_node_type
  preloaded_spark_versions = [
    var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest.id
  ]

  idle_instance_autotermination_minutes = var.idle_instance_autotermination_minutes
}

resource "databricks_instance_pool" "driver_instance_nodes" {
  count = var.deploy_driver_instance_pool ? 1 : 0

  instance_pool_name = "${var.teamid}-${var.prjid}-driver (Terraform managed)"
  min_idle_instances = var.min_idle_instances
  max_capacity       = var.max_capacity
  node_type_id       = var.driver_node_type_id
  preloaded_spark_versions = [
    var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest.id
  ]

  idle_instance_autotermination_minutes = var.idle_instance_autotermination_minutes
}
