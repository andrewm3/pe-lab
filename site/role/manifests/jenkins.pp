# role::jenkins
#
# A single-node Jenkins installation.
#
class role::jenkins {
  require profile::base
  include profile::jenkins
}
