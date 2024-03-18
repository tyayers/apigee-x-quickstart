terraform destroy --var-file=./x-demo.tfvars \
-var "project_id=$PROJECT_ID" \
-var "project_create=true" \
-var "billing_account=$BILLING_ID" \
-var "apigee_admin=$APIGEE_ADMIN"