# Cloud IAM & S3 Security Mini-Project

A practical demonstration of AWS Identity and Access Management (IAM) and S3 security best practices using LocalStack. This project illustrates the **Principle of Least Privilege** by setting up a restricted environment where users must assume specific roles to perform authorized actions.

## 🚀 Overview

This project simulates a real-world AWS environment locally. It automates the creation of:
1.  **IAM Users**: A base user with minimal permissions.
2.  **IAM Roles**: A specialized "Read-Only" role for S3 access.
3.  **Trust Policies**: Rules defining who can assume the role.
4.  **Permission Policies**: Fine-grained JSON policies controlling S3 access.
5.  **S3 Buckets**: Secure storage for testing permissions.

## 🛠 Technologies Used

-   **[LocalStack](https://localstack.cloud/)**: A fully functional local AWS cloud stack.
-   **[Docker](https://www.docker.com/) & Docker Compose**: For container orchestration of the cloud environment.
-   **[AWS CLI](https://aws.amazon.com/cli/)**: To interact with the simulated cloud services.
-   **[jq](https://stedolan.github.io/jq/)**: A lightweight command-line JSON processor for script automation.
-   **Bash Scripting**: For automated setup, testing, and teardown workflows.
-   **JSON (AWS IAM Policies)**: For defining security rules and trust relationships.

## 📁 Project Structure

-   `docker-compose.yml`: LocalStack configuration (IAM, S3, STS).
-   `setup.sh`: Automates the creation of users, roles, policies, and buckets.
-   `start.sh`: Starts the LocalStack environment in the background.
-   `stop.sh`: Gracefully stops and cleans up the Docker environment.
-   `test.sh`: Performs a basic health check on S3 services.
-   `iam_test.sh`: The core demonstration script that simulates assuming a role and testing permission boundaries.
-   `*-policy.json`: JSON documents defining IAM trust and permission policies.

## 🚦 Getting Started

### Prerequisites

-   Docker & Docker Compose
-   AWS CLI
-   `jq` installed (`sudo apt install jq` on Ubuntu)

### Step 1: Start the Environment

```bash
chmod +x *.sh
./start.sh
```

### Step 2: Configure the Cloud Resources

```bash
./setup.sh
```
*Note: This script will output the Access Key ID and Secret Access Key for the `read-only-user`.*

### Step 3: Run the IAM Security Test

The `iam_test.sh` script demonstrates the role-assumption workflow:
1.  It starts as a user with **no direct S3 access**.
2.  It **assumes a role** to gain temporary credentials.
3.  It proves that it can **Read** (List) files but **Cannot Write** (Upload) files, confirming the security policy is active.

```bash
./iam_test.sh
```

### Step 4: Cleanup

```bash
./stop.sh
```

## 🔒 Security Concepts Demonstrated

-   **Principle of Least Privilege**: Users are given only the permissions they need for their task.
-   **Role-Based Access Control (RBAC)**: Using roles instead of direct user permissions for better scalability and security.
-   **Temporary Credentials**: Using AWS STS (Security Token Service) to get short-lived access.
-   **Policy Evaluation**: Understanding how AWS evaluates 'Allow' and 'Deny' statements.

---
*Created as part of the Cloud Computing & Virtualisation Module.*
