pe-lab
======

A Puppet Enterprise lab environment.

Manual steps:

* Navigate to Gitlab instance and complete installation steps
* Create `control-repo` repo in Gitea instance
* In the [Integrations](https://gitlab.openstack.vm/root/control-repo/settings/integrations) settings,
  add a webhook to trigger the Jenkins job:
  * URL: `http://jenkins.openstack.vm/generic-webhook-trigger/invoke?repo=control-repo`
  * On push events
  * SSL verification disabled
* Generate SSH keypair for Gitlab/Jenkins integration:
  * Add public key as a deploy key in 'control-repo'
  * Add private key as a Jenkins credential with ID 'puppet-control-repo'
