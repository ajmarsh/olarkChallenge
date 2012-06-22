class postgres {

    package { "postgres": 
        ensure => installed 
    }

    service { "postgres":
        ensure => running,
    }

    file { "postgres.conf":
	path =>
	mode =>
	owner
	group
	ensure
	source => puppet:///modules/postgres/postgres.conf
	notify => Service["postgres"]
    }
}
