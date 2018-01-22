# do_agent::package
#
# A description of what this class does
#
# @summary installs the package
#
# @example
#   include do_agent::package
class do_agent::package {

  package {'do-agent':
    ensure => present,
  }

}
