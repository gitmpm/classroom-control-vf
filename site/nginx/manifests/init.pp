# nginx/manifests/init.pp
class nginx {

  $www = '/var/www'
  $conf_dir = '/etc/nginx/conf.d'
  $nginx_dir = '/etc/nginx'
  $nginx_files = 'puppet:///modules/nginx'
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  
  package { 'nginx':
    ensure => present,
  }
  
  file { "${www}": 
    ensure => directory,
  }
  
  file { "${www}/index.html":
    ensure => file,
    source => "${nginx_files}/index.html",
  }
  
  file { "${conf_dir}/default.conf":
    ensure  => file,
    source  => "${nginx_files}/default.conf",
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  file { "${nginx_dir}/nginx.conf":
    ensure  => file,
    source  => "${nginx_files}/nginx.conf",
    require => Package['nginx'],
    notify  => Service['nginx'],
}
    
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
