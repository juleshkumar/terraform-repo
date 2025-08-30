
output "private_ip" {
  description = "Private IP of instance"
  value       = module.elasticsearch.private_ip
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.elasticsearch.private_dns
}


output "id" {
  description = "Disambiguated ID of the instance"
  value       = module.elasticsearch.id
}

output "arn" {
  description = "ARN of the instance"
  value       = module.elasticsearch.arn
}

