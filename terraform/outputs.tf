output "primary_master_ip" {
  value = "${module.puppet-master-primary.public_ip}"
}
