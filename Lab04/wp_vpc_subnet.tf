# Fetching VPC and SubnetIDS

data "aws_vpcs" "eks-vpc" {
  tags = {
    service = "wp-eks"
  }
}

data "aws_subnet_ids" "subnetids" {
  vpc_id = element(tolist(data.aws_vpcs.eks-vpc.ids), 0 )
}