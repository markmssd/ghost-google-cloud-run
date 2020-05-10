# Run Ghost on Google Cloud Run

![Ghost on Google Cloud](https://repository-images.githubusercontent.com/262830411/43b05c00-92c7-11ea-83bd-379da3c37361)

## Instructions

By default, Ghost uses a local SQLite database, and the filesystem as a storage.

In order to run Ghost as a "Stateless" app in Google Cloud Run, we need to:

1) Use an external MySQL database
2) Use an external storage engine

#### 1) Use an external MySQL database
You can use whichever you want, [Google Cloud MySQL](https://cloud.google.com/sql), [Amazon RDS](https://aws.amazon.com/rds), [Azure MySQL](https://azure.microsoft.com/en-us/services/mysql), [Compose MySQL](https://www.compose.com/databases/mysql), etc. I recommend using Google Cloud MySQL if you don't mind paying a small fee, to keep everything with the same provider. Personally, I chose Amazon RDS while developing, for their generous 12-months free tier. However, when I'll be ready for production, I will move to Google Cloud MySQL.

#### 2) Use an external storage engine
You can choose [Google Cloud Storage](https://cloud.google.com/storage) (using [ghost-v3-google-cloud-storage](https://github.com/mikenikles/ghost-v3-google-cloud-storage)), [Amazon S3](https://aws.amazon.com/s3) (using [ghost-storage-adapter-s3](https://github.com/colinmeinke/ghost-storage-adapter-s3)), or any other storage adapter they [support](https://ghost.org/integrations/storage). Since we'll be running in Google Cloud Run, I recommend using Google Cloud Storage. This is what this example uses.


## USAGE

```
GCLOUD_PROJECT_ID=your-project-id sh push.sh
```

Now your image is waiting in your [Google Container Registry](https://cloud.google.com/container-registry), and ready to use by Google Cloud Run.

You will need to set some environment variables in your Google Cloud Run service before creating it. If you take a look at `./config.production.json`, you will see that the `url`, the MySQL connection configs are needed, as well as the GCS bucket. Since Ghost uses [nconf](https://www.npmjs.com/package/nconf), you can easily set them as environment variables:

```
url                             = www.mydomain.com
database__connection__host      = my-db.us-east-xyz.rds.amazonaws.com
database__connection__database  = my-db
database__connection__user      = my-db-user
database__connection__password  = my-db-pass
storage__gcs__bucket            = my-google-bucket
```

_Refer to [Ghost Configuration Docs](https://ghost.org/docs/concepts/config/#configuration-options) for more info._

_Note about `url`: With Google Cloud Run, you can map your service to a custom domain. If you know in advance what it'll be, you can already set it. Otherwise, you can set it to your service's URL then restart it._

That's it! You are now running a *FREE* (if you used AWS RDS) Ghost blog on Google Cloud 🎉
