# Apigee X Quickstart Demo

---

This tutorial shows you how to configure and provision a completely automated Apigee X org and instance. These scripts assume that the GCP organizational policy administrator is executing the `prepare-project.sh` script (which sets the organizational policies needed for further provisioning).

Then the `provision-apigee.sh` script can be executed by either the org admin or project owner.

Let's get started!

---

## Setup environment

Edit the provided sample `env.sh` file, and set the environment variables there for your deployment.

Click <walkthrough-editor-open-file filePath="env.sh">here</walkthrough-editor-open-file> to open the file in the editor

Then, source the `env.sh` file in the Cloud shell.

```sh
source ./env.sh
```
---

## Create GCP project

In case you don't have a GCP project created, we can create one here.

Click <walkthrough-editor-open-file filePath="./shell/create-project.sh">here</walkthrough-editor-open-file> to open the file in the editor, and see the commands that will be run.

Now let's run the script:

```sh
cd shell
chmod +x create-project.sh && ./create-project.sh
```

This will set the correct org policies that Apigee needs for a typical demo or test environment.

<walkthrough-footnote>This is just an example configuration, you can customize the policies and provisioning as needed for your organization.</walkthrough-footnote>

---

## Prepare GCP project

Now let's prepare our GCP project.  

Click <walkthrough-editor-open-file filePath="./shell/prepare-project.sh">here</walkthrough-editor-open-file> to open the file in the editor, and see the commands to set the org policies, and add an admin user to the project.

Now let's run the script:

```sh
chmod +x prepare-project.sh && ./prepare-project.sh
```

This will set the correct org policies that Apigee needs for a typical demo or test environment.

<walkthrough-footnote>This is just an example configuration, you can customize the policies and provisioning as needed for your organization.</walkthrough-footnote>

---

## Provision Apigee X

Now let's provision Apigee X. Executing the provision script will enable all needed APIs, provision both the Apigee X instance in the specified region as well as a public load balancer and test certificate (for more information see the [Apigee DevRel docs](https://github.com/apigee/devrel/tree/main/tools/apigee-x-trial-provision)).

```sh
chmod +x provision-apigee.sh && ./provision-apigee.sh
```

---

## Deploy an Apigee proxy using a template

Now let's deploy a simple proxy based on a JSON template. For this we can use a tool called `apigee-templater` that will automate the creating and deployment of the proxy.

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