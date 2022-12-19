module "vpc_log_bucket"{
    source = "../modules/s3"
    bucket_name =""
    acl =""
    tags=""
}
module "web_server_log_bucket"{
    source = "../modules/s3"
    bucket_name =""
    acl =""
    tags=""

}
module "cloud_watch_log_bucket"{
    source = "../modules/s3"
    bucket_name =""
    acl =""
    tags=""
}
