# Class: mercurial::params
#
#   The Mercurial configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# class{'mercurial':
#   username    => "My Name <myself@me>",
#   auth_groups => [{
#     group     => 'default',
#     prefix    => 'URL',
#     username  => 'USERNAME',
#     password  => 'PASSWORD',
#     schemes   => 'http'
#   }]
# }
#
#
class mercurial(
  $username,
  $auth_groups = $mercurial::params::auth_groups,
  $trusted_groups = $mercurial::params::trusted_groups,
  $provider       = $mercurial::params::provider,
  $package_ensure = 'present'
) inherits mercurial::params {

  package { 'hg' :
    name     => $package_name,
    ensure   => $package_ensure,
    provider => $provider,
  }

  file { "hgdir":
    ensure  => directory,
    path    => "${$conf_dir}",
  }

  file { 'hgrc':
    ensure  => $package_ensure,
    path    => "${$conf_dir}/${$conf_file}",
    content => template('mercurial/hgrc.erb'),
    require => [ Package['hg'], File["hgdir"] ],
  }
}
