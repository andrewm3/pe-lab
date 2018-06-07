# pe-lab

A Puppet Enterprise lab environment.

## Setup

### Terraform

* Change to the `terraform` directory
* Add values for variables in `variables.tf` to `terraform.tfvars`
* Source your OpenStack RC file
* Run
```
terraform init
terraform apply
```

### Gitlab

* Navigate to the [Gitlab instance](https://gitlab.openstack.vm/root/control-repo/settings/integrations)
* Enter a password for the root user and login
* Create a 'puppet' group. It will need to be public (TODO: fix this)
* Create `control-repo` project. You can import the project directly from [Github](https://github.com/andrewm3/pe-lab.git).
* In the Admin Area, under [Settings](https://gitlab.openstack.vm/admin/application_settings), find the
  Outbound Requests section and ensure 'Allow requests to the local network and services' is ticked and save.
* In the [Integrations](https://gitlab.openstack.vm/root/control-repo/settings/integrations) settings,
  add a webhook to trigger the Jenkins job:
  * URL: `http://jenkins.openstack.vm/generic-webhook-trigger/invoke?repo=control-repo`
  * On push events
  * SSL verification disabled
* Generate SSH keypair for Gitlab/Jenkins integration:
  * Add public key as a deploy key in 'control-repo'
  * It will need write access if you want Jenkins to merge to production

### Jenkins

* Add private key generated above as a Jenkins credential with ID 'puppet-control-repo'
* Add a PE access token able to deploy environments as a Jenkins credential with ID 'pe-access-token'.
  It should be type 'secret text'.

## Using the environment.

The Jenkins jobs will trigger from the 'staging' branch. You can add nodes you want
into the 'Staging environment' in the PE Console, and push your changes to the 'staging'
branch on the Gitlab instance. You will need to add the Gitlab instance as a remote, e.g.

```
git checkout -b staging
git remote add gitlab https://gitlab.openstack.vm/puppet/control-repo.git
git push -u gitlab staging
```
