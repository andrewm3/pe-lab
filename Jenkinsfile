def merge(from, to) {
  sh('git checkout ' + to)
  sh('git merge ' + from + ' --ff-only')
}

def promote(Map parameters = [:]) {
  String from = parameters.from
  String to = parameters.to

  merge(from, to)

  sshagent(['puppet-control-repo']) {
    sh "git push origin " + to
  }
}

node {
  git branch: 'staging', credentialsId: 'puppet-control-repo', url: 'git@gitlab.openstack.vm:root/control-repo.git'

  stage('Lint and unit tests') {
    withEnv(['PATH+LOCAL=/usr/local/bin']) {
      sh '''#!/bin/bash -l
      source /usr/local/rvm/scripts/rvm
      rvm use 2.4
      bundle install --path vendor/bundle
      bundle exec rake syntax
      bundle exec rake lint
      bundle exec onceover run spec
      '''
    }
  }

  // Set the Jenkins credentials that hold our Puppet Enterprise RBAC token
  puppet.credentials 'pe-access-token'

  stage('Deploy to staging') {
    puppet.codeDeploy 'staging'
    puppet.job 'staging'
  }

  stage('Promote to production') {
    promote from: 'staging', to: 'production'
    puppet.codeDeploy 'production'
  }

  stage('Noop production run') {
    puppet.job 'production', noop: true
  }

  stage('Deploy to production') {
    puppet.job 'production'
  }
}
