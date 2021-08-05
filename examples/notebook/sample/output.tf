output "databricks_notebook_url" {
  description = "databricks notebook url"
  value       = module.databricks_workspace_management.notebook_url
}

/*
output "notebook_permissions" {
  description = "databricks notebook permissions"
  value       = module.databricks_workspace_management.notebook_permissions
}
*/
