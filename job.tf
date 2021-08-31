# ------------------------------------------------
# 1. NEW CLUSTER WITH NEW NOTEBOOKS
# ------------------------------------------------
resource "databricks_job" "new_cluster_new_job_new_notebooks" {
  for_each = (var.deploy_job == true && var.cluster_id == null && var.local_notebook_info != null) ? { for p in var.local_notebook_info : "${p.name}-${p.local_path}" => p } : {}

  name = "${each.value.name} (Terraform managed)"

  new_cluster {
    num_workers   = var.num_workers
    spark_version = data.databricks_spark_version.latest.id
    node_type_id  = join("", data.databricks_node_type.cluster_node_type.*.id)
  }

  notebook_task {
    notebook_path   = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.name}")
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
# 2. EXISTING CLUSTER WITH NEW NOTEBOOKS
# ------------------------------------------------
resource "databricks_job" "existing_cluster_new_job_new_notebooks" {
  for_each = (var.cluster_id != null && var.local_notebook_info != null) ? { for p in var.local_notebook_info : "${p.name}-${p.local_path}" => p } : {}

  name                = "${each.value.name} (Terraform managed)"
  existing_cluster_id = local.cluster_info

  notebook_task {
    notebook_path   = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.name}")
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
# 3. NEW CLUSTER WITH EXITING NOTEBOOKS
# ------------------------------------------------
resource "databricks_job" "new_cluster_new_job_existing_notebooks" {
  for_each = (var.deploy_job == true && var.cluster_id == null && var.remote_notebook_info != null) ? { for p in var.remote_notebook_info : "${p.path}" => p } : {}

  name = "${each.value.name} (Terraform managed)"

  new_cluster {
    num_workers   = var.num_workers
    spark_version = data.databricks_spark_version.latest.id
    node_type_id  = join("", data.databricks_node_type.cluster_node_type.*.id)
  }

  notebook_task {
    notebook_path   = lookup(each.value, "path")
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
# 4. EXISTING CLUSTER WITH EXITING NOTEBOOKS
# ------------------------------------------------
resource "databricks_job" "existing_cluster_new_job_existing_notebooks" {
  for_each = (var.cluster_id != null && var.local_notebook_info != null) ? { for p in var.remote_notebook_info : "${p.path}" => p } : {}

  name                = "${each.value.name} (Terraform managed)"
  existing_cluster_id = local.cluster_info

  notebook_task {
    notebook_path   = lookup(each.value, "path")
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
