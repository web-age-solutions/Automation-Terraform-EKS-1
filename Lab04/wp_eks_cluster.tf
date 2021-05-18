# Create EKS cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "KubeCluster"
  role_arn = aws_iam_role.eks-cluster-policy.arn


  vpc_config {
    subnet_ids = [aws_subnet.sub1.id, aws_subnet.sub2.id, aws_subnet.sub2.id]
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
  ]

}