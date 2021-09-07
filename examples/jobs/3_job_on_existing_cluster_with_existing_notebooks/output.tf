output "notebook_url" {
  description = "databricks notebook url"
  value       = module.databricks_workspace_management.notebook_url
}
output "new_cluster_new_job_new_notebooks_job" {
  description = "databricks job url"
  value       = module.databricks_workspace_management.new_cluster_new_job_new_notebooks_job
}

output "new_cluster_new_job_new_notebooks_id" {
  description = "databricks job id"
  value       = module.databricks_workspace_management.new_cluster_new_job_new_notebooks_id
}

output "existing_cluster_new_job_new_notebooks_job" {
  description = "databricks new cluster job url"
  value       = module.databricks_workspace_management.existing_cluster_new_job_new_notebooks_job
}

output "existing_cluster_new_job_new_notebooks_id" {
  description = "databricks new cluster job id"
  value       = module.databricks_workspace_management.existing_cluster_new_job_new_notebooks_id
}

output "new_cluster_new_job_existing_notebooks_job" {
  description = "databricks job url"
  value       = module.databricks_workspace_management.new_cluster_new_job_existing_notebooks_job
}

output "new_cluster_new_job_existing_notebooks_id" {
  description = "databricks job id"
  value       = module.databricks_workspace_management.new_cluster_new_job_existing_notebooks_id
}

output "existing_cluster_new_job_existing_notebooks_job" {
  description = "databricks new cluster job url"
  value       = module.databricks_workspace_management.existing_cluster_new_job_existing_notebooks_job
}

output "existing_cluster_new_job_existing_notebooks_id" {
  description = "databricks new cluster job id"
  value       = module.databricks_workspace_management.existing_cluster_new_job_existing_notebooks_id
}
