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

  $provider = $facts[os][family] ? {
    'Solaris' => "pkgutil",
    'Debian'  => "apt",
    'RedHat'  => "yum",
  }

  case $facts[os][family] {
    'Debian': {
      $package_name   = 'mercurial'
      $conf_dir       = '/etc/mercurial'
      $conf_file      = 'hgrc'
    }

    default: {
      case $facts[os][name] {
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
          fail("Unsupported osfamily: ${facts[os][family]} operatingsystem: ${facts[os][name]}, module ${module_name} only supports osfamily Debian or Red Hat")
        }
      }
    }
  }
}
