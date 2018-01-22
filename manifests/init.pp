# do_agent
#
# Installs the DigitalOcean Agent
#
# @summary Sets up the DigitalOcean Repo and installs the package
#
# @example
#   include do_agent
class do_agent {

  if $facts['dmi']['manufacturer'] == "DigitalOcean" {
    case $::operatingsystem {
      'RedHat', 'Fedora', 'CentOS': {
        include do_agent::repo::yum
      }
      'ubuntu', 'debian': {
        include do_agent::repo::apt
      }
      default: {
        notify {'DigitalOcean Agent is unsupported on your platform.':}
      }
    }
  include do_agent::package
  
  } else {
    notify {'The DigitalOcean Agent is only supported on DigitalOcean.':}
  }
  


}
