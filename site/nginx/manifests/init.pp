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
    ensure  => 'file'
  }
  
  package { 'nginx':
    ensure  => present,
    before  =>  [File["${conf_dir}/default.conf"]],[File["${nginx_dir}/nginx.conf"]],
  }
  
  file { "${www}": 
    ensure => directory,
  }
  
  file { "${www}/index.html":
    source => "${nginx_files}/index.html",
  }
  
  file { "${conf_dir}/default.conf":
    source  => "${nginx_files}/default.conf",
  }
  
  file { "${nginx_dir}/nginx.conf":
    source  => "${nginx_files}/nginx.conf",
}
    
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [File ["${conf_dir}/default.conf"],[File["${nginx_dir}/nginx.conf"]],
  }
}
