# Apigee X Quickstart Demo

---

This tutorial shows you how to configure and provision a completely automated GCP project, Apigee X org and instance, and a sample proxy.

Let's get started!

---

## Setup environment

Edit the provided sample `env.sh` file, and set the environment variables there for your deployment.

Click <walkthrough-editor-open-file filePath="env.sh">here</walkthrough-editor-open-file> to open the file in the editor. 

Then, source the `env.sh` file in the Cloud shell.

```sh
source ./env.sh
```
---

## Init Terraform

Now let's init our Terraform deployment.

Click <walkthrough-editor-open-file filePath="./terraform/main.tf">here</walkthrough-editor-open-file> to open the base configuration, including the GCP project configuration, org policies, and networking config.

Click <walkthrough-editor-open-file filePath="./terraform/x-demo.tfvars">here</walkthrough-editor-open-file> to open the Apigee X configuration settings for the deployment, including creating two environments, dev and test.

Now let's init our configuration:

```sh
cd terraform
terraform init
```

This will set the correct org policies that Apigee needs for a typical demo or test environment.

<walkthrough-footnote>This is just an example configuration, you can customize the policies and provisioning as needed for your organization.</walkthrough-footnote>

---

## Apply Terraform configuration

Now we are ready to apply the configuration, which will create our GCP project, the Apigee X instance and environments, and a load balancer and certificate to reach our API endpoints.

```sh
terraform apply --var-file=./x-demo.tfvars -var "project_id=$PROJECT" -var "project_create=true" -var "billing_account=$BILLING_ID"
```

---

## Deploy an Apigee proxy directly from an OpenAPI spec

Now that we have our Apigee org and environment, we can easily deploy an API proxy using an API spec. The easiest way to do this is using the tool [apigeecli](https://github.com/apigee/apigeecli). Let's first install the tool by running this command.

```sh
curl -L https://raw.githubusercontent.com/apigee/apigeecli/master/downloadLatest.sh | sh -
export PATH=$PATH:$HOME/.apigeecli/bin
```

Now we can create a proxy based on the famous `petstore` OpenAPI spec.

```sh
TOKEN=$(gcloud auth print-access-token)
apigeecli apis create openapi -n petstore -u https://raw.githubusercontent.com/apigee/apigeecli/master/test/petstore.yaml -t $TOKEN -o $PROJECT
```

This creates and imports a proxy into Apigee based on the OpenAPI spec.

Now let's deploy the proxy into one of our Apigee environments (`dev` or `prod`).

```sh
apigeecli apis deploy -n petstore -o $PROJECT -t $TOKEN -r -e dev -v 1
```

Now check out the deployed proxy in the [Apigee console](https://apigee.google.com). To test the API, you will need to create an app and credentials (see the [Apigee docs](https://cloud.google.com/apigee/docs/api-platform/tutorials/secure-calls-your-api-through-api-key-validation) for more information.)

---

## Deploy an Apigee proxy using a template

Now let's deploy a simple proxy based on a JSON template. For this we can use a tool called [apigee-templater]() that will automate the creating and deployment of the proxy.

[Open](https://raw.githubusercontent.com/apigee/apigee-templater/main/examples/users.json) the template file in a browser to see the definition (proxying user data and adding a rate limit).

```sh
# STEP 1: install the apigee-templater-cli for easy proxy templating (more information at github.com/apigee/apigee-templater)
npm i -g apigee-templater-cli

# STEP 2: template and deploy a test proxy to the 'test' environment for user data
apigee-template -f https://raw.githubusercontent.com/apigee/apigee-templater/main/examples/users.json -d -e test
```

Now you should see a URL displayed after the proxy deployment that you can call to test the proxy. Try calling using `curl` or just open the link in your browser (it takes a few seconds for the deployment to complete). Try calling it too often to invoke the spike arrest to throttle traffic.

---

## Conclusion
<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You've successfully provisioned Apigee X and are ready to deploy more proxies.

<walkthrough-inline-feedback></walkthrough-inline-feedback>