## ![🚀](<Base64-Image-Removed>) AWS Static Website Hosting — Terraform + S3 + CloudFront (OAC)

A fully automated, production-grade static website hosting stack built with Terraform, Amazon S3, CloudFront, and CloudFront Origin Access Control (OAC).

This project deploys a modern, secure static site hosting pipeline with:

![🛡](<Base64-Image-Removed>)Private S3 bucket

![🚀](<Base64-Image-Removed>)Global CDN via CloudFront

![🔐](<Base64-Image-Removed>)Origin Access Control (OAC) for secure bucket access

![📁](<Base64-Image-Removed>)Infrastructure-as-Code (Terraform modules)

![🌍](<Base64-Image-Removed>)HTTPS-ready CloudFront domain

![⚡](<Base64-Image-Removed>)One-command website deployments via AWS CLI

Perfect for portfolios, landing pages, documentation sites, and any static frontend.

## ![📂](<Base64-Image-Removed>) LAYER 1 — Terraform Project Structure

A clean module-based layout for clarity, reusability, and scale:

aws-static-site/
│
├── main.tf
├── variables.tf
├── outputs.tf
│
├── modules/
│ ├── s3-site/ # S3 bucket + versioning + private access + bucket policy
│ └── cloudfront/ # CloudFront distribution + OAC
│
├── templates/
│ └── s3-policy.json.tpl # Bucket policy template
│
└── site/ # Your static website (HTML / CSS / JS)

​

#### Why this layout?

modules/ keeps infra components isolated, reusable, testable.

templates/ holds dynamic policies.

site/ stores your static assets.

Root folder focuses only on wiring pieces together.

This mirrors real-world Terraform project structures.

## ![🌩](<Base64-Image-Removed>) LAYER 2 — AWS Architecture Overview

This project creates a secure static hosting architecture:

#### ![✔](<Base64-Image-Removed>) 1\. Private S3 Bucket

Your website files are stored privately.

No public access

No public ACLs

Versioning enabled

Public access block enabled

#### ![✔](<Base64-Image-Removed>) 2\. CloudFront Distribution

CloudFront globally caches your site and serves it fast anywhere in the world.

#### ![✔](<Base64-Image-Removed>) 3\. Origin Access Control (OAC)

CloudFront becomes the only service allowed to read objects from your S3 bucket.

The OAC + Bucket Policy combo ensures:

S3 → not public

CloudFront → allowed based on SourceArn

Browser → HTTPS only

###![✔](<Base64-Image-Removed>) 4\. Bucket Policy

Generated dynamically using Terraform’s

templatefile()

:

Allows CloudFront distribution to read objects

Enforces SigV4 signing

Protects against public access

Ensures least-privilege access

#### ![✔](<Base64-Image-Removed>) 5\. Terraform Modules

You have:

modules/s3-site

modules/cloudfront

Modules contain the actual AWS resources, keeping your root config clean.

## ![⚙](<Base64-Image-Removed>) LAYER 3 — Deployment Workflow

This is the full end-to-end workflow from installing Terraform → deploying infra → uploading site → viewing it live.

Follow these steps exactly.

## ![📦](<Base64-Image-Removed>) 1\. Install AWS CLI, Terraform, Git

(Windows PowerShell using Chocolatey)

choco install terraform -y
choco install awscli -y
choco install git -y

​

Verify:

terraform -version
aws --version
git --version

​

## ![🔑](<Base64-Image-Removed>) 2\. Configure AWS Credentials

aws configure

​

Provide:

Access Key

Secret Key

Region:

ap-south-1

Output:

json

Verify identity:

aws sts get-caller-identity

​

## ![📁](<Base64-Image-Removed>) 3\. Clone / Open the Project

cd C:\\Users\\Bilal\\aws-static-site

​

(or your path)

## ![🌍](<Base64-Image-Removed>) 4\. Create terraform.tfvars

Create a file terraform.tfvars:

bucket\_name="your-unique-bucket-name-2025"region="ap-south-1"project="static-site"aliases=\[\]price\_class="PriceClass\_100"tags={Owner="bilal"Env="dev"}

​

## ![🔧](<Base64-Image-Removed>) 5\. Initialize Terraform

terraform init

​

## ![🧪](<Base64-Image-Removed>) 6\. Validate Configuration

terraform fmt -recursive
terraform validate

​

## ![📘](<Base64-Image-Removed>) 7\. Create a Plan

terraform plan -out=tfplan -input=false

​

Review what Terraform will create:

S3 bucket

CloudFront Distribution

Origin Access Control

Bucket policy

## ![🚀](<Base64-Image-Removed>) 8\. Apply Infrastructure

terraform apply "tfplan"

​

CloudFront creation may take 5–15 minutes — wait until Terraform completes.

## ![📤](<Base64-Image-Removed>) 9\. Upload Your Static Website

Your

site/

folder represents your website:

site/
├── index.html
├── styles.css
├── script.js
└── images/

​

Upload everything to S3:

aws s3 sync ./site s3://your-unique-bucket-name --delete

​

Verify files:

aws s3 ls s3://your-unique-bucket-name --recursive

​

## ![🌐](<Base64-Image-Removed>) 10\. Get Your Website URL

terraform output cloudfront\_domain

​

Open in browser:

https://<cloudfront-domain>

​

If

/index.html

works but

/

shows AccessDenied → CloudFront needs:

default\_root\_object="index.html"

​

(Terraform module already supports this.)

## ![🧹](<Base64-Image-Removed>) 11\. CloudFront Cache Invalidation

If you update files but browser still shows old content:

aws cloudfront create-invalidation \
 --distribution-id <DISTRIBUTION\_ID>\
 --paths "/\*"

​

## ![💰](<Base64-Image-Removed>) Cost Notes

CloudFront is low cost for small traffic:

Typical portfolio = ₹15–₹50/month

S3 storage = a few rupees per month

First 1000 invalidation paths free each month

No major surprise bills if you're running a basic portfolio site.

## ![🛡](<Base64-Image-Removed>) Security

This architecture ensures:

S3 bucket is 100% private

Only CloudFront can access it

No public ACLs / policies

No hardcoded AWS credentials in repo

.gitignore

excludes tfstate & secrets

## ![📘](<Base64-Image-Removed>) Tech Stack

Terraform (Infrastructure-as-Code)

AWS S3 (Static storage)

AWS CloudFront (Global CDN)

Origin Access Control (OAC)

AWS CLI (Deploy site)

## ![📄](<Base64-Image-Removed>) License

MIT License

## ![🤝](<Base64-Image-Removed>) Contributing

Pull requests welcome.
