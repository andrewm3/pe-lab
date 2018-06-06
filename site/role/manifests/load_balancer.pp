# Manages a load balancer.
#
class role::load_balancer {
  include profile::baseline
  include profile::load_balancer
}
