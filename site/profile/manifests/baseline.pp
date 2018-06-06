# Provide baseline configuration for all nodes.
#
class profile::baseline {

  # Common
  contain profile::baseline::dns

  # Operating system specific
  case $facts['kernel'] {
    'Linux':   { contain profile::baseline::linux }
    'Windows': { contain profile::baseline::windows }
    default:   { fail("The kernel ${facts['kernel']} seems to be unsupported.") }
  }
}
