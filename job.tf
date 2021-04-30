resource "databricks_job" "databricks_job" {
  name = "${var.teamid}-${var.prjid} (${data.databricks_current_user.me.alphanumeric})"

  new_cluster {
    num_workers   = var.num_workers
    spark_version = data.databricks_spark_version.latest.id
    node_type_id  = data.databricks_node_type.smallest.id
  }

  notebook_task {
    notebook_path = databricks_notebook.notebook_file.path
  }

  email_notifications {}
}
