pe-lab
======

A Puppet Enterprise lab environment.

Manual steps:
* Navigate to Gitea instance and complete installation steps
* Create `pe-lab` repo in Gitea instance
* Generate SSH keypair for Gitea/Jenkins integration:
    * Add public key to Gitea user to push to `pe-lab`
    * Add private key as a Jenkins credential with ID 'puppet-control-repo'
