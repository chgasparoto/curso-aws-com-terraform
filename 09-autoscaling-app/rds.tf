resource "aws_db_subnet_group" "rds" {
  name       = local.namespaced_service_name
  subnet_ids = [aws_subnet.this["pvt_a"].id, aws_subnet.this["pvt_b"].id]

  tags = {
    "Name" = local.namespaced_service_name
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  availability_zone    = "${var.aws_region}b"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.rds.id
  vpc_security_group_ids = [aws_security_group.rds.id]
}
