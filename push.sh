# Refer to https://cloud.google.com/container-registry/docs/pushing-and-pulling

# Ensure $GCLOUD_PROJECT_ID is set
: "${GCLOUD_PROJECT_ID?"Need to set GCLOUD_PROJECT_ID"}"

IMAGE=ghost-google-cloud-run
TAG=1.0

# Build
docker build --tag $IMAGE:$TAG .

# Tag
docker tag $IMAGE:$TAG gcr.io/$GCLOUD_PROJECT_ID/$IMAGE:$TAG

# Push
docker push gcr.io/$GCLOUD_PROJECT_ID/$IMAGE:$TAG
