output "notebook_url" {
  description = "databricks notebook url"
  value       = module.databricks_workspace_management.notebook_url
}

output "job_url" {
  description = "databricks job url"
  value       = module.databricks_workspace_management.existing_cluster_new_job_new_notebooks_job
}

output "job_id" {
  description = "databricks job id"
  value       = module.databricks_workspace_management.existing_cluster_new_job_new_notebooks_id
}

