# Credentials come from the environment, never from this file:
#   OKTA_ORG_NAME, OKTA_BASE_URL, OKTA_API_CLIENT_ID,
#   OKTA_API_PRIVATE_KEY_ID, OKTA_API_PRIVATE_KEY, OKTA_API_SCOPES
# Terraform authenticates as the terraform-automation API service app
# (private_key_jwt, scoped tokens). No static API token is used.
provider "okta" {}
