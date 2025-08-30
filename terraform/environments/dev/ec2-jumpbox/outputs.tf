output "public_ip" {
  description = "Public IP of instance (or EIP)"
  value       = module.jumpbox.public_ip
}

output "private_ip" {
  description = "Private IP of instance"
  value       = module.jumpbox.private_ip
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.jumpbox.private_dns
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = module.jumpbox.public_dns
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = module.jumpbox.id
}

output "arn" {
  description = "ARN of the instance"
  value       = module.jumpbox.arn
}

