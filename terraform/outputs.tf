output "puppet_master_ip" {
  value = "${module.puppet-master.public_ip}"
}

output "gitlab_ip" {
  value = "${module.gitlab.public_ip}"
}

output "jenkins_ip" {
  value = "${module.jenkins.public_ip}"
}

output "nagios_ip" {
  value = "${module.nagios.public_ip}"
}
