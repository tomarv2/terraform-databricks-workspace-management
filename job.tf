# ------------------------------------------------
# NEW JOBS CLUSTER
# ------------------------------------------------
resource "databricks_job" "databricks_new_cluster_job" {
  for_each = (var.deploy_job == true && var.cluster_id == null) ? var.notebook_info : {}
  name     = "${var.teamid}-${var.prjid}-${each.key} (${data.databricks_current_user.me.alphanumeric})"


  new_cluster {
    num_workers   = var.num_workers
    spark_version = data.databricks_spark_version.latest.id
    node_type_id  = join("", data.databricks_node_type.cluster_node_type.*.id)
  }

  notebook_task {
    notebook_path   = "${data.databricks_current_user.me.home}/${each.key}"
    base_parameters = var.task_parameters
  }

  retry_on_timeout          = var.retry_on_timeout
  max_retries               = var.retry_on_timeout != false ? var.max_retries : 0
  timeout_seconds           = var.timeout
  min_retry_interval_millis = var.min_retry_interval_millis
  max_concurrent_runs       = var.max_concurrent_runs

  dynamic "email_notifications" {
    for_each = var.email_notifications == null ? [] : [var.email_notifications]
    content {
      on_failure                = lookup(email_notifications.value, "on_failure", null)
      no_alert_for_skipped_runs = lookup(email_notifications.value, "no_alert_for_skipped_runs", null)
      on_success                = lookup(email_notifications.value, "on_success", null)
      on_start                  = lookup(email_notifications.value, "on_start", null)
    }
  }

  dynamic "schedule" {
    for_each = var.schedule == null ? [] : [var.schedule]
    content {
      quartz_cron_expression = lookup(schedule.value, "cron_expression", null)
      timezone_id            = lookup(schedule.value, "timezone_id", null)
      pause_status           = lookup(schedule.value, "pause_status", null)
    }
  }
}

# ------------------------------------------------
# EXISTING CLUSTER
# ------------------------------------------------
resource "databricks_job" "databricks_job" {
  for_each = (var.deploy_job == true && var.cluster_id != null) ? var.notebook_info : {}
  name     = "${var.teamid}-${var.prjid}-${each.key} (${data.databricks_current_user.me.alphanumeric})"

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
