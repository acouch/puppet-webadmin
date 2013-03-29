# Dev class for webadmin submodule
class webadmin::dev($webadminuser = $webadmin::webadminuser, $webadmingroup = $webadmin::webadmingroup) {

  file { "/home/$webadminuser/.bashrc":
    ensure => present,
    owner => $webadminuser,
    group => $webadmingroup,
    mode => 644,
    source => "puppet:///modules/webadmin/.bashrc",
  }

  file { '/usr/local/bin/network-restart':
    source => "puppet:///modules/webadmin/networkrestart",
    owner => 'root',
    group => 'root',
    mode => 755,
  }

  file { '/usr/local/bin/coder':
    source => "puppet:///modules/webadmin/coder",
    owner => 'root',
    group => 'root',
    mode => 755,
  }
}
