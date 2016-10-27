# nginx/manifests/init.pp
class nginx {

  $www = '/var/www'
  $conf_dir = '/etc/nginx/conf.d'
  $nginx_dir = '/etc/nginx'
  $nginx_files = 'puppet:///modules/nginx'
  
  
  package { 'nginx':
    ensure => present,
  }
  
  file { ${www}: 
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  
  file { ${www}/index.html:
    ensure => file,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => ${nginx_files}/index.html,
  }
  
  file { ${conf_dir}/default.conf:
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => ${nginx_files}/default.conf,
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  file { ${nginx_dir}/nginx.conf:
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => ${nginx_files}/nginx.conf,
    require => Package['nginx'],
    notify  => Service['nginx'],
}
    
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
