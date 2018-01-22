# do_agent::repo::yum
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include do_agent::repo::yum
class do_agent::repo::yum {

  $ver = $facts['os']['release']['major']

  if (0+$ver < 5) {
    fail("Your version ($ver) of $::operatingsystem is too old for do_agent")
  }

  if (versioncmp('22', $ver) > 0) and ($::operatingsystem == 'Fedora') {
    fail("Your version ($ver) of $::operatingsystem is too old for do_agent")
  }

  yumrepo {'digitalocean-agent':
    ensure         => present,
    baseurl        => 'https://repos.sonar.digitalocean.com/yum/$basearch',
    failovermethod => 'priority',
    enabled        => '1',
    gpgcheck       => '1',
    gpgkey         => 'https://repos.sonar.digitalocean.com/sonar-agent.asc',
  }
}
