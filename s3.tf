resource "aws_s3_bucket" "one" {
  bucket = "webserver.bucket1213"
}
resource "aws_s3_bucket_ownership_controls" "two" {
  bucket = aws_s3_bucket.one.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }

}
resource "aws_s3_bucket_acl" "three" {
  depends_on = [aws_s3_bucket_ownership_controls.two]
  bucket     = aws_s3_bucket.one.id
  acl        = "private"
}
resource "aws_s3_bucket_versioning" "four" {
  bucket = aws_s3_bucket.one.id
  versioning_configuration {
    status = "Enabled"
  }
}