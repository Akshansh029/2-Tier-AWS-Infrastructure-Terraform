# DB subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.sg-name
  subnet_ids = [data.aws_subnet.private-subnet1.id, data.aws_subnet.private-subnet2.id]
}

# Database tier RDS Cluster
resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.39mysql_aurora.3.08.0" # Aurora MySQL 3.08.0 (compatible with MySQL 8.0.39)
  database_name           = var.db-name
  master_username         = var.rds-username
  master_password         = var.rds-password
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
  port = 3306
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [data.aws_security_group.db-sg.id]
  
  tags = {
    Name = var.rds-cluster-name
  }
}

# RDS Cluster Instance
resource "aws_rds_cluster_instance" "primary_instance" {
  identifier         = "primary-instance"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

# Read Replica Instance
resource "aws_rds_cluster_instance" "read_replica_instance" {
      count = 1
  identifier         = "read-replica-instance"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version

  depends_on = [ aws_rds_cluster_instance.primary_instance ]
}
