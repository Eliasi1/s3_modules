###################################################################################
# DATA
#################################################################################

data "template_file" "bucket_policy" {
  # template = "${file("${path.module}\\templates\\bucket_policy.tpl")}"
  template = "${file("${var.path_to_bucket_policy}")}"
}

data "template_file" "routing_rule" {
  # template = "${file("${path.module}\\routing_rules\\redirect_docs_documents.tpl")}"
  template = "${file("${var.path_to_routing_rules}")}"
}

data "cloudflare_zones" "zone" {
  filter {
    name   = "${var.domain_name}"
    status = "active"
  }
}

##################################################################################
# RESOURCES
##################################################################################

# S3 Bucket config#

resource "aws_s3_bucket" "web_bucket" {
  bucket = "${var.domain_name}"
  acl = "public-read"
  region = "us-east-1"
  force_destroy = true
  versioning {
    enabled = true
  }
  policy = "${data.template_file.bucket_policy.rendered}"
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = "${data.template_file.routing_rule.rendered}"
  }
  tags = {
    billing = "${var.billing_tag}"
  }

}

# put index.html and error.html

resource "aws_s3_bucket_object" "put_index" {
  bucket = "${aws_s3_bucket.web_bucket.id}"
  key    = "/index.html"
  source = "${var.path_to_index}"
  content_type = "text/html"
  acl = "public-read"
  
}
resource "aws_s3_bucket_object" "put_error" {
  bucket = "${aws_s3_bucket.web_bucket.id}"
  key    = "/error.html"
  source = "${var.path_to_error}"
  content_type = "text/html"
  acl = "public-read"
}

# Cloud flare cname

resource "cloudflare_record" "cname_to_s3" {
  zone_id  = "${lookup(data.cloudflare_zones.zone.zones[0],"id")}"
  name = "${var.domain_name}"
  value = "${aws_s3_bucket.web_bucket.website_endpoint}"
  type = "CNAME"
  proxied = "true"
}

resource "cloudflare_page_rule" "www_redirect" {
  zone_id  = "${lookup(data.cloudflare_zones.zone.zones[0],"id")}"
  target = "www.${var.domain_name}"
  priority = 1
  actions {
    forwarding_url { 
      url = "http://${var.domain_name}"
      status_code = 301
    }
  }
}

resource "cloudflare_page_rule" "always_https" {
  zone_id  = "${lookup(data.cloudflare_zones.zone.zones[0],"id")}"
  target = "${var.domain_name}"
  priority = 1
  actions {
    always_use_https = true
  }
}