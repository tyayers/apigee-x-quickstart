# Apigee X Quickstart

This repo contains scripts for configuring a GCP project and then provisioning an Apigee X instance typical for test or demo use-cases, either directly with shell commands (using gcloud), or with Terraform.

## Terraform deployment

The Terraform deployment creates the project, Apigee X runtime, environments, groups, and public load balancer with HTTPS certificate.

Click to here to open this repository in Google Cloud Shell, along with a tutorial to guide you through the terraform deployment steps:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/tyayers/apigee-x-quickstart&cloudshell_git_branch=master&cloudshell_workspace=.&cloudshell_tutorial=docs/tf-tutorial.md)

Or clone this repository and run these commands.

```sh
# Clone the repository and switch to the directory
git clone https://github.com/tyayers/apigee-x-quickstart.git; cd apigee-x-quickstart

# Copy the env file and add your own project and billing information
cp 1_env.sh 1_env.dev.sh
# Edit the 1_env.dev.sh file with your project and billing information
source 1_env.dev.sh

# Run terraform init on the configuration
cd tf
terraform init

# Apply the terraform configuration for Apigee eval, creating a project and Apigee X instance and two environments (dev and prod)
terraform apply --var-file=./x-eval.tfvars \
-var "project_id=$PROJECT_ID" \
-var "project_create=true" \
-var "billing_account=$BILLING_ID" \
-var "apigee_admin=$APIGEE_ADMIN"

# Destroy project when finished
terraform destroy --var-file=./x-eval.tfvars \
-var "project_id=$PROJECT_ID" \
-var "project_create=true" \
-var "billing_account=$BILLING_ID" \
-var "apigee_admin=$APIGEE_ADMIN"
```


## Shell deployment

If you would like to deploy everything just using a shell and the gcloud CLI (authenticated with a user with Organization Adminstrator rights), run these commands as described.

Click to here to open this repository in Google Cloud Shell, along with a tutorial to guide you through the shell deployment steps:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/tyayers/apigee-x-quickstart&cloudshell_git_branch=master&cloudshell_workspace=.&cloudshell_tutorial=docs/shell-tutorial.md)

```sh
# STEP 1: First edit the env.sh file with your environment variables
nano env.sh # or just open in your favorite editor

# STEP 2: Source env.sh to set environment variables
source env.sh

# STEP 3: cd into the shell directory
cd shell

# STEP 4 (Optional): create the GCP project and associate it to the billing id
./create-project.sh

# STEP 4: Run the prepare script as an org policy admin to set the GCP project org policies for a demo Apigee X instance
./prepare-project.sh

# STEP 5: Provision Apigee and test a first proxy
./provision-apigee.sh

```

## Deploy a test proxy

```sh
# STEP 1: install the apigee-templater-cli for easy proxy templating (more information at github.com/apigee/apigee-templater)
npm i -g apigee-templater-cli

# STEP 2: template and deploy a test proxy to the 'test' environment for user data
apigee-template -f https://raw.githubusercontent.com/apigee/apigee-templater/main/examples/users.json -d -e test

# STEP 3: Open the Apigee console, open the proxy configuration for UsersProxy-v1, wait for the deployment to complete, and then start a debug session
open https://apigee.google.com

# STEP 4: curl the proxy URL to see data, then observe the debug information in the Apigee console
curl #URL

# Quickstart complete!

```