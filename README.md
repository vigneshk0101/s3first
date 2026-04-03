# 🔐 S3 DevSecOps Security Pipeline

## 📌 Overview

This project is a DevSecOps pipeline that scans code for security issues and automatically secures AWS S3 buckets by blocking public access.

---

## 🚀 Features

* 🔍 **SonarCloud** – Code quality & security (SAST)
* 🛡 **Trivy** – Filesystem & config scan (SCA)
* 🔑 **Gitleaks** – Detects hardcoded secrets
* ☁️ **AWS S3 Security**

  * Detects public buckets
  * Automatically blocks public access
* 📦 **Report Storage**

  * All reports uploaded to S3 bucket

---

## ⚙️ Workflow

1. Code is pushed to GitHub
2. GitHub Actions pipeline runs
3. Security scans are executed
4. Public S3 buckets are secured automatically
5. Reports are uploaded to S3

---

## 📁 Reports Location

```
s3://s3first-project-all-files/reports/
```

---

## 🛠 Tools Used

* GitHub Actions
* AWS CLI
* SonarCloud
* Trivy
* Gitleaks

---

## 🔐 Key Highlight

Automated detection and remediation of public S3 buckets using a DevSecOps pipeline.

---

## 📌 Author

Vignesh Krishnan
