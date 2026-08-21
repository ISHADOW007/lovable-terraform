module "external_secrets" {

  source = "./modules/external-secrets"

  cluster_name = data.terraform_remote_state.infra.outputs.cluster_name

  region = var.aws_region

  oidc_provider_arn = data.terraform_remote_state.infra.outputs.oidc_provider_arn

  oidc_provider_url = "https://${data.terraform_remote_state.infra.outputs.oidc_issuer_url}"

  namespace = "external-secrets"

  depends_on = [
    module.secrets
  ]

}





////


module "monitoring" {

  source = "./modules/monitoring"

  certificate_arn = module.platform_acm.certificate_arn

  grafana_host    = "grafana.snapcart.dev"
  prometheus_host = "prometheus.snapcart.dev"

  depends_on = [
    module.external_secrets_config
  ]
}


module "sonarqube" {

  source = "./modules/sonarqube"

  hostname = "sonarqube.snapcart.dev"

  certificate_arn = module.platform_acm.certificate_arn

  jdbc_url      = module.rds.jdbc_url
  jdbc_username = module.rds.username
  jdbc_password = module.rds.password

  depends_on = [
    module.rds,
    module.external_secrets_config
  ]
}




module "rds" {

  source = "./modules/rds"

  name = "sonarqube-db"

  vpc_id = data.terraform_remote_state.infra.outputs.vpc_id

  private_subnet_ids = data.terraform_remote_state.infra.outputs.private_subnet_ids

  eks_node_security_group_id = data.terraform_remote_state.infra.outputs.node_security_group_id

  database_name = "sonarqube"

  username = "sonar"

  password = var.sonarqube_db_password
}



aws secretsmanager restore-secret --secret-id lovable/jenkins --region ap-south-1

aws secretsmanager restore-secret --secret-id lovable/grafana --region ap-south-1

aws secretsmanager restore-secret --secret-id lovable/rds --region ap-south-1

aws secretsmanager restore-secret --secret-id lovable/sonarqube --region ap-south-1



terraform import module.secrets.aws_secretsmanager_secret.jenkins arn:aws:secretsmanager:ap-south-1:457724887427:secret:lovable/jenkins-gxPz8d

terraform import module.secrets.aws_secretsmanager_secret.grafana arn:aws:secretsmanager:ap-south-1:457724887427:secret:lovable/grafana-otsWod

terraform import module.secrets.aws_secretsmanager_secret.rds arn:aws:secretsmanager:ap-south-1:457724887427:secret:lovable/rds-4oW0lb

terraform import module.secrets.aws_secretsmanager_secret.sonarqube arn:aws:secretsmanager:ap-south-1:457724887427:secret:lovable/sonarqube-WriD2c



aws eks update-kubeconfig `
  --region ap-south-1 `
  --name lovable-cluster



  aws s3 rm s3://lovable-terraform-state-457724887427/stage-3-platform/terraform.tfstate.tflock






















































Stage 2: External Secrets Operator

What happens?

In Stage 2, I install the External Secrets Operator using Helm.

Its job is to synchronize secrets from external secret providers (AWS Secrets Manager) into Kubernetes.

It installs:

External Secrets Operator
CRDs (ExternalSecret, ClusterSecretStore, etc.)
Webhook
Cert Controller
RBAC

At this point, the operator is running, but it doesn't know:

Which AWS account?
Which region?
Which secrets?

It's just waiting.

Stage 3: AWS Secrets Manager

Terraform creates secrets in AWS Secrets Manager.

For example:

lovable/jenkins
lovable/grafana
lovable/rds
lovable/sonarqube

These secrets contain values like:

GitHub Token
DockerHub Password
Jenkins Admin Password
SMTP Password

AWS is now the central place where sensitive data is stored.

Stage 3: ClusterSecretStore

Now I create a ClusterSecretStore.

Its job is to tell the External Secrets Operator:

Use AWS Secrets Manager
Region: ap-south-1
Authenticate using IRSA
Use the external-secrets ServiceAccount

Think of it as the connection configuration between Kubernetes and AWS.

It answers "How do I connect to AWS?"

Stage 3: ExternalSecret

Finally, I create an ExternalSecret.

Example:

Read

lovable/jenkins

↓

Create

jenkins-secrets

This tells the operator:

"Read the lovable/jenkins secret from AWS Secrets Manager and create a Kubernetes Secret named jenkins-secrets."

It answers "Which secret should I synchronize?"

Final Flow
Terraform Apply

↓

AWS Secrets Manager
(Create secrets)

↓

External Secrets Operator
(Already installed)

↓

ClusterSecretStore
(How to connect to AWS)

↓

ExternalSecret
(Which secret to read)

↓

Operator reads AWS

↓

Creates Kubernetes Secret

↓

Jenkins / Grafana / SonarQube Pods use the Kubernetes Secret



















What is External Secrets Operator?

"It is a Kubernetes controller that synchronizes secrets from external providers like AWS Secrets Manager into Kubernetes Secrets."

What is ClusterSecretStore?

"It defines how the External Secrets Operator connects to the secret provider, including the provider type, region, and authentication method."

What is ExternalSecret?

"It tells the operator which AWS secret to read and which Kubernetes Secret to create."

Why AWS Secrets Manager?

"We use AWS Secrets Manager as the central, secure storage for credentials instead of storing them in Git or Kubernetes manifests."

Easy way to remember
AWS Secrets Manager → Stores the secrets
External Secrets Operator → Copies the secrets
ClusterSecretStore → Tells the operator how to connect
ExternalSecret → Tells the operator what to copy
Kubernetes Secret → Used by the application




















module "github_webhooks" {

  source = "./modules/github"

  github_owner = var.github_username

  github_token = var.github_token

  jenkins_url = "https://jenkins.snapcart.dev"

  repositories = [
    "distributed-lovable"
  ]
}
