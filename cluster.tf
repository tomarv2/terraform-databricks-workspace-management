resource "databricks_cluster" "this" {
  cluster_name            = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  spark_version           = data.databricks_spark_version.latest.id
  instance_pool_id        = databricks_instance_pool.smallest_nodes.id
  autotermination_minutes = var.cluster_autotermination_minutes
  autoscale {
    min_workers = var.cluster_min_workers
    max_workers = var.cluster_max_workers
  }
}

resource "databricks_cluster_policy" "this" {
  name = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"
  definition = jsonencode({
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : var.cluster_policy_max_dbus_per_hour
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : var.cluster_policy_autotermination_minutes,
      "hidden" : true
    }
  })
}
