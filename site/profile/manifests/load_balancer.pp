# profile::load_balancer
#
# Configures a HAProxy load balancer.
#
class profile::load_balancer (
  Optional[Hash] $listeners       = undef,
  Boolean        $enable_firewall = true,
) {

  include ::haproxy

  # Set SELinux to permissive mode on RedHat nodes as it stops HAProxy from running.
  if $facts['os']['family'] == 'RedHat' {
    class { '::selinux':
      mode => 'permissive',
    }
  }

  if $listeners {
    $listeners.each |String $listener, Hash $listener_values| {
      haproxy::listen { $listener:
        collect_exported => $listener_values['collect_exported'],
        ipaddress        => $facts['ipaddress'],
        ports            => $listener_values['ports'],
        options          => $listener_values['options'],
      }

      if $enable_firewall {
        firewall { "100 ${listener}":
          dport  => [$listener_values['ports']],
          proto  => 'tcp',
          action => 'accept',
        }
      }
    }
  }
}
