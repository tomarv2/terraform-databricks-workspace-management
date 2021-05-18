module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # Admin Console
  # ------------------------------------------------
  /*
  # NOTE: If `databricks_username` is not provided, no permissions are configured
  databricks_username = "varun.tomar@databricks.com"
  # ------------------------------------------------
  # NOTE: Power User does not have permissions to configure instance profile
  aws_attributes = {
    instance_profile_arn = "arn:aws:iam::755921336062:instance-profile/security-tines-ecs-mgmt-role"
  }
  */
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster = true
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
