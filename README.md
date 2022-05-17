# Apigee X Quickstart

This repo contains scripts for configuring a GCP project and then provisioning an Apigee X instance typical for test or demo use-cases.

You can directly start a tutorial in Google Cloud Shell here:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/tyayers/apigee-x-quickstart&cloudshell_git_branch=master&cloudshell_workspace=.&cloudshell_tutorial=docs/tutorial.md)

## Deployment

To deploy in your own environment, simply clone this repo and execute the following commands as a user with the Organization Policy Administrator role (or together with someone with that role).

```sh
# STEP 1: First edit the env.sh file with your environment variables
nano env.sh

# STEP 2: Source env.sh to set environment variables
source env.sh

# STEP 3: Run the prepare script as an org policy admin to set the GCP project org policies for a demo Apigee X instance
./prepare-project.sh

# STEP 4: Provision Apigee and test a first proxy
./provision-apigee.sh

```