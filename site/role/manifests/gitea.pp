# A Gitea server.
#
class role::gitea {
  include profile::baseline
  include profile::nginx
  include profile::gitea
}
