resource "databricks_cluster" "cluster" {
  count = var.deploy_cluster ? 1 : 0

  cluster_name            = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  spark_version           = data.databricks_spark_version.latest.id
  autotermination_minutes = var.cluster_autotermination_minutes

  node_type_id     = var.deploy_instance_pool != true ? join("", data.databricks_node_type.cluster_node_type.*.id) : null
  instance_pool_id = var.deploy_instance_pool == true ? join("", databricks_instance_pool.instance_nodes.*.id) : null

  num_workers = var.fixed_value != null ? var.fixed_value : null

  dynamic "autoscale" {
    for_each = var.auto_scaling != null ? [var.auto_scaling] : []
    content {
      min_workers = autoscale.value[0]
      max_workers = autoscale.value[1]
    }
  }
  autoscale {
    min_workers = var.cluster_min_workers
    max_workers = var.cluster_max_workers
  }

  custom_tags = merge(local.shared_tags)

  /*
   spark_conf = {
      # Single-node
      "spark.databricks.cluster.profile" : "singleNode"
      "spark.master" : "local[*]"
    }
  */
}
