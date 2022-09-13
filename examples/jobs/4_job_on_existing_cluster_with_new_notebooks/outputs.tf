output "notebook_url" {
  description = "databricks notebook url"
  value       = module.jobs.notebook_url
}

output "job_url" {
  description = "databricks job url"
  value       = module.jobs.existing_cluster_new_job_new_notebooks_job
}

output "job_id" {
  description = "databricks job id"
  value       = module.jobs.existing_cluster_new_job_new_notebooks_id
}

