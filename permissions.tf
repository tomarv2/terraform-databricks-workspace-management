# ------------------------------------------------
# Instance Pool Permissions
# ------------------------------------------------
resource "databricks_permissions" "worker_pool" {
  count = var.deploy_worker_instance_pool == true && var.instance_pool_access_control != null ? 1 : 0

  instance_pool_id = join("", databricks_instance_pool.worker_instance_nodes.*.id)

  dynamic "access_control" {
    for_each = var.instance_pool_access_control
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}

resource "databricks_permissions" "driver_pool" {
  count = var.deploy_driver_instance_pool == true && var.instance_pool_access_control != null ? 1 : 0

  instance_pool_id = join("", databricks_instance_pool.driver_instance_nodes.*.id)

  dynamic "access_control" {
    for_each = var.instance_pool_access_control
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}
# ------------------------------------------------
# Clusters Permissions
# ------------------------------------------------
resource "databricks_permissions" "cluster" {
  count = var.deploy_cluster == true && var.cluster_access_control != null ? 1 : 0

  cluster_id = databricks_cluster.cluster[local.cluster_name].id

  dynamic "access_control" {
    for_each = var.cluster_access_control
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}

# ------------------------------------------------
# Policy Permissions
# ------------------------------------------------
resource "databricks_permissions" "policy" {
  count = var.deploy_cluster_policy == true && var.policy_access_control != null ? 1 : 0

  cluster_policy_id = join("", databricks_cluster_policy.this.*.id)

  dynamic "access_control" {
    for_each = var.policy_access_control
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}

# ------------------------------------------------
# Jobs Permissions
# ------------------------------------------------
# 1. NEW CLUSTER WITH NEW NOTEBOOKS
# ------------------------------------------------
resource "databricks_permissions" "new_cluster_new_job_new_notebooks" {
  for_each = (var.jobs_access_control != null && var.deploy_jobs == true && var.local_notebooks != null) ? databricks_job.new_cluster_new_job_new_notebooks : {}

  job_id = each.value.id

  dynamic "access_control" {
    for_each = var.jobs_access_control != null ? var.jobs_access_control : []
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}
# ------------------------------------------------
# 2. EXISTING CLUSTER WITH NEW NOTEBOOKS
# ------------------------------------------------
resource "databricks_permissions" "existing_cluster_new_job_new_notebooks" {
  for_each = (var.jobs_access_control != null && var.deploy_jobs == true && var.local_notebooks != null) ? databricks_job.existing_cluster_new_job_new_notebooks : {}

  job_id = each.value.id

  dynamic "access_control" {
    for_each = var.jobs_access_control != null ? var.jobs_access_control : []
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}
# ------------------------------------------------
# 3. NEW CLUSTER WITH EXITING NOTEBOOKS
# ------------------------------------------------
resource "databricks_permissions" "new_cluster_new_job_existing_notebooks" {
  for_each = (var.jobs_access_control != null && var.deploy_jobs == true && var.remote_notebooks != null) ? databricks_job.new_cluster_new_job_existing_notebooks : {}

  job_id = each.value.id

  dynamic "access_control" {
    for_each = var.jobs_access_control != null ? var.jobs_access_control : []
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}
# ------------------------------------------------
# 4. EXISTING CLUSTER WITH EXITING NOTEBOOKS
# ------------------------------------------------
resource "databricks_permissions" "existing_cluster_new_job_existing_notebooks" {
  for_each = (var.jobs_access_control != null && var.deploy_jobs == true && var.remote_notebooks != null) ? databricks_job.existing_cluster_new_job_existing_notebooks : {}

  job_id = each.value.id

  dynamic "access_control" {
    for_each = var.jobs_access_control != null ? var.jobs_access_control : []
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}
# ------------------------------------------------
# Notebooks Permissions
# ------------------------------------------------
resource "databricks_permissions" "notebook" {
  for_each = var.notebooks_access_control != null ? { for p in var.notebooks : "${p.name}-${p.local_path}" => p } : {}

  notebook_path = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.name}")

  dynamic "access_control" {
    for_each = var.notebooks_access_control != null ? var.notebooks_access_control : []
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}

resource "databricks_permissions" "jobs_notebook" {
  for_each = (var.deploy_jobs != false && var.notebooks_access_control != null) ? { for p in var.local_notebooks : "${p.job_name}-${p.local_path}" => p } : {}

  notebook_path = lookup(each.value, "path", "${data.databricks_current_user.me.home}/${each.value.job_name}")

  dynamic "access_control" {
    for_each = var.notebooks_access_control != null ? var.notebooks_access_control : []
    content {
      group_name       = lookup(access_control.value, "group_name", null) != null ? access_control.value.group_name : null
      user_name        = lookup(access_control.value, "user_name", null) != null ? access_control.value.user_name : null
      permission_level = access_control.value.permission_level
    }
  }
}
