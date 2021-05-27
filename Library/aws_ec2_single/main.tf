resource "aws_instance" "state-example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
}
