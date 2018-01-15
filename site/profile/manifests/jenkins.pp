# profile::jenkins
#
# Manage a single-node Jenkins installation.
#
# @example
#   include profile::jenkins
#
class profile::jenkins (
  Hash[String, String] $plugin_versions = {},
) {

  class { '::jenkins':
    default_plugins => [],
  }

  # Install specified Jenkins plugins
  $plugin_versions.each |$plugin_name, $plugin_version| {
    jenkins::plugin { $plugin_name:
      version => $plugin_version,
    }
  }
}
