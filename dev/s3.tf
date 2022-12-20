module "log_bucket" {
  source      = "../modules/s3"
  bucket_name = "logs-bucket"
  acl         = "private"
  #tags=""
}
module "artifact_bucket" {
  source      = "../modules/s3"
  bucket_name = "artifact-bucket"
  acl         = "private"
  #tags=""
}

