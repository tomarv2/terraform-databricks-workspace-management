output "notebook_url_standalone" {
  description = "databricks notebook url"
  value       = module.notebook.notebook_url_standalone
}

/*
output "notebook_permissions" {
  description = "databricks notebook permissions"
  value       = module.cluster.notebook_permissions
}
*/
