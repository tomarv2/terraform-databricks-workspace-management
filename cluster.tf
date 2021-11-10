locals {
  cluster_policy_id = var.cluster_policy_id != null ? var.cluster_policy_id : join("", databricks_cluster_policy.this.*.id)
}

resource "databricks_instance_profile" "shared" {
  count = var.deploy_cluster == true && var.add_instance_profile_to_workspace == true ? 1 : 0

  instance_profile_arn = lookup(var.aws_attributes, "instance_profile_arn", null)
}

resource "databricks_cluster" "cluster" {
  count = var.deploy_cluster == true && (var.fixed_value != 0 || var.auto_scaling != null) ? 1 : 0

  cluster_name = var.cluster_name != null ? var.cluster_name : "${var.teamid}-${var.prjid} (Terraform managed)"

  policy_id           = var.cluster_policy_id == null && var.deploy_cluster_policy == false ? null : local.cluster_policy_id
  spark_version       = var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest.id
  node_type_id        = var.deploy_worker_instance_pool != true ? local.worker_node_type : null
  instance_pool_id    = var.deploy_worker_instance_pool == true ? join("", databricks_instance_pool.worker_instance_nodes.*.id) : null
  driver_node_type_id = var.deploy_worker_instance_pool != true ? local.driver_node_type : null
  num_workers         = var.fixed_value != null ? var.fixed_value : null

  dynamic "autoscale" {
    for_each = var.auto_scaling != null ? [var.auto_scaling] : []
    content {
      min_workers = autoscale.value[0]
      max_workers = autoscale.value[1]
    }
  }

  dynamic "aws_attributes" {
    for_each = var.aws_attributes == null ? [] : [var.aws_attributes]
    content {
      instance_profile_arn   = var.add_instance_profile_to_workspace == true ? join("", databricks_instance_profile.shared.*.id) : lookup(aws_attributes.value, "instance_profile_arn", null)
      zone_id                = lookup(aws_attributes.value, "zone_id", null)
      first_on_demand        = lookup(aws_attributes.value, "first_on_demand", null)
      availability           = lookup(aws_attributes.value, "availability", null)
      spot_bid_price_percent = lookup(aws_attributes.value, "spot_bid_price_percent", null)
      ebs_volume_count       = lookup(aws_attributes.value, "ebs_volume_count", null)
      ebs_volume_size        = lookup(aws_attributes.value, "ebs_volume_size", null)
    }
  }

  autotermination_minutes = var.cluster_autotermination_minutes
  custom_tags             = var.custom_tags != null ? merge(var.custom_tags, local.shared_tags) : merge(local.shared_tags)

  spark_conf = var.spark_conf
}

resource "databricks_cluster" "single_node_cluster" {
  count = var.deploy_cluster == true && var.fixed_value == 0 ? 1 : 0

  cluster_name = var.cluster_name != null ? var.cluster_name : "${var.teamid}-${var.prjid} (Terraform managed)"

  spark_version = var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest.id
  node_type_id  = var.deploy_worker_instance_pool != true ? local.driver_node_type : null
  num_workers   = 0

  dynamic "aws_attributes" {
    for_each = var.aws_attributes == null ? [] : [var.aws_attributes]
    content {
      instance_profile_arn   = var.add_instance_profile_to_workspace == true ? join("", databricks_instance_profile.shared.*.id) : lookup(aws_attributes.value, "instance_profile_arn", null)
      zone_id                = lookup(aws_attributes.value, "zone_id", null)
      first_on_demand        = lookup(aws_attributes.value, "first_on_demand", null)
      availability           = lookup(aws_attributes.value, "availability", null)
      spot_bid_price_percent = lookup(aws_attributes.value, "spot_bid_price_percent", null)
      ebs_volume_count       = lookup(aws_attributes.value, "ebs_volume_count", null)
      ebs_volume_size        = lookup(aws_attributes.value, "ebs_volume_size", null)
    }
  }

  autotermination_minutes = var.cluster_autotermination_minutes
  custom_tags = {
    "ResourceClass" = "SingleNode"
  }

  spark_conf = {
    # Single-node
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }
}
