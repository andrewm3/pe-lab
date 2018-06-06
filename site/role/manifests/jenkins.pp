# A single-node Jenkins installation.
#
class role::jenkins {
  include profile::baseline
  include profile::nginx
  include profile::jenkins
}
