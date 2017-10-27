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
  $auth_groups = $mercurial::params::auth_groups,
  $trusted_groups = $mercurial::params::trusted_groups,
  $provider       = $mercurial::params::provider,
  $package_ensure = 'present'
) inherits mercurial::params {

  $trusted_groups_ = hiera_array("mercurial::trusted_groups", $trusted_groups)
  $auth_groups_ = hiera_array("mercurial::auth_groups", $auth_groups)

  package { 'mercurial' :
    name     => $package_name,
    ensure   => $package_ensure,
    provider => $provider,
  }

  if ( $::operatingsystem == "OpenIndiana" ){
      package { 'python27':
	  provider => $provider,
	  ensure   => present,
      }
  }

  file { "hgdir":
    ensure  => directory,
    path    => "${$conf_dir}",
  }

  file { 'hgrc':
    ensure  => $package_ensure,
    path    => "${$conf_dir}/${$conf_file}",
    content => template('mercurial/hgrc.erb'),
    require => [ Package["mercurial"], File["hgdir"] ],
  }
}
