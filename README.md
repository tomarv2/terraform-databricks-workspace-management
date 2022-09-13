<p align="center">
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-databricks-workspace-management/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for [Databricks Workspace Management (Part 2)](https://registry.terraform.io/providers/databricks/databricks/latest/docs/guides/workspace-management)

> ❗️ **Important**
>
> :point_right: This module assumes you have Databricks Workspace [AWS](https://github.com/tomarv2/terraform-databricks-workspace) or Azure already deployed.
>
> :point_right: Workspace URL
>
> :point_right: DAPI Token

## Versions

- Module tested for Terraform 1.0.1.
- `databricks/databricks` provider version [1.3.0](https://registry.terraform.io/providers/databricks/databricks/latest)
- AWS provider version [4.14](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-workspace-management" /></a>).

<p align="center">
    <img width="700" height="350"  src="https://github.com/tomarv2/terraform-databricks-workspace-management/raw/main/docs/images/databricks-workspace-management.png">
</p>

## What this module does?

### [Deploy Cluster](examples/clusters)

- This is where you would normally start with if you have just deployed your databricks workspace.

Two cluster modes are supported by this module:

- `Single Node` mode: To deploy cluster in Single Node mode, update `fixed_value` to `0`:
```
fixed_value         = 0
```

- `Standard` mode: To deploy in Standard mode, two options are available:

```
fixed_value         = 1 or more
```
OR
```
auto_scaling         = [1,3]
```

### [Cluster ACL](https://docs.databricks.com/security/access-control/cluster-acl.html)

Cluster can have one of these permissions:  `CAN_ATTACH_TO` , `CAN_RESTART` and `CAN_MANAGE`.

```
cluster_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_RESTART"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_RESTART"
  }
]
```

### [Cluster Policy](https://docs.databricks.com/administration-guide/clusters/policies.html)

- To build cluster with new cluster policy, use:
```
deploy_cluster_policy = true
policy_overrides = {
  "dbus_per_hour" : {
    "type" : "range",
    "maxValue" : 10
  },
  "autotermination_minutes" : {
    "type" : "fixed",
    "value" : 30,
    "hidden" : true
  }
}
```

- To use existing Cluster policy, specify the existing policy id:
```
cluster_policy_id = "E0123456789"
```

To get existing policy id use:
```
curl -X GET --header "Authorization: Bearer $DAPI_TOKEN"  https://<workspace_name>/api/2.0/policies/clusters/list \
--data '{ "sort_order": "DESC", "sort_column": "POLICY_CREATION_TIME" }'
```

### Cluster Policy ACL

```
policy_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_USE"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_USE"
  }
]
```

### [Instance Pool](https://docs.databricks.com/clusters/instance-pools/index.html)
**Note:** To configure `Instance Pool`, add below configuration:

```
deploy_worker_instance_pool           = true
min_idle_instances                    = 1
max_capacity                          = 5
idle_instance_autotermination_minutes = 30
```

### [Instance Pool ACL](https://docs.databricks.com/security/access-control/pool-acl.html)

Instance pool can have one of these permissions:  `CAN_ATTACH_TO` and `CAN_MANAGE`.

```
instance_pool_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_ATTACH_TO"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_ATTACH_TO"
  },
]
```

> ❗️ **Important**
>
> If `deploy_worker_instance_pool` is set to `true` and `auto_scaling` is enabled.
> Ensure `max_capacity` of Cluster Instance Pool is more than `auto_scaling` max value for Cluster.

### [Deploy Job](examples/jobs)

Two options are available:

- Deploy Job to an existing cluster.
- Deploy new Cluster and then deploy Job.

Two options are available to attach notebooks to a job:

- Attach existing notebook to a job.
- Create new notebook and attach it to a job.

### [Jobs ACL](https://docs.databricks.com/security/access-control/jobs-acl.html)

Job can have one of these permissions:  `CAN_VIEW`, `CAN_MANAGE_RUN`, `IS_OWNER`, and `CAN_MANAGE`.

Admins have `CAN_MANAGE` permission by default, and they can assign that permission to non-admin users, and service principals.

Job creator has `IS_OWNER` permission. Destroying databricks_permissions resource for a job would revert ownership to the creator.

**Note:**
- A job must have exactly one owner. If resource is changed and no owner is specified, currently authenticated principal would become new owner of the job.
- A job cannot have a **group** as an owner.
- Jobs triggered through Run Now assume the permissions of the job owner and not the user, and service principal who issued Run Now.

```
jobs_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_MANAGE_RUN"
  },
   {
    user_name       = "<user_name>"
    permission_level = "CAN_MANAGE_RUN"
  }
]
```

### AWS only
### [Instance Profile](https://docs.databricks.com/administration-guide/cloud-configurations/aws/instance-profiles.html)

Add instance profile at cluster creation time. It can control which data a given cluster can access through cloud-native controls.
```
add_instance_profile_to_workspace = true (default false)
aws_attributes = {
    instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/aws-instance-role"
}
```

Note: `add_instance_profile_to_workspace` to add Instance profile to Databricks workspace. To use existing set it to `false`.

### [Deploy Notebook](examples/notebooks)

Put notebooks in notebooks folder and provide below information:

```
  notebooks = [
    {
      name       = "demo_notebook1"
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
      path       = "/Shared/demo/sample1.py"
    },
    {
      name       = "demo_notebook2"
      local_path = "notebooks/sample2.py"
    }
  ]
```
### Notebook ACL

Notebook can have one of these permissions:  `CAN_READ`, `CAN_RUN`, `CAN_EDIT`, and `CAN_MANAGE`.

```
notebooks_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_MANAGE"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_MANAGE"
  }
]
```

### [Deploy everything(cluster,job, and notebook):](examples/all)

- Try this: If you want to test what resources are getting deployed.

## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project'
terraform apply -var='teamid=tryme' -var='prjid=project'
terraform destroy -var='teamid=tryme' -var='prjid=project'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (store remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables based on cloud provider.

- Updated `examples` directory with required values.

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)
---

Please refer to examples directory [link](examples) for references.

## Coming up

- [**Storage**](https://registry.terraform.io/providers/databricks/databricks/latest/docs/guides/workspace-management#part-3-storage)
- [**Advanced configuration**](https://registry.terraform.io/providers/databricks/databricks/latest/docs/guides/workspace-management#part-4-advanced-configuration)
- [**Init Script**](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/global_init_script)

## Helpful links

- [Databricks Sync](https://github.com/databricks/databricks-sync) - Tool for multi cloud migrations, DR sync of workspaces. It uses TF in the backend. Run it from command line or from a notebook.
- [Databricks Migrate](https://github.com/databrickslabs/migrate) - Tool to migrate a workspace(One time tool).
- [Databricks CICD Templates](https://github.com/databrickslabs/cicd-templates)

#### Troubleshooting

If you see error messages. Try running the same the command again.

```
Error: Failed to delete token in Scope <scope name>
```

```
Error: Scope <scope name> does not exist!
```

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
