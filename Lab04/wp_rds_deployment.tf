# Creating DB instance

resource "aws_db_instance" "mydb" {
  depends_on        = [aws_security_group.rdssg, aws_db_subnet_group.dbsubnet]
  allocated_storage = 20
  storage_type      = "gp2"

  # Using MYSQL engine for DB
  engine = "mysql"
  engine_version         = "5.7.30"

  # Defining the Security Group Created
  vpc_security_group_ids = [aws_security_group.rdssg.id]

  instance_class         = "db.t2.micro"

  # DB security group name to specify the VPC
  db_subnet_group_name  =  aws_db_subnet_group.dbsubnet.name

  # Giving Credentials
  name                 = "mywpdb"
  username             = "mohit"
  password             = "passmohit"
  parameter_group_name = "default.mysql5.7"

  # Making the RDS/ DB publicly accessible so that end point can be used
  publicly_accessible = true
  # Setting this true so that there will be no problem while destroying the Infrastructure as it won't create snapshot
  skip_final_snapshot = true


  tags = {
    Name = "mywpdb"
  }
}
