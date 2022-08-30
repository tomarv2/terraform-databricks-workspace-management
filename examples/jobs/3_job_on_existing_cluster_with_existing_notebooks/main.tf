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

module "databricks_workspace_management" {
  source = "../../../"
  # ------------------------------------------------
  # JOB
  # ------------------------------------------------
  deploy_jobs = true
  cluster_id  = "0609-190359-dbzlwtsp"
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
