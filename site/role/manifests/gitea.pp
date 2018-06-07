# A Gitea server.
#
class role::gitea {
  include profile::baseline
  include profile::webserver::nginx
  include profile::gitea
}
