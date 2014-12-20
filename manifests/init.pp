# Package lists and user settings for administrative user.
class webadmin($webadminuser = "webadmin", $webadmingroup = "webadmin", $webadminpass = '$6$rBjB67FX$J9XuNhHJEuR7p6NQC0yCgPR/T2SABNC5IpQqcC1KNLbPO/peVjv.3s.5TdyPwN.60A10qMaPXzBO8rWqLibMk1') {

   group { [$webadmingroup] :
    ensure => 'present',
   }

   user { $webadminuser:
    ensure     => "present",
    managehome => true,
    groups => ['www-data'],
    gid => "$webadmingroup",
    password => $webadminpass,
    shell   => '/bin/bash',
  }

  file { "/home/$webadminuser/.ssh":
    ensure => "directory",
    owner => $webadminuser,
    group => $webadmingroup,
    mode => 644,
  }

  file { "/home/$webadminuser/.ssh/environment":
    owner => $webadminuser,
    group => $webadmingroup,
    mode => 644,
    ensure => file,
  }

  package { "git-core":
    ensure => installed,
  }

  package { 'base-package':
    name => [
        'byobu',
        'curl',
        'exuberant-ctags',
        'iptables',
        'mailutils',
        'ntp',
        'openssh-client',
        'openssh-server',
        'openssl',
        'postfix',
        'ruby-compass',
        'screen',
        'vim',
        'vim-common',
        'vim-runtime',
        'vim-tiny',
        'wget',
        'zip',
      ],
      ensure => installed,
  }

  group { ["www-data", "tomcat6"] :
    ensure => 'present',
  }

  file { "/etc/vim/vimrc":
    ensure => present,
    mode => 644,
    source => "puppet:///modules/webadmin/vimrc",
  }

  file { "/etc/bash.bashrc":
    ensure => present,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/webadmin/bash.bashrc",
  }

  file { "/etc/inputrc":
    ensure => present,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/webadmin/inputrc",
  }

  file { "/etc/gitconfig":
    ensure => present,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/webadmin/gitconfig"
  }

  # TODO: Not sure what to do with this in the new world.
  /*
  file { 'managed sudo':
    path => "/etc/sudoers",
    owner => root,
    group => root,
    mode => 440,
    source => "puppet:///modules/webadmin/sudoers",
  }
  */

  file { '/usr/share/git-core/templates/info/exclude':
    require => Package['base-package'],
    source => "puppet:///modules/webadmin/git_ignore",
    owner => root,
    group => root,
    mode => 655,
  }

  cron { "ntp time sync":
    command => "/usr/sbin/ntpdate ntp.ubuntu.com",
    user => root,
    minute => ['*/3'],
  }

  file { '/usr/local/bin/runtags':
    source => "puppet:///modules/webadmin/runtags",
    owner => 'root',
    group => 'root',
    mode => 755,
  }

  file { '/usr/local/bin/make-random-password':
    source => "puppet:///modules/webadmin/make-random-password",
    owner => 'root',
    group => 'root',
    mode => 755,
  }
}
