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

}
