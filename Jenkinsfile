node {
  // Set the Jenkins credentials that hold our Puppet Enterprise RBAC token
  puppet.credentials 'pe-access-token'

  stage 'Deploy to production'
  puppet.codeDeploy 'production'
  puppet.job 'production'
}
