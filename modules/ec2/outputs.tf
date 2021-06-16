
output "Jenkins-Node-Public-IP" {
  value = aws_instance.jenkins.public_ip
}

output "Jenkins-Node-Public-DNS" {
  value = aws_instance.jenkins.public_dns
}
