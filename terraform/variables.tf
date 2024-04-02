locals {
  glue_src_path = "../src/glue/test_glue_job/"
}

locals {
  glue_src_path_2 = "../src/glue/new_test_glue_job/"
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
variable "glue_job_name" {
  type = string
}
variable "glue_job_test_script_loc" {
  type = string
}
variable "glue_job_name_1" {
  type = string
}
variable "glue_job_test_script_loc_1" {
  type = string
}
