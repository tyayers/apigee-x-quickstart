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

if [ -z "$PROJECT" ]
then
echo "No PROJECT variable set"
exit
fi

if [ -z "$LOCATION" ]
then
echo "No LOCATION variable set"
exit
fi

TOKEN=$(gcloud auth print-access-token)

echo "Creating default network..."
gcloud compute networks create default

echo "Testing if Apigee X is provisioned..."
RUNTIME_IP=$(gcloud compute addresses describe lb-ipv4-vip-1 --format="get(address)" --global --project "$PROJECT" --quiet)
if [ -z "$RUNTIME_IP" ]
then
echo "Provisioning Apigee..."
curl -L https://raw.githubusercontent.com/apigee/devrel/main/tools/apigee-x-trial-provision/apigee-x-trial-provision.sh | bash -
fi