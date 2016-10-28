# nginx/manifests/init.pp
class nginx {

  $www = '/var/www'
  $conf_dir = '/etc/nginx/conf.d'
  $nginx_dir = '/etc/nginx'
  $nginx_files = 'puppet:///modules/nginx'
  
  case $::osfamily {
    'RedHat','Debian' {
      $docroot = '/var/www'
      $logdir = '/var/log/nginx'
      $confdir = '/etc/nginx'
      $blckdir = '/etc/nginx/conf.d'
      }
    'windows' : {
      $docroot = 'C:/ProgramData/nginx/html'
      $logdir = 'C:/ProgramData/nginx/logs'
      $confdir = 'C:/ProgramData/nginx'
      $blckdir = 'C:/ProgramData/nginx/conf.d'
      }
    }
      
    $svcuser = = $::osfamily ? {
    'RedHat' => 'nginx',
    'Debian' => 'www-data'
    'windows' => 'nobody',
    }
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
    ensure  => 'file'
  }
  
  package { 'nginx':
    ensure  => present,
    before  =>  [File["${$blckdir}/default.conf"],File["${confdir}/nginx.conf"]],
  }
  
  file { "${docroot}": 
    ensure => directory,
  }
  
  file { "${docroot}/index.html":
    source => "${nginx_files}/index.html",
  }
  
  file { "${conf_dir}/default.conf":
    content  => "${nginx_files}/default.default.epp",
  }
  
  file { "${nginx_dir}/nginx.conf":
    content  => "${nginx_files}/nginx.conf.epp",
}
    
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [File["${confdir}/default.conf"],File["${blckdir}/nginx.conf"]],
  }
}
