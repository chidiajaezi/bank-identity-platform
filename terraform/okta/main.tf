# Connectivity check: read-only lookup of existing groups.
# Proves the service app can authenticate and holds okta.groups.* access
# before anything is created.
data "okta_groups" "existing" {}

output "existing_group_count" {
  value = length(data.okta_groups.existing.groups)
}
