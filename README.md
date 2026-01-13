# Automate AWS EKS cluster setup with Karpenter, while utilizing Graviton and Spot instances.

## How to deploy

1. Clone this repo.
2. [Configure AWS IAM role for the pipeline'](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)
3. Go to .github/workflows/deploy.yaml. In line 36, change to your own configured IAM role.
4. Push changes to your remote repo, the pipeline will be triggered on push and it would deploy the infrastructure on AWS.
