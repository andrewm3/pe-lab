# profile::base
#
# The base profile included in all roles. Split into subclass by kernel.
#
class profile::base {

  case $facts['kernel'] {
    'Linux':   { contain profile::base::linux }
    'Windows': { contain profile::base::windows }
    default:   { fail("The kernel ${facts['kernel']} seems to be unsupported.") }
  }

  contain profile::dns
}
