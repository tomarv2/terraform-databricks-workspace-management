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

  deploy_cluster = true
  deploy_jobs    = true
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
  remote_notebooks = [
    {
      job_name = "remote_demo_job"
      path     = "/Shared/demo"
    }
  ]
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
