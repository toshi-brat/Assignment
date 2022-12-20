resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  #tag = vat.#tags
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = var.acl
}