class nginx {

    package { "nginx": 
        ensure => installed 
    }

    file { '/etc/nginx/sites-available/default':
            source  => 'puppet:///files/ngingx/default',
            owner   => 'root',
            group   => 'root',
            mode    => '640',
            notify  => Service['nginx'], # nginx will restart whenever you edit this file.
            require => Package['nginx'],
                                                        }

    service { "nginx":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
    }
}

notify {"nginx service":}
