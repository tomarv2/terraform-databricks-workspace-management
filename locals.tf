locals {
  shared_tags = tomap(
    {
      "Team"    = var.teamid,
      "Project" = var.prjid
    }
  )

  # NOTEBOOK
  notebook_name = var.notebook_name != null ? var.notebook_name : "${var.teamid}-${var.prjid}"

  # JOBS CLUSTER
  cluster_info = var.use_existing_cluster == true ? join("", databricks_cluster.cluster.*.id) : null
}
