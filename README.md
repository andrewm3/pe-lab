pe-lab
======

A Puppet Enterprise lab environment.

Manual steps:
* Navigate to Gitlab instance and complete installation steps
* Create `control-repo` repo in Gitea instance
* Generate SSH keypair for Gitlab/Jenkins integration:
    * Add public key as a deploy key in 'control-repo'
    * Add private key as a Jenkins credential with ID 'puppet-control-repo'
