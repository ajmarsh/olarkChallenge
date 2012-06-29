node webserver1 {
    include ntp
    include nginx
}

node webserver2 {
    include ntp
    include nginx
}

node haproxyserver1 {
    include ntp
    include haproxy
}

node siegeserver1 {
    include ntp
    include siege
}

node siegeserver2 {
    include ntp
    include siege
}

