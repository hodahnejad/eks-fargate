module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name    = local.cluster_name
  cluster_version = "1.24"

  vpc_id     = "vpc-xxx"
  subnet_ids = ["subnet-xxx", "subnet-xxx"]

  cluster_endpoint_public_access = true

  fargate_profiles = {
    coredns-fargate-profile = {
      name = "coredns"
      selectors = [
        {
          namespace = "kube-system"
          labels = {
            k8s-app = "kube-dns"
          }
        },
        {
          namespace = "default"
        },
        {
          namespace = "hnejad"
          labels = {
            k8s-app = "kube-dns"
          }
        }

      ]
      subnet_ids = ["subnet-xxx", "subnet-xxx"]
    }
  }



}
