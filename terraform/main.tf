locals {
  primary_master_ip = "${module.puppet-master-primary.private_ip}"
}

module "puppet-master-primary" {
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
