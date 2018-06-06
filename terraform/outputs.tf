output "puppet_master_ip" {
  value = "${module.puppet-master.public_ip}"
}

output "gitlab_ip" {
  value = "${module.gitlab.public_ip}"
}
