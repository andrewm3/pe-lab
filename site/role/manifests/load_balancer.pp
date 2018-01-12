# role::load_balancer
#
# Manages a load balancer.
#
class role::load_balancer {
  require profile::base
  include profile::load_balancer
}
