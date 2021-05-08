# ------------------------------------------------
# NEW JOBS CLUSTER
# ------------------------------------------------
resource "databricks_job" "databricks_new_cluster_job" {
  for_each =  (var.deploy_job == true && var.cluster_id == null) ? var.notebook_info : {}
  name = "${var.teamid}-${var.prjid}-${each.key} (${data.databricks_current_user.me.alphanumeric})"


  new_cluster {
    num_workers   = var.num_workers
    spark_version = data.databricks_spark_version.latest.id
    node_type_id  = join("", data.databricks_node_type.cluster_node_type.*.id)
  }

  notebook_task {
    notebook_path = "${data.databricks_current_user.me.home}/${each.key}"
  }

  dynamic "email_notifications" {
    for_each = var.email_notifications == null ? [] : [var.email_notifications]
    content {
      on_failure                = lookup(email_notifications.value, "on_failure", null)
      no_alert_for_skipped_runs = lookup(email_notifications.value, "no_alert_for_skipped_runs", null)
      on_success                = lookup(email_notifications.value, "on_success", null)
      on_start                  = lookup(email_notifications.value, "on_start", null)
    }
  }
}

# ------------------------------------------------
# EXISTING CLUSTER
# ------------------------------------------------
resource "databricks_job" "databricks_job" {
  for_each =  (var.deploy_job == true && var.cluster_id != null) ? var.notebook_info : {}
  name = "${var.teamid}-${var.prjid}-${each.key} (${data.databricks_current_user.me.alphanumeric})"

  existing_cluster_id = local.cluster_info

  notebook_task {
    notebook_path = "${data.databricks_current_user.me.home}/${each.key}"
  }

  dynamic "email_notifications" {
    for_each = var.email_notifications == null ? [] : [var.email_notifications]
    content {
      on_failure                = lookup(email_notifications.value, "on_failure", null)
      no_alert_for_skipped_runs = lookup(email_notifications.value, "no_alert_for_skipped_runs", null)
      on_success                = lookup(email_notifications.value, "on_success", null)
      on_start                  = lookup(email_notifications.value, "on_start", null)
    }
  }
}
