class haproxy {

    package { "haproxy": 
        ensure => installed 
    }

    file { '/etc/haproxy/haproxy.cfg':
        source  => 'puppet:///files/haproxy/haproxy.cfg',
        owner   => 'root',
        group   => 'root',
        mode    => '640',
        notify  => Service['haproxy'], # haproxy will restart whenever you edit this file.
        require => Package['haproxy'],
        }

    service { "haproxy":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
    }
}
