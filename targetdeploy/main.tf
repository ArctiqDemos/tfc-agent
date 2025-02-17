terraform {
  cloud {
    organization = "ArctiqTeam"

    workspaces {
      name = "tf-agent-demo"
    }
  }
}

locals {
  host = "https://59553E6A3FB29CFF73CA20132A547788.gr7.us-east-2.eks.amazonaws.com"
  cert = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJVFRZbTQ3OXQ3Z3d3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TXpBNU1EZ3hNelU0TXpaYUZ3MHpNekE1TURVeE16VTRNelphTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURXeXFKZEFyanh4Z25BQ0V0UXhEQStxY0FUWDZvamVGeFVOM1VuaFF3a1VDci9NMWQ2Y2RaZ29YbkIKbmdyS3E1WUdxZGF1SmFiYTdhUmllYlhFbTVwM0ZPNE42TXJ0LzBmS0YvSGhPR2tmamtXOXJWd2lNUE44MFo0MwoyTjFaVWdVdytpL1RLb0UwcjhrNmZidk9LSEcrSzMwV3VwMGdaRUxUbjhtM1VwZ2k4dkVOS3lTRHQ4T0htTllPClRNK3ZZSFJtWGVDQmRuU29xaDNIYThTN0hqRVBmTDlPSUJPR2g1N0lmTzhlQ042L1R1aUhGbUZSMUxZWkFBZTQKUFNNY1FNdEZGQVZMYk8xckxQRGlYQWk1OHlHTTFOYkJ3NExLcU5MbkFWR0FHSlZWWDlKdmxNcTNmTkpySjBTcwp4MHBlMHI5b29SR01SaXAxWTZyRHltSEN3UHJqQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSSzIwbU0wcVYwOG5XeUh1T1Fpa3IwS2xKYXl6QVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQy9VTjVDd1djMgpMUmFHSm9DSm9aK2F6enluY1lyaDJIcjNYSnpkR3FuNi9mQldTanNSK2dtOGlTZzJpMEVMTGpWR3FTTzlBOGtXCnFXMjBjMXUwWkd1Z0dJMDZTRXBteStnU2hjcVJxZWJZanIrTHloc0FqSnVFMjUxWWoxQ3JXRUUvSFNmdHlJU3EKZUNHdTJYY2dQdHhTQVFvdU0xcUJGcGxnMVZtM0YrQmp2QXBzcm1tdERwalgvbHBRWlhzOU9qUFlVb25JL3RHRApESmFVT2RPVjdBOWY0Q2toS0t1L3JSK203dGhZYVdrOE9OOUxaZ09pNzk4eENMdm9idEF4WTg4U1lSczM0QXY3CmlUdnFMWW1hZnk2WGZQTHZab05DaVJCalREekxkQVN1ZllXUnBlL0t5UTIrVTNLUlNvQXVEYnlMSWY4SUpHODIKZDRtOGhLYXgxZjB1Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
}

provider "kubernetes" {
  host                   = local.host
  cluster_ca_certificate = base64decode(local.cert)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", "app"]
  }
}

resource "kubernetes_namespace_v1" "app" {
  metadata {
    name = "app"
  }
}

resource "kubernetes_namespace_v1" "test" {
  metadata {
    name = "test"
  }
}

