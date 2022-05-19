#!/bin/bash

# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

gcloud services enable orgpolicy.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com

echo "Setting organizational policy configuration..."
PROJECT_NUMBER=$(gcloud projects list --filter="$(gcloud config get-value project)" --format="value(PROJECT_NUMBER)")

sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/requireOsLogin.yaml
sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/allowedPolicyMemberDomains.yaml
sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/requireShieldedVm.yaml
sed -i "s@{PROJECTNUMBER}@$PROJECT_NUMBER@" policies/vmExternalIpAccess.yaml

gcloud org-policies set-policy ./policies/requireOsLogin.yaml --project=$PROJECT
gcloud org-policies set-policy ./policies/allowedPolicyMemberDomains.yaml --project=$PROJECT
gcloud org-policies set-policy ./policies/requireShieldedVm.yaml --project=$PROJECT
gcloud org-policies set-policy ./policies/vmExternalIpAccess.yaml --project=$PROJECT

echo "Create network, if it doesn't exist..."
gcloud services enable compute.googleapis.com
gcloud compute networks create $NETWORK
