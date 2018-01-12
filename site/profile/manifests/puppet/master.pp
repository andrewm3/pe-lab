# profile::puppet::master
#
# Provides configuration for Puppet masters - both MoMs and compile masters.
#
# @example
#   include profile::puppet::master
#
class profile::puppet::master (
  Array[String] $pe_repo_platforms = [],
) {

  $pe_repo_platforms.each |$pe_repo_platform| {
    include "pe_repo::platform::${pe_repo_platform}"
  }
}
