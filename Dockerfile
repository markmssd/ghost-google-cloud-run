# https://hub.docker.com/_/ghost/
FROM ghost:3.15.1-alpine

# Needs to be in versions/<version>/core/server/adapters
ENV GHOST_STORAGE $GHOST_INSTALL/versions/$GHOST_VERSION/core/server/adapters/storage

# Copy our custom config files
COPY config.production.json .

# Optional since already running in Google, but
# Uncomment/rename if using another storage, e.g. AWS S3
# COPY gcs-service-account.json .

# Install the GCS storage adapter
RUN yarn add ghost-v3-google-cloud-storage --no-lockfile \
    # Create the GCS storage adapter directory
    && mkdir -p "$GHOST_STORAGE/gcs" \
    # Move the GCS storage adapter to the correct location so Ghost can find it
    && mv node_modules/ghost-v3-google-cloud-storage/* "$GHOST_STORAGE/gcs/" \
    # Clean up after `yarn add`
    && rm -rf node_modules package.json \
    # Install the adapter's dependencies
    && cd "$GHOST_STORAGE/gcs/" && yarn install --prod

# Go back to Ghost dir
WORKDIR $GHOST_INSTALL
