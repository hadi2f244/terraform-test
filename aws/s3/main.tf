resource "aws_s3_bucket" "dc_bucket" {
  bucket = "dc-is-better-than-marvel" 
}

resource "aws_s3_object" "upload" {
  bucket = aws_s3_bucket.dc_bucket.id
  key    = "woody.jpg"
  source = "/root/woody.jpg"
}
