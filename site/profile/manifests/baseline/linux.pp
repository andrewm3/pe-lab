# Baseline configuration for Linux operating systems.
#
class profile::baseline::linux (
  Boolean         $enable_firewall   = true,
  Hash            $firewall_rules    = {},
  Hash            $firewall_defaults = {},
  String          $default_locale    = 'en_AU.UTF-8',
  Array           $locales           = ['en_AU.UTF-8 UTF-8'],
  Optional[Array] $ntp_servers       = undef,
  String          $timezone          = 'Australia/Sydney',
) {

  if $enable_firewall {
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

      #include ::selinux
    }

    default: {}
  }
}
