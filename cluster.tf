resource "databricks_cluster" "cluster" {
  count = var.deploy_cluster == true && var.fixed_value != 0 ? 1 : 0

  cluster_name  = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  spark_version = data.databricks_spark_version.latest.id

  driver_node_type_id = var.driver_node_type_id
  node_type_id        = var.deploy_instance_pool != true ? join("", data.databricks_node_type.cluster_node_type.*.id) : null

  instance_pool_id = var.deploy_instance_pool == true ? join("", databricks_instance_pool.instance_nodes.*.id) : null

  num_workers = var.fixed_value != null ? var.fixed_value : null

  dynamic "autoscale" {
    for_each = var.auto_scaling != null ? [var.auto_scaling] : []
    content {
      min_workers = autoscale.value[0]
      max_workers = autoscale.value[1]
    }
  }
  autotermination_minutes = var.cluster_autotermination_minutes
  custom_tags             = merge(local.shared_tags)
}

resource "databricks_cluster" "single_node_cluster" {
  count = var.deploy_cluster == true && var.fixed_value == 0 && var.auto_scaling == null ? 1 : 0

  cluster_name            = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  spark_version           = data.databricks_spark_version.latest.id
  autotermination_minutes = var.cluster_autotermination_minutes
  node_type_id            = var.deploy_instance_pool != true ? join("", data.databricks_node_type.cluster_node_type.*.id) : null
  num_workers             = 0

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }

  spark_conf = {
    # Single-node
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }
}
