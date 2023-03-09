resource "aws_instance" "web" {
  ami           = "ami-006dcf34c09e50022"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.kman.id

  tags = {
    Name = "HelloWorld"
  }
}