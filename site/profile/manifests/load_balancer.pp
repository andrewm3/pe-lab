# profile::load_balancer
#
# Configures a HAProxy load balancer.
#
class profile::load_balancer (
  Optional[Hash] $listeners        = undef,
  Boolean        $firewall_enabled = true,
) {

  include ::haproxy

  # Allow HAProxy to work with SELinux enabled
  if $facts['os']['family'] == 'RedHat' {
    selinux::boolean { 'haproxy_connect_any': }
  }

  if $listeners {
    $listeners.each |String $listener, Hash $listener_values| {
      haproxy::listen { $listener:
        collect_exported => $listener_values['collect_exported'],
        ipaddress        => $facts['ipaddress'],
        ports            => $listener_values['ports'],
        options          => $listener_values['options'],
      }

      if $firewall_enabled {
        firewall { "100 ${listener}":
          dport  => [$listener_values['ports']],
          proto  => 'tcp',
          action => 'accept',
        }
      }
    }
  }
}
