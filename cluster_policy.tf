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
