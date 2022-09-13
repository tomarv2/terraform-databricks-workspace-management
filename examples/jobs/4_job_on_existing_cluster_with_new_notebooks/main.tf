provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 0.5.7"
    }
  }
}

module "cluster" {
  source = "../../../"
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster = true
  fixed_value    = 0

#  libraries = {
#    maven = {
#      "com.microsoft.azure:azure-eventhubs-spark_2.12:2.3.21" = {}
#    }
#    python_wheel = {}
#  }

  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "jobs" {
  source = "../../../"

  # ------------------------------------------------
  # JOB
  # ------------------------------------------------
  deploy_jobs               = true
  cluster_id                = module.cluster.cluster_id
  #fixed_value               = 1
  retry_on_timeout          = false
  max_retries               = 3
  timeout                   = 30
  min_retry_interval_millis = 10
  max_concurrent_runs       = 1
  task_parameters = {
    "hello" = "world",
    "ping"  = "pong"
  }
  schedule = {
    cron_expression = "1 0 7 * * ?",
    timezone_id     = "America/Los_Angeles",
    pause_status    = "UNPAUSED"
  }
  email_notifications = {
    on_failure                = ["demo@demo.com"],
    no_alert_for_skipped_runs = true,
    on_start                  = ["demo@demo.com"],
    on_success                = ["demo@demo.com"]
  }
  # ------------------------------------------------
  # NOTEBOOK
  # ------------------------------------------------
  local_notebooks = [
    {
      job_name   = "local_demo_job1"
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
      path       = "/Shared/demo/sample1.py"
    },
    {
      job_name   = "local_demo_job2"
      local_path = "notebooks/sample2.py"
    }
  ]
  jobs_access_control = [
    {
      group_name       = "demo"
      permission_level = "CAN_MANAGE_RUN"
    }
  ]
  depends_on = [module.cluster]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
