# IAC setup for IK demo

## Setup Playbook
- Bootstrap server (https://github.com/scottkaplan/IK_CICD_demo/bootstrap/bootstrap.sh)
  - Prerequisites
    - AWS CLI
    - terraform
    - .aws/credentials
    - .ssh/IK-pem
  - Procedure
    - `git clone https://github.com/scottkaplan/IK_CICD_demo.git`
    - `cd terraform`
    - `terraform init`
    - `terraform apply`
- Jenkins server
  - Open Jenkins: http://ik-jenkins.kaplans.com:8080
    - Paste initial admin password from 'terraform apply' output
    - Install basic plugins
    - Install Docker, Docker Pipeline plugins
  - Create a job
    - Create a pipeline
    - Pipeline
      - GitHub hook trigger for GITScm polling
      - Definition: Pipeline script from SCM
        - SCM: Git
        - Repository URL: https://github.com/scottkaplan/IK_CICD_demo.git
        - Branch specification: */main

## To Do
- use IAM roles instead of .aws/credentials

## Developer config

- Edit ~/.git-credentials
- Emacs packages
  - M-x package-install magit
  - M-x package-install yaml-mode
  - M-x package-install groovy-mode
  - M-x package-install terraform-mode

## One-time config

- AWS
  - create ECR repository:
    - `aws ecr create-repository --repository-name hello-repository --region us-west-1`
  - create ssh keys
- Github
  - Webhook
    - Payload URL: http://ik-jenkins.kaplans.com:8080/github-webhook/
    - Content type: application/json
    - Let me select individual events: Pull request, Pushes

