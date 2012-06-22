class siege {

    package { "siege": 
        ensure => installed 
    }

    service { "siege":
        ensure => running,
    }
}
