# Deployment Guide — Cloud-Native Streaming Data Platform

This document explains how to deploy the streaming data platform on Azure and AWS using Terraform.

---

## Deployment options

| Cloud | Primary Services | Terraform path |
|---|---|---|
| Azure | Event Hubs, Databricks, ADLS Gen2 | `terraform/azure/` |
| AWS | MSK, EMR Serverless, S3, CloudWatch | `terraform/aws/` |

---

## Azure deployment

**Prerequisites:** Azure CLI, Terraform >= 1.5, Databricks workspace.

```bash
# 1. Authenticate
az login

# 2. Prepare variables
cd terraform/azure
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars

# 3. Deploy infrastructure
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

**Components deployed**

- Azure Resource Group
- Azure Event Hubs namespace and topic
- Azure Databricks workspace (if not existing)
- Azure Data Lake Storage Gen2 account and container
- Azure Key Vault for secrets

**Run the streaming job**

1. Upload `src/streaming_job.py` to Databricks.
2. Attach the job to a cluster with the Event Hubs Spark connector and Delta Lake libraries.
3. Trigger the job and monitor the **Databricks Runs** UI.

---

## AWS deployment

**Prerequisites:** AWS CLI, Terraform >= 1.5.

```bash
# 1. Authenticate
aws configure

# 2. Prepare variables
cd terraform/aws
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars

# 3. Deploy
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

**Components deployed**

- VPC, subnets, security groups
- Amazon MSK Serverless cluster
- Amazon EMR Serverless application
- Amazon S3 bucket for Delta Lake data
- IAM roles and policies
- CloudWatch dashboards and alarms

---

## Verification checklist

- [ ] Terraform `apply` completes with no errors.
- [ ] Event Hub / MSK topic receives events.
- [ ] Streaming job runs without failures.
- [ ] Delta Lake data appears in ADLS Gen2 / S3.
- [ ] CloudWatch / Azure Monitor shows healthy metrics.
- [ ] Alerts are configured and reachable.

---

## Multi-environment strategy

- `dev` — smallest Event Hubs/MSK capacity, 7-day log retention, public subnets.
- `staging` — mirror production sizing, private subnets, full monitoring.
- `prod` — private subnets, NAT Gateway, 90-day retention, PagerDuty/OpsGenie integration.

---

## Destroying resources

```bash
cd terraform/<azure|aws>
terraform destroy
```

Always destroy dev resources when not in use to control cost.
