# Cloud-Native Streaming Data Platform

A production-ready streaming data platform built on Azure/AWS with Terraform, demonstrating Cloud Data Engineer and Data Platform Engineer capabilities.

## Architecture

```mermaid
graph LR
    A[Azure Event Hubs / AWS MSK] -->|readStream| B[Azure Databricks / EMR]
    B -->|PySpark Structured Streaming| C[ADLS Gen2 / S3]
    C -->|Delta Lake| D[Power BI / QuickSight]
```

## Tech Stack

- **Azure / AWS** — Cloud infrastructure
- **Azure Event Hubs / Amazon MSK** — Kafka-compatible event streaming
- **Azure Databricks / Amazon EMR** — Unified analytics platform
- **ADLS Gen2 / Amazon S3** — Scalable object storage
- **Delta Lake** — ACID transactions on data lake
- **Terraform** — Infrastructure as Code
- **GitHub Actions** — CI/CD

## Project Structure

```
cloud-data-platform/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── event_hub/
│   │   ├── databricks/
│   │   └── storage/
│   └── environments/
│       ├── dev/
│       └── prod/
├── src/
│   ├── streaming_job.py
│   ├── config.py
│   └── utils.py
├── notebooks/
│   ├── 01_setup_tables.py
│   └── 02_validate_data.py
├── tests/
│   ├── test_streaming_job.py
│   └── test_config.py
├── .github/workflows/
│   ├── terraform-plan.yml
│   └── terraform-apply.yml
├── README.md
└── ARCHITECTURE.md
```

## Quickstart

### Prerequisites
- Azure account or AWS account
- Terraform installed
- GitHub account (for CI/CD)

### 1. Clone the repository

```bash
git clone https://github.com/Sasireddy001/cloud-data-platform.git
cd cloud-data-platform
```

### 2. Configure Terraform

```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

### 3. Run the streaming job

```bash
cd ../..
python -m src.streaming_job
```

## Features

- **Infrastructure as Code** — All infrastructure defined in Terraform
- **Streaming pipeline** — PySpark Structured Streaming with Delta Lake
- **Data quality** — Validation with Great Expectations/Pandera
- **CI/CD** — Automated Terraform deployments via GitHub Actions
- **Multi-environment** — Dev and prod configurations

## Author

- **Sasidhar Mopuru** — Data & AI Platform Engineer
- [GitHub](https://github.com/Sasireddy001)
- [Portfolio](https://sasireddy001.github.io/Portfolio)
- [LinkedIn](https://www.linkedin.com/in/sasidhar-mopuru-417a03233)
- Email: sasidharmopuru@gmail.com

**Certifications:**
- DP-700: Implementing Data Engineering Solutions using Microsoft Fabric – Microsoft
- Databricks Certified Data Engineer Associate – Databricks

## License

This project is licensed under the [MIT License](LICENSE).
