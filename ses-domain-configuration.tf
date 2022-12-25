resource "aws_route53_zone" "example" {
  name = "reportinfo.email"
  vpc {
    vpc_id = "vpc-075818300fb751ea2"
  }
}


variable "domain" {
  default ="reportinfo.email"
}

resource "aws_ses_domain_identity" "example" {
    domain = var.domain
}


resource "aws_ses_domain_dkim" "example" {
    domain = aws_ses_domain_identity.example.domain
}
resource "aws_route53_record" "example_amazonses_verification_record" {
    zone_id = aws_route53_zone.example.zone_id 
    name = "amazonses"
    type = "TXT"
    ttl = "600"
    records = [aws_ses_domain_identity.example.verification_token]
}

resource "aws_route53_record" "example_amazonses_dkim_recoed" {
    count = 3
    zone_id = aws_route53_zone.example.zone_id
    name = "${element(aws_ses_domain_dkim.example.dkim_tokens, count.index)}._domainkey"
    type = "CNAME"
    ttl = "600"
    records = ["${element(aws_ses_domain_dkim.example.dkim_tokens, count.index)}.dkim.amazonses.com"]
}