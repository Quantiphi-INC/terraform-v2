locals {
  glue_src_path = "../src/glue/test_glue_job/"
}

variable "s3_bucket" {
  type = string
}

variable "region" {
  type = string
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}