TOKEN=$(gcloud auth print-access-token)
ENVIRONMENT_TYPE=COMPREHENSIVE
ENV_GROUP_NAME="test-env-group"
ENV_GROUP_HOSTNAME="34.149.15.36.nip.io"
INSTANCE_NAME="europe-west1"
NUMBER_OF_ENVIRONMENTS=3
export GOOGLE_CLOUD_PROJECT=$(gcloud config get project)

COUNTER=1

while [ $COUNTER -le $NUMBER_OF_ENVIRONMENTS ]
do
    ENVIRONMENT_NAME="env-$COUNTER"

    echo "Creating environment $ENVIRONMENT_NAME"

    RESULT=$(curl --location --request POST "https://apigee.googleapis.com/v1/organizations/$GOOGLE_CLOUD_PROJECT/environments" \
    --header "Authorization: Bearer $TOKEN" \
    --header "Content-Type: application/json" \
    -X POST \
    -d "{
      "name":"'"$ENVIRONMENT_NAME"'",
      "type":"'"$ENVIRONMENT_TYPE"'"
    }")

    echo $RESULT

    COUNTER=$(( $COUNTER + 1 ))
done

sleep 5s

COUNTER=1

while [ $COUNTER -le $NUMBER_OF_ENVIRONMENTS ]
do
    ENVIRONMENT_NAME="env-$COUNTER"

    echo "Attaching environment $ENVIRONMENT_NAME to instance $INSTANCE_NAME"

    RESULT=$(curl --location --request POST "https://apigee.googleapis.com/v1/organizations/$GOOGLE_CLOUD_PROJECT/instances/$INSTANCE_NAME/attachments" \
    --header "Authorization: Bearer $TOKEN" \
    --header "Content-Type: application/json" \
    -X POST \
    -d "{
      "environment":"'"$ENVIRONMENT_NAME"'"
    }")

    echo $RESULT

    COUNTER=$(( $COUNTER + 1 ))
done

sleep 5s

COUNTER=1

while [ $COUNTER -le $NUMBER_OF_ENVIRONMENTS ]
do
    ENVIRONMENT_NAME="env-$COUNTER"

    echo "Attaching environment $ENVIRONMENT_NAME to env group $ENV_GROUP_NAME"

    RESULT=$(curl --location --request POST "https://apigee.googleapis.com/v1/organizations/$GOOGLE_CLOUD_PROJECT/envgroups/$ENV_GROUP_NAME/attachments" \
    --header "Authorization: Bearer $TOKEN" \
    --header "Content-Type: application/json" \
    -X POST \
    -d "{
      "environment":"'"$ENVIRONMENT_NAME"'"
    }")

    echo $RESULT

    COUNTER=$(( $COUNTER + 1 ))
done