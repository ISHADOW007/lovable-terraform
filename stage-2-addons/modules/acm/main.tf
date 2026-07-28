#############################################
# ACM Wildcard Certificate
#############################################

resource "aws_acm_certificate" "this" {

  domain_name = "lovable.snapcart.dev"

  subject_alternative_names = [
    "api.snapcart.dev",
    "*.previews.snapcart.dev"
  ]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


#############################################
# DNS Validation Records
#############################################

resource "aws_route53_record" "validation" {

  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options :
    dvo.domain_name => {

      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type

    }
  }

  allow_overwrite = true

  zone_id = var.hosted_zone_id

  name = each.value.name

  type = each.value.type

  ttl = 60

  records = [
    each.value.record
  ]

}


#############################################
# Validate Certificate
#############################################

resource "aws_acm_certificate_validation" "this" {

  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [
    for record in aws_route53_record.validation :
    record.fqdn
  ]

}