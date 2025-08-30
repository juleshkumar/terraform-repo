terraform {
  backend "s3" {
    bucket     = "terrafrom-backend-bucket-gyanbharatam"
    key        = "UAT/backend/s3"
    region     = "ap-south-1" 
    #use_lockfile = true  #S3 native locking
    
  #  assume_role = {
  #  role_arn = ""
  #  session_name = "terraform-session"
  #}
  }
}