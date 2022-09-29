output "notebook_url" {
  description = "databricks notebook url"
  value       = module.job.notebook_url
}

output "job_url" {
  description = "databricks new cluster job url"
  value       = module.job.existing_cluster_new_job_existing_notebooks_job
}

output "job_id" {
  description = "job id"
  value       = module.job.existing_cluster_new_job_existing_notebooks_id
}
