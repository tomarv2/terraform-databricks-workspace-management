output "cluster_id" {
  description = "databricks cluster id"
  value       = module.databricks_workspace_management.cluster_id
}

output "notebook_url" {
  description = "databricks notebook url"
  value       = module.databricks_workspace_management.notebook_url
}
output "job_url" {
  description = "databricks job url"
  value       = module.databricks_workspace_management.new_cluster_new_job_new_notebooks_job
}

output "job_id" {
  description = "databricks job id"
  value       = module.databricks_workspace_management.new_cluster_new_job_new_notebooks_id
}

output "notebooks_id" {
  description = "databricks notebook id"
  value       = module.databricks_workspace_management.new_cluster_new_job_existing_notebooks_id
}
