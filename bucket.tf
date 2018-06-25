resource "aws_s3_bucket" "main" {
  bucket = "${var.aws_s3_bucket_name}"
  acl    = "${var.aws_s3_acl}"

  versioning {
    enabled = "${var.aws_s3_enable_versioning}"
  }

  tags = "${var.aws_s3_bucket_tags}"
}

resource "aws_s3_bucket_object" "main" {
  bucket = "${aws_s3_bucket.main.id}"
  key    = "index"
  acl    = "public-read"
  source = "./files/index.html"
  etag   = "${md5(file("./files/index.html"))}"
}
