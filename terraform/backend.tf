terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    profile        = "management"
    dynamodb_table = "terraform"
    bucket         = "terraform.mizzy.org"
    key            = "ecs-sample.tfstate"
    session_name   = "ecs-sample-terraform"
    encrypt        = true
  }
}
