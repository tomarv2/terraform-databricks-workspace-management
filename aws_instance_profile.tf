resource "databricks_instance_profile" "shared" {
  count = var.deploy_cluster == true && var.add_instance_profile_to_workspace == true ? 1 : 0

  instance_profile_arn = lookup(var.aws_attributes, "instance_profile_arn", null)
}
