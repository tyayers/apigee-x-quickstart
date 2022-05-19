# Apigee X Quickstart

This repo contains scripts for configuring a GCP project and then provisioning an Apigee X instance typical for test or demo use-cases, either directly with shell commands (using gcloud), or with Terraform.

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

## Terraform deployment

The Terraform deployment does the exact same thing as the shell deployment, but just using simpler TF configuration files.

Click to here to open this repository in Google Cloud Shell, along with a tutorial to guide you through the terraform deployment steps:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/tyayers/apigee-x-quickstart&cloudshell_git_branch=master&cloudshell_workspace=.&cloudshell_tutorial=docs/tf-tutorial.md)

```sh
# STEP 1: cd into the terraform dir
cd terraform

# STEP 2: run terraform init on the configuration
terraform init

# STEP 3: apply terraform configuration, creating a project and Apigee X instance
terraform apply --var-file=./x-demo.tfvars -var "project_id=$PROJECT" -var "project_create=true" -var "billing_account=$BILLING_ID"
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