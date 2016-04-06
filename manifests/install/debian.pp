# == Class: tomcat::install::debian
#
# Some hacks needed on debian
#
class tomcat::install::debian {
  if $::lsbdistcodename == 'precise' {
    ::apt::ppa { 'ppa:dirk-computer42/c42-backport': } ->
    ::apt::pin { [
      'dirk-computer42-c42-backport-default',
      'dirk-computer42-c42-backport-tomcat',
    ]:
      ensure => absent,
    } ->
    ::apt::pin { '00-dirk-computer42-c42-backport-tomcat':
      originator => "LP-PPA-dirk-computer42-c42-backport",
      packages   => [
        "libservlet3.0-java-doc",
        "libservlet3.0-java",
        "libtomcat${tomcat::major_version}-java",
        "tomcat${tomcat::major_version}",
        "tomcat${tomcat::major_version}-admin",
        "tomcat${tomcat::major_version}-common",
        "tomcat${tomcat::major_version}-docs",
        "tomcat${tomcat::major_version}-examples",
        "tomcat${tomcat::major_version}-user",
      ],
      priority   => 600,
    } ->
    ::apt::pin { '01-dirk-computer42-c42-backport-default':
      originator => "LP-PPA-dirk-computer42-c42-backport",
      packages   => "*",
      priority   => 90,
    } ->
    Class['::apt::update'] ->
    Package["tomcat${tomcat::major_version}"]
  }
}
