# ADR-0001: Okta is the primary IdP; Entra ID stays for Microsoft workloads

Status: Accepted
Date: 2026-11-17

## Context

We need one system of record for workforce identity. Today there isn't one. M365 runs on Entra ID, so that tenant exists whether we like it or not. Core banking, loan origination, the wire platform and around 20 SaaS apps each manage their own users, and offboarding is a checklist that HR emails to IT. The community bank we acquired has its own Entra tenant and nobody wants a tenant migration during integration.

~800 users, ~30 branches, examiners who will ask how access is granted and removed.

## Options

**Entra ID only.** Already paid for. The problem is everything that isn't Microsoft: provisioning into the lending and banking SaaS apps is either an enterprise app that half-supports SCIM or a Logic App somebody has to own. And the acquired bank becomes a tenant merge, which is the thing we're trying to avoid.

**Okta for everything.** Sounds clean, isn't real. M365 needs Entra as its IdP of record; Okta fronts it with WS-Fed/SAML but the tenant doesn't go away. So this is two IdPs with one of them unmanaged.

**Okta primary, Entra kept for Microsoft.** Okta owns login and lifecycle for every user and app. Entra stays as the M365/Azure tenant, federated to Okta, and we use it for the things Microsoft does better in a regulated shop: Conditional Access on Microsoft workloads, PIM, access reviews. The acquired bank's tenant federates into Okta instead of merging.

## Decision

Option 3. Okta is the IdP of record. Entra ID remains for M365, Azure and governance, federated to Okta. Both tenants are managed from this repo.

## Consequences

- MFA and session policy now live in two places. Mitigation: both are Terraform in this repo, one pipeline, so a change to one is reviewed next to the other.
- Entra P2 is needed for PIM and access reviews. 
- Anyone on the platform has to know both consoles and both providers' Terraform quirks.
- Inbound federation for the acquired bank means an IdP routing rule and a JIT provisioning path. Both need a runbook and a test before cutover.

