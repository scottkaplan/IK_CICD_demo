# IAC setup for IK demo

## Setup Playbook
- Bootstrap server
  - Prerequisites
    - terraform
    - .aws/credentials
    - .ssh/IK-pem
    - AWS CLI
  - Procedure
    - `git clone https://github.com/scottkaplan/IK_CICD_demo.git`
    - `cd terraform`
    - `terraform apply --var aws_credentials_file="/home/scott/.aws/credentials" --var ssh_private_key_file="/home/scott/.ssh/IK.pem"`
       - default home directory is /home/ec2-user/...
- Jenkins server
  - Open Jenkins: https://ik-jenkins.kaplans.com:8080
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
- Create DNS record for LB IP
- name of LB should be demo, not example
- kubectl credentials for user ec2-user on bastion
- use IAM roles instead of .aws/credentials
- lockdown ~jenkins/.aws to 700

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

