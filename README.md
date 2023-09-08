# tfc-agent

To use this thing:
1) terraform init
2) terraform apply
3) aws eks update-kubeconfig --region us-east-2 --name demo
4) kubectl -n agent apply -f agentpool.yml

The above will create a VPC in AWS us-east-2, then 2 EKS clusters and an node group for each cluster.  1 cluster has a public endpoint, while the other is private.  
