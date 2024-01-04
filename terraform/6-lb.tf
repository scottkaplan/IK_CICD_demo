provider "kubernetes" {
  host                   = aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "example"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-name" = "demo"
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "instance"
      "service.beta.kubernetes.io/load-balancer-source-ranges" = "0.0.0.0/0"
      "service.beta.kubernetes.io/aws-load-balancer-scheme": "internet-facing"
    }
  }
  spec {
    selector = {
      app = "web"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

# Create a local variable for the load balancer name.
locals {
  lb_name = split("-", split(".", kubernetes_service.example.status.0.load_balancer.0.ingress.0.hostname).0).0
}

output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_hostname" {
  value = kubernetes_service.example.status.0.load_balancer.0.ingress.0.hostname
}
