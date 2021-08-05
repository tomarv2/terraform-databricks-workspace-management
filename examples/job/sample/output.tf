output "databricks_job_url" {
  description = "databricks job url"
  value       = module.databricks_workspace_management.job_url
}

output "databricks_notebook_url" {
  description = "databricks notebook url"
  value       = module.databricks_workspace_management.notebook_url
}

output "job_new_cluster_url" {
  description = "databricks new cluster job url"
  value       = module.databricks_workspace_management.job_new_cluster_url
}

output "job_permissions" {
  description = "databricks job permissions"
  value       = module.databricks_workspace_management.job_permissions
}
