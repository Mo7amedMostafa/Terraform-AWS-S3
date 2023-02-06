provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "b" {
  bucket = "${var.project_name}-bucket"
  #bucket_regional_domain_name = "${var.project_name}.s3.${var.region}.amazonaws.com"
  tags = {
    Name        = "${var.project_name}-bucket"
    #Environment = "Dev"
  }
  
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  #acl    = "private"
  #acl    = "public-read"
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      #permissions = ["READ_ACP", "WRITE"]
      permission = "FULL_CONTROL" # READ | WRITE | READ_ACP | WRITE_ACP | FULL_CONTROL
    }
    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
      }
      permission = "READ"
    }
    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
 
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "S3_Domain_Name" {
  value = aws_s3_bucket.b.bucket_regional_domain_name
}