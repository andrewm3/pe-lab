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

  include ::jenkins

  # Install specified Jenkins plugins
  $plugin_versions.each |$plugin_name, $plugin_version| {
    jenkins::plugin { $plugin_name:
      version => $plugin_version,
    }
  }
}
