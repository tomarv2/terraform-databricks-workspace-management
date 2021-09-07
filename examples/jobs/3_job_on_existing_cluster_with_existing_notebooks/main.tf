provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.5"
    }
  }
}

module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = var.workspace_url
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # JOB
  # ------------------------------------------------
  deploy_jobs = true
  cluster_id  = "0907-052446-bike152"
  # ------------------------------------------------
  # JOB ACCESS CONTROL
  # ------------------------------------------------
  jobs_access_control = [
    {
      group_name       = "demo"
      permission_level = "CAN_MANAGE_RUN"
    }
  ]
  # ------------------------------------------------
  # NOTEBOOK
  # ------------------------------------------------
  remote_notebooks = [
    {
      job_name = "remote_demo_job"
      path     = "/Shared/demo/sample1"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
