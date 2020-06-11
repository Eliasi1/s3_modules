This module create a bucket, define it as static web host, put index and error html files into the bucket and define routing rules, create cloudflare Cname record for website endpoint and page rules: www to root and always use https

required variables:
billing_tag - billing tag of the resource
domain - domain name for the website 
path_to_error - path to html error file
path_to_index - path to html index file
path_to_bucket_policy - path to S3 web bucket policy
path_to_routing_rules - path to S3 web bucket routing rules


usage example

module "static_web" {
  source = "../static_web"

  domain_name = "eliasi.club"
  billing_tag = "123456"
  path_to_index = "C:\\temp\\tasks\\production\\S3_module\\calling_for_module\\index.html"
  path_to_error = "C:\\temp\\tasks\\production\\S3_module\\calling_for_module\\error.html"
  path_to_bucket_policy = "C:\\temp\\tasks\\production\\S3_module\\calling_for_module\\templates\\bucket_policy.tpl"
  path_to_routing_rules = "C:\\temp\\tasks\\production\\S3_module\\calling_for_module\\routing_rules\\redirect_docs_documents.tpl"
}
output "website_endpoint" {
  value = "${module.static_web.website_endpoint}"
}

output "bucket_name" {
  value = "${module.static_web.bucket_name}"
}