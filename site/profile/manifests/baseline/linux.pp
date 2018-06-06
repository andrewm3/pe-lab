# Baseline configuration for Linux operating systems.
#
class profile::baseline::linux (
  Boolean         $firewall_enabled  = true,
  Hash            $firewall_rules    = {},
  Hash            $firewall_defaults = {},
  String          $default_locale    = 'en_AU.UTF-8',
  Array           $locales           = ['en_AU.UTF-8 UTF-8'],
  Optional[Array] $ntp_servers       = undef,
  String          $timezone          = 'Australia/Sydney',
  String          $selinux_mode      = 'enforcing',
  String          $selinux_type      = 'targeted',
) {

  if $firewall_enabled {
    include ::firewall
    include profile::baseline::linux::firewall::pre
    include profile::baseline::linux::firewall::post

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

  class { '::ntp':
    servers => $ntp_servers,
  }

  class { '::locales':
    default_locale => $default_locale,
    locales        => $locales,
  }

  class { '::timezone':
    timezone => $timezone,
  }

  case $facts['os']['family'] {
    'RedHat': {
      shellvar { 'HOSTNAME':
        ensure => present,
        target => '/etc/sysconfig/network',
        value  => $trusted['certname'],
      }

      class { '::selinux':
        mode => $selinux_mode,
        type => $selinux_type,
      }
    }

    default: {}
  }
}
