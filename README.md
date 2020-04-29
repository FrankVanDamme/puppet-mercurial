# Mercurial

Mercurial is a version control system. Since years now overshadowed by Git, you can think of Mercurial as a distributed version control tool for human beings, as opposed to the much more complex and hard to work with ways of Git.

# Usage

``` Puppet
include mercurial
```

Which will just install the package.

## main class parameters

* `package_ensure`: package presence (absent, present, latest); see Puppetlabs' package type documentation.
* `provider`: package provider

The following affect /etc/mercurial/hgrc, the system wide config file, which influences the behaviour of the Mercurial command insofar the user does not override the settings in his own .hgrc. They are named the same as the entries therein.  For reference, see `man 5 hgrc` for details.

### hgrc configuration

More main class parameters:

* `auth_groups`: An array of hashes used to set up authentication (think twice before you set this system wide): each element should contain these keys:
    * `group`, which is an arbitrary, but descriptive name
    * `prefix`, `username`, `password`, `schemes`: These correspond to the same keys in the `auth` section of `hgrc`.
* `trusted_groups`: useful if you're updating a repository owned by a group that is not your primary group. Hg will trust the group owning the repository if it is listed here. 
* `http_proxy`: proxy to use when pulling over http.
* `no_http_proxy`: urls you want to bypass your proxy for. 

## Class

# Compatibility

Tested on Debian, Ubuntu, and CentOS/RedHat type operating systems. At some point, used on OpenIndiana.

# References

* Mercurial: https://www.mercurial-scm.org/
* You might also want to complement this module with the [vcsrepo](https://forge.puppet.com/puppetlabs/vcsrepo) module by Puppetlabs.
