# Dev class for webadmin submodule
class webadmin::dev($webadminuser = $webadmin::webadminuser, $webadmingroup = $webadmin::webadmingroup) {

  # Add default vhost for simple development. Necessary pre-getSite.
  file { "/etc/apache2/sites-available/defhost":
    owner => $webadminuser,
    group => $webadmingroup,
    mode => 644,
    ensure => file,
    source => "puppet:///modules/webadmin/defhost",
  }

  file { "/home/$webadminuser/.bashrc":
    ensure => present,
    owner => $webadminuser,
    group => $webadmingroup,
    mode => 644,
    source => "puppet:///modules/webadmin/.bashrc",
  }

  file { '/usr/local/bin/network-restart':
    source => "puppet:///modules/webadmin/network-restart",
    owner => 'root',
    group => 'root',
    mode => 755,
  }
}
