
output "security_group_id" {
  value = aws_security_group.jenkins-sg.id
}

output "jenkins_vpc_id" {
  value = aws_vpc.jenkins-vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet_1_jen.id
}

output "aws_main_route_table_association_id" {
  value = aws_main_route_table_association.set-master-default-rt-assoc_jen.id
}
