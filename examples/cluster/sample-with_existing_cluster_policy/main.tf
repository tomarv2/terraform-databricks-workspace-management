module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster                  = true
  cluster_autotermination_minutes = 30
  fixed_value                     = 1
  auto_scaling                    = [2, 3]
  worker_node_type_id             = "i3.large"
  driver_node_type_id             = "i3.large"
  spark_version                   = "8.3.x-scala2.12"

  add_instance_profile_to_workspace = true

  aws_attributes = {
    instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/aws-instance-role"
  }
  # ------------------------------------------------
  # CLUSTER PERMISSIONS
  # ------------------------------------------------
  cluster_access_control = [
    {
      group_name       = "demo_group"
      permission_level = "CAN_RESTART"
    }
  ]
  # ------------------------------------------------
  # CLUSTER POLICY
  # ------------------------------------------------
  cluster_policy_id = "E0123456789"
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
