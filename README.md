# tfc-agent

To use this thing:
1) terraform init
2) terraform apply
3) aws eks update-kubeconfig --region us-east-2 --name demo
4) helm repo add hashicorp https://helm.releases.hashicorp.com
5) helm repo update
6) helm install tfc-agennt-demo hashicorp/terraform-cloud-operator --wait --version 2.0.0-beta8
7) get your TFC API token (docs say to use a the token for the owners team)
8) kubectl create secret generic terraformrc --from-literal=token={API TOKEN}
9) kubectl apply -f agentpool.yml

The above will create a VPC in AWS us-east-2, then an EKS cluster and an node group for that cluster.  Steps 4 through 9 will deploy the terraform cloud operator on the cluster along with an TFC agent pool.
