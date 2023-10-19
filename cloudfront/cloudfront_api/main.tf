module "cloudfront" {
source = "../Lib"
aliases = ["boomi.fun"]
comment             = "LIVE - Hardcore API"
enabled             = true
http_version        = "http2"
is_ipv6_enabled     = true
price_class         = "PriceClass_All"
retain_on_delete    = false
wait_for_deployment = false
# web_acl_id          = "arn:aws:wafv2:us-east-1:227950108070:global/webacl/test/237d594e-a1a9-4dc5-9e93-9ccbbff5adca"

# When you enable additional metrics for a distribution, CloudFront sends up to 8 metrics to CloudWatch in the US East (N. Virginia) Region.
# This rate is charged only once per month, per metric (up to 8 metrics per distribution).
create_monitoring_subscription = true

create_origin_access_identity = true
origin_access_identities = {
  s3_bucket_one = "My awesome CloudFront can access",
  s3_test_2     = "test2",
  s3_test_3     = "test3",
  s3_test_4     = "test4"
}

create_origin_access_control = true
origin_access_control = {
  s3_oac = {
    description      = "CloudFront access to S3"
    origin_type      = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
  }
}

# logging_config = {
#   bucket          = "configurationfilesaboutmonitoring.s3.amazonaws.com"
#   prefix          = "cloudfront"
#   include_cookies = false
# }

origin = {
  fh-57-maintanance = {
    domain_name         = "configurationfilesaboutmonitoring.s3.amazonaws.com"
    connection_attempts = 3
    connection_timeout  = 10
    custom_header       = []
    s3_origin_config = {
      origin_access_identity = "s3_bucket_one" # key in `origin_access_identities`
      # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
    }

    origin_shield = {
      enabled              = false
      origin_shield_region = "us-east-1"
    }
  }

  falcon-mcs-store-main = { # with origin access identity (legacy)
    domain_name         = "d-bvg6nxsbv1.execute-api.com"
    origin_path         = "/main/v1"
    connection_attempts = 3
    connection_timeout  = 10
    custom_origin_config = {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      origin_read_timeout      = 30
      origin_keepalive_timeout = 5
    }
    origin_shield = {
      enabled              = false
      origin_shield_region = "us-east-1"
    }

  }
#   falcon-menu-bucket = { # with origin access identity (legacy)
#     domain_name         = "test.com"
#     connection_attempts = 3
#     connection_timeout  = 10
#     custom_header       = []
#     # s3_origin_config = {
#     #   origin_access_identity = "s3_test_2" # key in `origin_access_identities`
#     #   # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
#     # }

#     origin_shield = {
#       enabled              = false
#       origin_shield_region = "us-east-1"
#     }
#   }
  prod_foodhub_alb = { # with origin access identity (legacy)
    domain_name = "boomi.test"
    custom_origin_config = {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      origin_read_timeout      = 30
      origin_keepalive_timeout = 5
    }
    connection_attempts = 3
    connection_timeout  = 10
    custom_header       = []
    origin_shield = {
      enabled              = false
      origin_shield_region = "us-east-1"
    }
  }
#   S3-fh-internationalization = { # with origin access identity (legacy)
#     domain_name         = "mytestbucketfortraining.com"
#     connection_attempts = 3
#     connection_timeout  = 10
#     custom_header       = []
#     # s3_origin_config = {
#     #   origin_access_identity = "s3_test_3" # key in `origin_access_identities`
#     #   # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
#     # }

#     origin_shield = {
#       enabled              = false
#       origin_shield_region = "us-east-1"
#     }
#   }
  ELB-frontend-alb-aus-1452346864 = { # with origin access identity (legacy)
    domain_name = "dadedf.online.com"
    custom_origin_config = {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      origin_read_timeout      = 60
      origin_keepalive_timeout = 5
    }
    connection_attempts = 3
    connection_timeout  = 10
    custom_header       = []
    origin_shield = {
      enabled              = false
      origin_shield_region = "us-east-1"
    }
  }
#  prod-cloudfiles-public = { # with origin access identity (legacy)
 #   domain_name         = "my-test-bucket-for-terraform.com"
  #  connection_attempts = 3
 #   connection_timeout  = 10
 #   custom_header       = []
  #  s3_origin_config = {
  #    origin_access_identity = "s3_test_4" # key in `origin_access_identities`
      # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
  #  }

 #   origin_shield = {
 #     enabled              = false
  #    origin_shield_region = "us-east-1"
  #  }
#  }
  falcon-origin = { # with origin access identity (legacy)
    domain_name = "testboomi.com"
    custom_origin_config = {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      origin_read_timeout      = 30
      origin_keepalive_timeout = 5
    }
    connection_attempts = 3
    connection_timeout  = 10
    custom_header       = []
    origin_shield = {
      enabled              = false
      origin_shield_region = "us-east-1"
    }
  }
}

origin_group = {
  falcon-group = {
    failover_status_codes      = [403, 404, 500, 502, 503, 504]
    primary_member_origin_id   = "falcon-origin"
    secondary_member_origin_id = "ELB-frontend-alb-aus-1452346864"
  }
}

default_cache_behavior = {
  target_origin_id         = "ELB-frontend-alb-aus-1452346864"
  viewer_protocol_policy   = "allow-all"
  allowed_methods          = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
  cached_methods           = ["GET", "HEAD", "OPTIONS"]
  compress                 = false
  query_string             = true
  smooth_streaming         = false
  compress                 = false
  cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"


}

ordered_cache_behavior = [
  {
    path_pattern           = "/orders/search"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    min_ttl         = 0
    default_ttl     = 0
    max_ttl         = 0


    smooth_streaming = false
    compress         = false

    query_string = false
    cookies = {
      forward = "all"
    }
    headers = ["*"]



    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/consumer/menu*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    min_ttl         = 0
    default_ttl     = 180
    max_ttl         = 3600


    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["*"]
    }


    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },

  {
    path_pattern           = "/consumer/store/*/menu/*.json"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    min_ttl         = 300
    default_ttl     = 300
    max_ttl         = 300


    smooth_streaming = false
    compress         = false
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "none"
      }
      query_string_cache_keys = ["date", "v"]

    }


    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },

  {
    path_pattern           = "/consumer/store/*/addons/*.json"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    min_ttl         = 60
    default_ttl     = 60
    max_ttl         = 60


    smooth_streaming = false
    compress         = false
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "none"
      }
      query_string_cache_keys = ["date", "v"]

    }


    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/consumer/store/lookup/preorder*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0


    smooth_streaming = false
    compress         = false
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["Authorization",
        "Origin",
        "franchise",
        "passport",
        "api-token",
        "api_token",
        "Referer",
        "Store",
        "Host",
        "locale"
      ]


    }
  },
  {
    path_pattern           = "/consumer/store*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 3600


    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["*"]


    }
  },
  {
    path_pattern           = "/oauth*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0


    smooth_streaming = false
    compress         = false
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["*"]


    }
  },
  {
    path_pattern           = "/v1/oauth*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods  = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    min_ttl          = 0
    default_ttl      = 0
    max_ttl          = 0
    smooth_streaming = false
    compress         = false
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["*"]
    }
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/location/initial*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods  = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    min_ttl          = 0
    default_ttl      = 86400
    max_ttl          = 31536000
    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["*"]
    }
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/product/1/platform/features*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods  = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    min_ttl          = 3600
    default_ttl      = 86400
    max_ttl          = 31536000
    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["Origin",
        "Authorization",
        "franchise",
        "passport",
        "api-token",
        "api_token",
        "Referer",
        "store",
        "locale",
      "region"]
    }
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/lookup/product/1/policy*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods  = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    min_ttl          = 3600
    default_ttl      = 86400
    max_ttl          = 31536000
    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["Origin",
        "Authorization",
        "franchise",
        "passport",
        "api-token",
        "api_token",
        "Referer",
        "store",
        "locale",
      "region"]
    }
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/consumer/takeaway/rating*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "allow-all"

    allowed_methods  = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    min_ttl          = 3600
    default_ttl      = 86400
    max_ttl          = 31536000
    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "all"
      }
      headers = ["Origin",
        "Authorization",
        "franchise",
        "passport",
        "api-token",
        "api_token",
        "Referer",
        "store",
        "locale",
      "region"]
    }
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/lang/*"
    target_origin_id       = "ELB-frontend-alb-aus-1452346864"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods  = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    min_ttl          = 0
    default_ttl      = 0
    max_ttl          = 0
    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = false
      cookies = {
        forward = "none"
      }
      headers = ["Origin",
        "Access-Control-Request-Method",
      "Access-Control-Request-Headers"]
    }
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/selfsignup/account/otp*"
    target_origin_id       = "fh-57-maintanance"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods  = ["GET", "HEAD"]

    smooth_streaming = false
    compress         = true
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/static/*"
    target_origin_id       = "fh-57-maintanance"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    min_ttl         = 0
    default_ttl     = 86400
    max_ttl         = 31536000

    smooth_streaming = false
    compress         = true
    forwarded_values = {
      query_string = true
      cookies = {
        forward = "none"
      }
      headers = ["Origin",
        "Access-Control-Request-Method",
      "Access-Control-Request-Headers"]
    }
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  },
  {
    path_pattern           = "/consumer/preorderevent*"
    target_origin_id       = "falcon-mcs-store-main"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "POST", "PUT", "PATCH"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    query_string    = false

    smooth_streaming = false
    compress         = false
    #   function_association = {
    #     # Valid keys: viewer-request, viewer-response
    #     viewer-request = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }

    #     viewer-response = {
    #       function_arn = aws_cloudfront_function.example.arn
    #     }
    #   }
  }

]

viewer_certificate = {
  acm_certificate_arn            = "arn:aws:acm:us-east-1:485042690341:certificate/3e9a2566-b11c-4a17-a0ad-82b57aae9a01"
  cloudfront_default_certificate = false
  ssl_support_method             = "sni-only"
  minimum_protocol_version       = "TLSv1.1_2016"
}

custom_error_response = [{
  error_code            = 403
  response_code         = "200"
  response_page_path    = "/index.html"
  error_caching_min_ttl = 300
  }
]

geo_restriction = {
  restriction_type = "none"
}



######
# ACM
######
}
