output "primary_master_ip" {
  value = "${module.puppet-master-primary.public_ip}"
}

output "gitea_ip" {
  value = "${module.gitea.public_ip}"
}

output "jenkins_ip" {
  value = "${module.jenkins.public_ip}"
}
