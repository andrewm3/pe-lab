# profile::base::linux
#
# A base profile for Linux nodes.
#
class profile::base::linux (
  Boolean $enable_firewall   = true,
  Hash    $firewall_rules    = {},
  Hash    $firewall_defaults = {},
) {

  if $enable_firewall {
    include ::firewall
    include profile::fw::pre
    include profile::fw::post

    $firewall_rules.each |$rule_name, $rule_attributes| {
      firewall {
        $rule_name:
          *       => $rule_attributes,
        ;
        default:
          * => $firewall_defaults,
        ;
      }
    }
  } else {
    class { '::firewall':
      ensure => stopped,
    }
  }
}
