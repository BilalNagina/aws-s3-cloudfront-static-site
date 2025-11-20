# 🚀 AWS Static Website Hosting — Terraform + S3 + CloudFront (OAC)

A fully automated, production-grade static website hosting stack built with Terraform, Amazon S3, CloudFront, and CloudFront Origin Access Control (OAC).

This project deploys a modern, secure static site hosting pipeline with:

* 🛡 **Private S3 bucket**
* 🚀 **Global CDN via CloudFront**
* 🔐 **Origin Access Control (OAC)** for secure bucket access
* 📁 **Infrastructure-as-Code** (Terraform modules)
* 🌍 **HTTPS-ready** CloudFront domain
* ⚡ **One-command website deployments** via AWS CLI

Perfect for portfolios, landing pages, documentation sites, and any static frontend.

---

## 📂 LAYER 1 — Terraform Project Structure

A clean module-based layout for clarity, reusability, and scale.

```text
aws-s3-cloudfront-static-site/
│
├── main.tf
├── variables.tf
├── outputs.tf
│
├── modules/
│   ├── s3-site/             # S3 bucket + versioning + private access + bucket policy
│   └── cloudfront/          # CloudFront distribution + OAC
│
├── templates/
│   └── s3-policy.json.tpl   # Bucket policy template
│
└── site/                    # Your static website (HTML / CSS / JS)
```

### Why this layout?
* **`modules/`** keeps infra components isolated, reusable, and testable.
* **`templates/`** holds dynamic policies.
* **`site/`** stores your static assets.
* **Root folder** focuses only on wiring pieces together.

*This mirrors real-world Terraform project structures.*

---

## 🌩 LAYER 2 — AWS Architecture Overview

This project creates a secure static hosting architecture where the S3 bucket remains private, and content is served exclusively through CloudFront.

### ✔ 1. Private S3 Bucket
Your website files are stored privately.
* No public access
* No public ACLs
* Versioning enabled
* Public access block enabled

### ✔ 2. CloudFront Distribution
CloudFront globally caches your site and serves it fast anywhere in the world.

### ✔ 3. Origin Access Control (OAC)
CloudFront becomes the **only** service allowed to read objects from your S3 bucket. The OAC + Bucket Policy combo ensures:
* **S3** → not public
* **CloudFront** → allowed based on `SourceArn`
* **Browser** → HTTPS only

### ✔ 4. Bucket Policy
Generated dynamically using Terraform’s `templatefile()`:
* Allows CloudFront distribution to read objects.
* Enforces SigV4 signing.
* Protects against public access.
* Ensures least-privilege access.

### ✔ 5. Terraform Modules
* `modules/s3-site`
* `modules/cloudfront`

Modules contain the actual AWS resources, keeping your root config clean.

---

## ⚙ LAYER 3 — Deployment Workflow

This is the full end-to-end workflow from installing Terraform → deploying infra → uploading site → viewing it live. **Follow these steps exactly.**

### 📦 1. Install AWS CLI, Terraform, Git
*(Windows PowerShell using Chocolatey)*

```powershell
choco install terraform -y
choco install awscli -y
choco install git -y
```

**Verify installation:**
```bash
terraform -version
aws --version
git --version
```

### 🔑 2. Configure AWS Credentials

```bash
aws configure
```
* **Access Key:** [Your Key]
* **Secret Key:** [Your Secret]
* **Region:** `ap-south-1`
* **Output:** `json`

**Verify identity:**
```bash
aws sts get-caller-identity
```

### 📁 3. Clone / Open the Project

```bash
cd C:\Users\Bilal\aws-s3-cloudfront-static-site
# (or your specific path)
```

### 🌍 4. Create `terraform.tfvars`
Create a file named `terraform.tfvars` in the root directory:

```hcl
bucket_name = "your-unique-bucket-name-2025"
region      = "ap-south-1"
project     = "static-site"
aliases     = []
price_class = "PriceClass_100"

tags = {
  Owner = "bilal"
  Env   = "dev"
}
```

### 🔧 5. Initialize Terraform

```bash
terraform init
```

### 🧪 6. Validate Configuration

```bash
terraform fmt -recursive
terraform validate
```

### 📘 7. Create a Plan

```bash
terraform plan -out=tfplan -input=false
```
*Review what Terraform will create: S3 bucket, CloudFront Distribution, OAC, and Bucket policy.*

### 🚀 8. Apply Infrastructure

```bash
terraform apply "tfplan"
```
> **Note:** CloudFront creation may take **5–15 minutes**. Wait until Terraform completes.

### 📤 9. Upload Your Static Website
Your `site/` folder represents your website:

```text
site/
├── index.html
├── styles.css
├── script.js
└── images/
```

**Upload everything to S3:**
```bash
aws s3 sync ./site s3://your-unique-bucket-name --delete
```

**Verify files:**
```bash
aws s3 ls s3://your-unique-bucket-name --recursive
```

### 🌐 10. Get Your Website URL

```bash
terraform output cloudfront_domain
```

**Open in browser:**
`https://<cloudfront-domain>`

> *If `/index.html` works but `/` shows AccessDenied → CloudFront needs `default_root_object = "index.html"` (This Terraform module already supports this).*

### 🧹 11. CloudFront Cache Invalidation
If you update files but the browser still shows old content:

```bash
aws cloudfront create-invalidation \
  --distribution-id <DISTRIBUTION_ID> \
  --paths "/*"
```

---

## 💰 Cost Notes
CloudFront is low cost for small traffic:
* **Typical portfolio:** ₹15–₹50/month
* **S3 storage:** A few rupees per month
* **Free Tier:** First 1000 invalidation paths free each month.
* *No major surprise bills if you're running a basic portfolio site.*

## 🛡 Security
This architecture ensures:
* S3 bucket is **100% private**.
* Only CloudFront can access it.
* No public ACLs / policies.
* No hardcoded AWS credentials in repo.
* `.gitignore` excludes tfstate & secrets.

## 📘 Tech Stack
* **Terraform** (Infrastructure-as-Code)
* **AWS S3** (Static storage)
* **AWS CloudFront** (Global CDN)
* **Origin Access Control** (OAC)
* **AWS CLI** (Deploy site)

## 🤝 Contributing
Pull requests welcome.
