# A single-node Jenkins installation.
#
class role::jenkins {
  include profile::baseline
  include profile::webserver::nginx
  include profile::jenkins
}
