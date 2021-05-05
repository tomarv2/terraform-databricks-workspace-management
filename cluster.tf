resource "databricks_cluster" "cluster" {
  count = var.deploy_cluster ? 1 : 0

  cluster_name            = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  spark_version           = data.databricks_spark_version.latest.id
  instance_pool_id        = join("",databricks_instance_pool.instance_nodes.*.id)
  autotermination_minutes = var.cluster_autotermination_minutes

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
