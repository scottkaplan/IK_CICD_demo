# IAC files for IK demo

## To Test
- DNS for ik-bastion.kaplans.com is updated

## To Do
- Run terraform from outside AWS
- Figure out a way to distribute IK.pm in 11-bastion.tf and .aws/credentials in 0-provider.tf
- Test Jenkins ECR deploy to EKS
- add DNS for k8s service

## Setup Playbook
- Bootstrap server
  - Prerequisites
    - terraform
    - .aws/creentials
    - .ssh/IK-pem
    - AWS CLI
  - Procedure
    -  `git clone https://github.com/scottkaplan/IK_CICD_demo.git`
    -  `cd terraform`
    -  `terraform apply`
- Jenkins server
  -   Open Jenkins: https://ik-jenkins.kaplans.com:8080
  Paste initial admin password from 'terraform apply' output
  Install basic plugins
  Install Docker, Docker Pipeline plugins
  Create a job
  - Create a pipeline
  - Pipeline
    - Definition: Pipeline script from SCM
    - SCM: Git
    - Repository URL: https://github.com/scottkaplan/IK_CICD_demo.git
    - Branch specification: */main
- Bastion host
  - Edit .aws/credentials
  - Create ~/.kube/config:
    - `aws eks update-kubeconfig --region us-west-1 --name demo`
  - `kubectl apply -f deployment.yml`

## Developer config

- Edit ~/.git-credentials
- Emacs packages
  - M-x package-install yaml-mode
  - M-x package-install magit
  - M-x package-install jenkinsfile-mode
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

