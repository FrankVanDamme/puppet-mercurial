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
class mercurial::params {

  $auth_groups    = []
  $trusted_groups = []
  $http_proxy = ''
  $no_http_proxy = ''

  $provider = $::osfamily ? {
    'Solaris' => "pkgutil",
    'Debian'  => "apt",
    'RedHat'  => "yum",
  }

  case $::osfamily {
    'Debian': {
      $package_name   = 'mercurial'
      $conf_dir       = '/etc/mercurial'
      $conf_file      = 'hgrc'
    }

    default: {
      case $::operatingsystem {
	'Debian', 'RedHat', 'CentOS': {
	  $package_name   = 'mercurial'
	  $conf_dir       = '/etc/mercurial'
	  $conf_file      = 'hgrc'
	}

	'OpenIndiana': {
	  $package_name   = 'mercurial'
	  $conf_dir       = '/etc/mercurial'
	  $conf_file      = 'hgrc'
	}

        default: {
	  fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only supports osfamily Debian or Red Hat")
	}
      }
    }
  }
}
