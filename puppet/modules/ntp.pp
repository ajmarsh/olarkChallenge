class ntp {

    package { "ntp":
        ensure => installed
    }

    file { '/etc/ntp.conf':
        source  => 'puppet:///files/ntp.conf',
        owner   => 'root',
        group   => 'root',
        mode    => '640',
        notify  => Service['ntp'], # ntpd will restart whenever you edit this file.
        require => Package['ntp'],
    }

    service { "ntp":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
    }
}

notify {"ntp service":}
