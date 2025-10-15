**🚀 DevOps React App – Full CI/CD Deployment on AWS (Jenkins + Docker + Monitoring)**
Author: Hari
GitHub Repo: https://github.com/sriram-R-krishnan/devops-build
Deployed Port: 80 (HTTP)
Public URL: http://<EC2_PUBLIC_IP>
🧩 Project Overview

This project demonstrates a production-ready DevOps pipeline that automates the full lifecycle — from code commit to deployment on AWS EC2, complete with monitoring and email alerts.

**🏗️ Architecture Diagram**
               <img width="1066" height="707" alt="image" src="https://github.com/user-attachments/assets/c28b5cac-6f2a-42b1-a469-f728f5863089" />



**🐳 Dockerization**
Dockerfile
(refer git files)

**⚙️ Bash Scripts**
build.sh (refer git files)
deploy.sh (refer git files)

**🌱 Version Control**
Code pushed to GitHub (dev branch) using CLI.
Included .gitignore and .dockerignore.
Code changes trigger Jenkins automatically.

**🐋 Docker Hub**
Repository	Type	Purpose
hari2821/dev	Public	CI builds from dev branch
hari2821/prod	Private	Production-ready images from master

**⚙️ Jenkins CI/CD Pipeline**
Flow:
Triggered via GitHub Webhook (dev/master branch).
Builds Docker image.
Pushes image to Docker Hub (dev/prod repo).
Deploys container to AWS EC2.
Sends success status on dashboard.
JenkinsFile(refer git files)

**☁️ AWS Setup**

Instance Type: t2.micro
Security Group:
Port 80 → open to all (HTTP access)
Port 22 → restricted to your IP
Deployed App: Accessible at EC2 public IP on port 80.

**📈 Monitoring Setup (Prometheus + Node Exporter + Alertmanager)**
Component	Description
Prometheus	Monitors app metrics & alert rules
Node Exporter	Tracks system metrics
Alertmanager	Sends alert emails when app goes down
Grafana	(Optional) For visualization dashboards

**🔔 Email Alert Example**
When the Node Exporter or App goes down, Alertmanager triggers an email alert:
✅ Received Email:
Subject: [FIRING:1] InstanceDown localhost:9100 (node_exporter critical)
Body:
Instance localhost:9100 has been unreachable for more than 1 minute.
✅ Recovery Email:
When service is back online, you receive a RESOLVED email.

**📧 Alert Configuration**

Detailed configuration files for:

**Prometheus Rule – alert.rules.yml:**

groups:
- name: InstanceDown
  rules:
  - alert: InstanceDown
    expr: up == 0
    for: 1m
    labels:
      severity: critical
    annotations:
      summary: "Instance {{ $labels.instance }} is down"
      description: "{{ $labels.instance }} has been unreachable for more than 1 minute."

**Alertmanager Config – alertmanager.yml:**

global:
  smtp_smarthost: 'smtp.gmail.com:587'
  smtp_from: 'hariharan00619@gmail.com'
  smtp_auth_username: 'hariharan00619@gmail.com'
  smtp_auth_password: 'APP_PASSWORD'
receivers:
  - name: email-alert
    email_configs:
      - to: 'hariharan00619@gmail.com'
        send_resolved: true
route:
  receiver: email-alert

**🧠 Key Highlights**

✅ Fully automated CI/CD (GitHub → Jenkins → Docker Hub → EC2)
✅ Separate Dev & Prod Docker pipelines
✅ Security-hardened AWS setup
✅ Live monitoring with email notifications
✅ Production-grade deployment on port 80

