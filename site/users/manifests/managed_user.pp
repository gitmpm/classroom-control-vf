define users::managed_user {
  user { $title:
    ensure     => present,
    managehome => true,
    gid =>  $title,
  }
  
  group { "$title":
    ensure => present,
  }
  
  file { "/home/$title/.ssh":
    ensure    => 'directory',
    mode      => '0700',
    owner     => $title,
  }
  
    file { "/home/$title/.bashrc":
    ensure => file,
    mode  => '0644',
    owner  => $title,
    source => 'puppet:///modules/users/bashrc'
  }
}
