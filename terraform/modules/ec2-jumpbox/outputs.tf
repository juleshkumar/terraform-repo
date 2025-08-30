output "public_ip" {
  description = "Public IP of instance (or EIP)"
  value       = concat(aws_eip.master.*.public_ip, aws_instance.master.*.public_ip, [""])[0]
}

output "private_ip" {
  description = "Private IP of instance"
  value       = join("", aws_instance.master.*.private_ip)
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = join("", aws_instance.master.*.private_dns)
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = aws_instance.master.*.public_dns
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = join("", aws_instance.master.*.id)
}

output "arn" {
  description = "ARN of the instance"
  value       = join("", aws_instance.master.*.arn)
}

