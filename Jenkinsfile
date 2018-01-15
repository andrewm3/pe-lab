node {
  // Set the Jenkins credentials that hold our Puppet Enterprise RBAC token
  puppet.credentials 'pe-access-token'

  stage 'Noop production run'
  puppet.job 'production', noop: true

  stage 'Deploy to production'
  input "Ready to deploy to production?"
  puppet.codeDeploy 'production'
  puppet.job 'production', concurrency: 40
}
