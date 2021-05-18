provider "aws" {
 
 region = "us-east-2"
}


provider "kubernetes" {
  load_config_file = "true"
}