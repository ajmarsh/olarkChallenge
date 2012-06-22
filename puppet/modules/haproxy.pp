class haproxy {

    package { "haproxy": 
        ensure => installed 
    }

    service { "haproxy":
        ensure => running,
    }
}
