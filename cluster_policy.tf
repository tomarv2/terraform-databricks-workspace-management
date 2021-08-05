locals {
  default_policy = {
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : true
    }
  }
}

resource "databricks_cluster_policy" "this" {
  count = var.deploy_cluster_policy == true && (var.databricks_username != null) ? 1 : 0

  name       = "${var.teamid}-${var.prjid} (Terraform managed)"
  definition = jsonencode(merge(local.default_policy, var.policy_overrides))
}
