# == Class: tomcat::install
#
# install tomcat and logging stuff
#
class tomcat::install {
  if !$tomcat::sources {
    if $tomcat::version == $tomcat::major_version {
      $package_ensure = "present"
    } else {
      $package_ensure = $tomcat::version
    }

    package {"tomcat${tomcat::major_version}":
      ensure => $package_ensure,
    }

    if $::osfamily == 'Debian' {
      class {'::tomcat::install::debian': }
    } elsif $::osfamily == 'RedHat' {
      class {'::tomcat::install::redhat': }
    }
  } else {
    class {'tomcat::source': }
  }
}
