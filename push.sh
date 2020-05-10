# Refer to https://cloud.google.com/container-registry/docs/pushing-and-pulling

# Ensure $GCLOUD_PROJECT_ID is set
: "${GCLOUD_PROJECT_ID?"Need to set GCLOUD_PROJECT_ID"}"

# Build
docker build --tag ghost-google-cloud-run:1.0 .

# Tag
docker tag ghost-cloud-run:1.0 gcr.io/$GCLOUD_PROJECT_ID/ghost-google-cloud-run:1.0

# Push
docker push gcr.io/$GCLOUD_PROJECT_ID/ghost-google-cloud-run:1.0
