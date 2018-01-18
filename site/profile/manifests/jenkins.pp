# profile::jenkins
#
# Manage a single-node Jenkins installation.
#
# @example
#   include profile::jenkins
#
class profile::jenkins (
  Boolean              $enable_firewall = true,
  Hash[String, String] $plugin_versions = {},
  Hash[String, String] $job_files       = {},
) {

  include ::git

  class { '::jenkins': }

  # Install specified Jenkins plugins
  $plugin_versions.each |$plugin_name, $plugin_version| {
    jenkins::plugin { $plugin_name:
      version => $plugin_version,
    }
  }

  # Configure Jenkins Pipeline jobs from files
  $job_files.each |$job_name, $job_file| {
    jenkins::job { $job_name:
      config => file($job_file),
    }
  }

  if $enable_firewall {
    firewall {'100 Jenkins 8080':
      dport  => '8080',
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
