#details for first vpc
cidr = "10.0.0.0/20"
pri-snet = {
  ps1 = {
    cidr_block        = "10.0.8.0/22"
    availability_zone = "ap-southeast-1a"
  }
  ps2 = {
    cidr_block        = "10.0.12.0/22"
    availability_zone = "ap-southeast-1b"
  }
}
pub-cidr   = "10.0.0.0/21"
pub-region = "ap-southeast-1a"

