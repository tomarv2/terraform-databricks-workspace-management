# TODO: this file has four resources, look at ideas to move to two
# ------------------------------------------------
# 1. NEW CLUSTER WITH NEW NOTEBOOKS
# ------------------------------------------------
resource "databricks_job" "new_cluster_new_job_new_notebooks" {
  for_each = (var.deploy_jobs == true && var.cluster_id == null && var.deploy_job_cluster == true && var.local_notebooks != null) ? { for p in var.local_notebooks : "${p.job_name}-${p.local_path}" => p } : {}

  name = "${each.value.job_name} (Terraform managed)"

  new_cluster {
    policy_id           = var.cluster_policy_id == null && var.deploy_cluster_policy == false ? null : local.cluster_policy_id
    spark_version       = var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest.id
    node_type_id        = var.deploy_worker_instance_pool != true ? local.worker_node_type : null
    instance_pool_id    = var.deploy_worker_instance_pool == true ? join("", databricks_instance_pool.worker_instance_nodes.*.id) : null
    driver_node_type_id = var.deploy_worker_instance_pool != true ? local.driver_node_type : null
    num_workers         = var.fixed_value != null ? var.fixed_value : null

    dynamic "autoscale" {
      for_each = var.auto_scaling != null ? [var.auto_scaling] : []
      content {
        min_workers = autoscale.value[0]
        max_workers = autoscale.value[1]
      }
    }

    dynamic "aws_attributes" {
      for_each = var.aws_attributes == null ? [] : [var.aws_attributes]
      content {
        instance_profile_arn   = var.add_instance_profile_to_workspace == true ? join("", databricks_instance_profile.shared.*.id) : lookup(aws_attributes.value, "instance_profile_arn", null)
        zone_id                = lookup(aws_attributes.value, "zone_id", null)
        first_on_demand        = lookup(aws_attributes.value, "first_on_demand", null)
        availability           = lookup(aws_attributes.value, "availability", null)
        spot_bid_price_percent = lookup(aws_attributes.value, "spot_bid_price_percent ", null)
        ebs_volume_count       = lookup(aws_attributes.value, "ebs_volume_count ", null)
        ebs_volume_size        = lookup(aws_attributes.value, "ebs_volume_size ", null)
      }
    }

    autotermination_minutes = var.cluster_autotermination_minutes
    custom_tags             = var.custom_tags != null ? merge(var.custom_tags, local.shared_tags) : merge(local.shared_tags)

    spark_conf = var.spark_conf
  }
  always_running = var.always_running
  notebook_task {
    notebook_path   = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.job_name}")
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
# 2. NEW CLUSTER WITH EXITING NOTEBOOKS
# ------------------------------------------------
resource "databricks_job" "new_cluster_new_job_existing_notebooks" {
  for_each = (var.deploy_jobs == true && var.cluster_id == null && var.deploy_job_cluster == true && var.remote_notebooks != null) ? { for p in var.remote_notebooks : "${p.job_name}-${p.path}" => p } : {}

  name = "${each.value.job_name} (Terraform managed)"

  new_cluster {
    policy_id           = var.cluster_policy_id == null && var.deploy_cluster_policy == false ? null : local.cluster_policy_id
    spark_version       = var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest.id
    node_type_id        = var.deploy_worker_instance_pool != true ? local.worker_node_type : null
    instance_pool_id    = var.deploy_worker_instance_pool == true ? join("", databricks_instance_pool.worker_instance_nodes.*.id) : null
    driver_node_type_id = var.deploy_worker_instance_pool != true ? local.driver_node_type : null
    num_workers         = var.fixed_value != null ? var.fixed_value : null

    dynamic "autoscale" {
      for_each = var.auto_scaling != null ? [var.auto_scaling] : []
      content {
        min_workers = autoscale.value[0]
        max_workers = autoscale.value[1]
      }
    }

    dynamic "aws_attributes" {
      for_each = var.aws_attributes == null ? [] : [var.aws_attributes]
      content {
        instance_profile_arn   = var.add_instance_profile_to_workspace == true ? join("", databricks_instance_profile.shared.*.id) : lookup(aws_attributes.value, "instance_profile_arn", null)
        zone_id                = lookup(aws_attributes.value, "zone_id", null)
        first_on_demand        = lookup(aws_attributes.value, "first_on_demand", null)
        availability           = lookup(aws_attributes.value, "availability", null)
        spot_bid_price_percent = lookup(aws_attributes.value, "spot_bid_price_percent ", null)
        ebs_volume_count       = lookup(aws_attributes.value, "ebs_volume_count ", null)
        ebs_volume_size        = lookup(aws_attributes.value, "ebs_volume_size ", null)
      }
    }

    autotermination_minutes = var.cluster_autotermination_minutes
    custom_tags             = var.custom_tags != null ? merge(var.custom_tags, local.shared_tags) : merge(local.shared_tags)

    spark_conf = var.spark_conf
  }
  always_running = var.always_running
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
# 3. EXISTING CLUSTER WITH NEW NOTEBOOKS
# ------------------------------------------------
resource "databricks_job" "existing_cluster_new_job_new_notebooks" {
  for_each = (var.deploy_jobs == true && (var.cluster_id != null || var.deploy_cluster == true) && var.local_notebooks != null) ? { for p in var.local_notebooks : "${p.job_name}-${p.local_path}" => p } : {}

  name                = "${each.value.job_name} (Terraform managed)"
  existing_cluster_id = local.cluster_info
  always_running      = var.always_running
  notebook_task {
    notebook_path   = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.job_name}")
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
  for_each = var.deploy_jobs == true && (var.cluster_id != null || var.deploy_cluster == true) && var.remote_notebooks != null ? { for p in var.remote_notebooks : "${p.job_name}-${p.path}" => p } : {}

  name                = "${each.value.job_name} (Terraform managed)"
  existing_cluster_id = local.cluster_info
  always_running      = var.always_running
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
