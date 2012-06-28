# site.pp
import "nodes"

filebucket { main: server => "puppet" }

# defaults
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

