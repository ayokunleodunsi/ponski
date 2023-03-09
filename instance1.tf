resource "aws_key_pair" "newkeypair1" {
  key_name   = "newkeypair1"
  public_key = file("/home/ayoadmin/assignmtlast/keypair.pub")
}
resource "aws_instance" "web" {
  ami           = "ami-006dcf34c09e50022"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.kman.id
  key_name = aws_key_pair.newkeypair1.key_name
  associate_public_ip_address = true

  tags = {
    Name = "HelloWorld"
  }
}