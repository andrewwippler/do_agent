# do_agent::repo::apt
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include do_agent::repo::apt
class do_agent::repo::apt {

if ($facts['os']['release']['major'] < '7') and ($::operatingsystem != 'Ubuntu') {
  $ver = $facts['os']['release']['major']
    fail("Your version (${ver}) of ${::operatingsystem} is too old for do_agent")
  }

  if ($facts['os']['release']['full'] < '13.11') and ($::operatingsystem == 'Ubuntu') {
    $ver = $facts['os']['release']['full']
    fail("Your version (${ver}) of ${::operatingsystem} is too old for do_agent")
  }

  apt::source { 'digitalocean-agent':
    location => 'https://repos.sonar.digitalocean.com/apt',
    release  => 'main',
    repos    => 'main',
    key      => {
      'id'     => '9FE3B226BD775196D8C2E599DE88104AA4C6383F',
      'source' => 'https://repos.sonar.digitalocean.com/sonar-agent.asc',
    },
    include  => {
      'src' => false,
      'deb' => true,
    },
    before   => Package['do-agent'],
  }
}
