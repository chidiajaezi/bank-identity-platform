# Regional Bank Identity Platform

The identity platform for a regional bank with about 800 employees, built end to end: identity providers managed as code, HR-driven joiner/mover/leaver automation, SCIM provisioning, federation and SSO for applications, workload and agent identity, governance, and detections.

## What this solves

A bank has thousands of doors (core banking, loan files, wire transfers, customer records) and hundreds of people whose jobs change. This platform makes sure every person, service and automated agent has exactly the access its role requires, gets it on day one, loses it the day it is no longer needed, and leaves an audit trail an examiner can read.

## Architecture

_Reference diagram to follow in `docs/architecture/`._

## Repository layout

| Path | What lives here |
|---|---|
| `terraform/okta` | Okta tenant as code: groups, rules, policies, applications |
| `terraform/entra` | Entra ID as code: groups, Conditional Access, app registrations |
| `terraform/aws` | AWS Organizations, IAM Identity Center, OIDC trust for pipelines |
| `terraform/modules` | Reusable Terraform modules |
| `hr-sync` | HR system of record and the sync job that drives Okta lifecycle |
| `scim-server` | SCIM 2.0 server (RFC 7643 / 7644) |
| `apps/portal` | Employee Portal — OIDC relying party |
| `apps/legacy-saml` | Legacy SAML application and its runbook |
| `apps/api` | Loans API protected by OAuth 2.0 scopes |
| `agent` | Loan-document review agent using scoped, short-lived credentials |
| `detections` | Event-hook receiver, alert rules and queries |
| `docs/adr` | Architecture Decision Records |
| `docs/architecture` | Current state, role model, reference architecture |
| `docs/runbooks` | Operational runbooks |
| `docs/rca` | Root-cause analyses |
| `docs/requirements` | Requirements traceability matrix |
| `.github/workflows` | Terraform plan on PR, apply on merge, nightly drift detection, tests |

## How changes are made

Every change to an identity provider goes through a pull request with a Terraform plan attached. Nothing is changed in a console without being brought under code the same day. Secrets never enter this repository: they live in GitHub Actions secrets, Vercel environment variables and a local keychain.

## Decisions

See `docs/adr/` for the decision log.
