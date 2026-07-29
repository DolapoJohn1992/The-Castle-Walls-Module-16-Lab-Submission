# 🛡️ TKH-Fortress-VPC Infrastructure

An enterprise-grade, highly secure Virtual Private Cloud (VPC) environment built on AWS. This repository documents the deployment, subnet routing, and internet gateway configurations for the **TKH-Fortress-VPC** infrastructure.

---

## 📐 Network Architecture Overview

The base network topology establishes a dedicated CIDR block with segmented subnets, explicitly defined route tables, and controlled gateway egress/ingress points.

| Component | Resource Name / ID | Configuration / Scope |
| :--- | :--- | :--- |
| **VPC ID** | `vpc-02c12024a4802838e` | `TKH-Fortress-VPC` |
| **IPv4 CIDR Block** | `10.0.0.0/16` | 65,536 Available IPs |
| **AWS Region** | `us-east-1` | North Virginia |
| **Internet Gateway** | `igw-0291ac594a2eed7c7` | Attached to VPC |

---

## 🌐 Subnet Specifications

### Public Subnet 01

* **Subnet ID:** `subnet-0894bf64dd19080e7`
* **IPv4 CIDR:** `10.0.1.0/24` (251 Available Hosts)
* **Availability Zone:** `us-east-1e`
* **Auto-Assign Public IPv4:** Disabled (`No`)
* **Associated Route Table:** `rtb-096e7e3fc42135664`

#### Route Table Configuration (`rtb-096e7e3fc42135664`)

| Destination | Target | Description |
| :--- | :--- | :--- |
| `10.0.0.0/16` | `local` | Internal VPC Routing |
| `0.0.0.0/0` | `igw-0291ac594a2eed7c7` | Outbound Internet Access via IGW |

---

## 🔒 Security & Connectivity Details

* **Inbound Access Control:** Managed via Security Groups and Network ACLs (`acl-0a8b4d496172b4d2f`).
* **Public Address Policy:** Explicit IPv4 assignment is enforced per-instance launch or via Elastic IP (EIP) attachment to minimize unintended public exposure.

---

## 🛠️ Verification & Deployment Commands

To inspect the subnet details using the AWS CLI:

```bash
aws ec2 describe-subnets \
  --subnet-ids subnet-0894bf64dd19080e7 \
  --region us-east-1