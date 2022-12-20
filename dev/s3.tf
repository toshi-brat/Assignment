module "log_bucket"{
    source = "../modules/s3"
    bucket_name = "Logs_Bucket"
    acl = "private"
    #tags=""
}
module "backup_bucket"{
    source = "../modules/s3"
    bucket_name = "Backup_Bucket"
    acl = "private"
    #tags=""
}

