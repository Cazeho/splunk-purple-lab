
provider "aws" {
  region = var.aws.region
  profile = "${var.AWS_PROFILE}"
}
