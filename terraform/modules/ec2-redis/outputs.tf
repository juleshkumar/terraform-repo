

output "private_ip" {
  description = "Private IP of instance"
  value       = join("", aws_instance.master.*.private_ip)
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = join("", aws_instance.master.*.private_dns)
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = join("", aws_instance.master.*.id)
}

output "arn" {
  description = "ARN of the instance"
  value       = join("", aws_instance.master.*.arn)
}

