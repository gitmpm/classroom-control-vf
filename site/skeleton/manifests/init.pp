# skeleton/manifests/init.pp
class skeleton {
file { '/etc/skel':
  ensure => 'directory',
  group  => '0',
  mode   => '0755',
  owner  => '0',
  }

  file { '/etc/skel/.bashrc':
  ensure  => 'file',
  group   => '0',
  mode    => '0644',
  owner   => '0',
  source  => 'puppet:///modules/skeleton/bashrc',
}

}
