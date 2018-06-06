locals {
  puppet_master_ip       = "${module.puppet-master.private_ip}"
  puppet_master_hostname = "puppet-master"
}

module "puppet-master" {
  source = "github.com/andrewm3/terraform-openstack-puppet-enterprise"

  name = "puppet-master-primary"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  network_uuid = "${openstack_networking_network_v2.terraform.id}"
  flavor = "m1.medium"
  pool = "${var.pool}"
  pp_role = "puppet::master_of_masters"
  node_type = "puppet-master"
  pe_source_url = "${var.pe_source_url}"
  pe_conf = <<EOF
{
  "console_admin_password": "puppetlabs"
  "puppet_enterprise::puppet_master_host": "%{::trusted.certname}"
  "pe_install::puppet_master_dnsaltnames": ["puppet-master.openstack.vm"]

  "puppet_enterprise::profile::master::check_for_updates": false
  "puppet_enterprise::send_analytics_data": false

  "puppet_enterprise::profile::master::code_manager_auto_configure": true
  "puppet_enterprise::profile::master::r10k_remote": "https://github.com/andrewm3/pe-lab.git"
}
EOF
  custom_provisioner = [
    "echo puppetlabs | sudo /opt/puppetlabs/bin/puppet-access login --lifetime=0 --username admin",
    "sudo /opt/puppetlabs/bin/puppet-code deploy --all --wait",
  ]
}

module "gitlab" {
  source = "github.com/andrewm3/terraform-openstack-puppet-enterprise"

  name = "gitlab"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  network_uuid = "${openstack_networking_network_v2.terraform.id}"
  image = "ubuntu_16.04_x86_64"
  flavor = "m1.medium"
  ssh_user_name = "ubuntu"
  pool = "${var.pool}"
  pp_role = "gitlab"
  node_type = "posix-agent"
  master_ip = "${local.puppet_master_ip}"
  master_hostname = "${local.puppet_master_hostname}"
}
