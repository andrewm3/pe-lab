# A Gitlab server.
#
class role::gitlab {
  include profile::baseline
  include profile::gitlab
}
