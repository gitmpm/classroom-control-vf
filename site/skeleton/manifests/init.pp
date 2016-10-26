# users/manifests/init.pp
class skeleton {
file { '/etc/skel/':
  ensure => 'directory',
  group  => '0',
  mode   => '0550',
  owner  => '0',
  type   => 'directory',
}

file { '/etc/skel/.bashrc':
  ensure  => 'file',
  group   => '0',
  mode    => '0644',
  owner   => '0',
  type    => 'file',
}
