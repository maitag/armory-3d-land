#!/bin/bash

haxe serverNeko.hxml

test -d "bin" || mkdir -p "bin"

cp build/neko/multiplayerServer.n bin/multiplayerServer.n

echo '#!/bin/bash\nneko multiplayerServer.n "$@"' >bin/multiplayerServer
chmod +x bin/multiplayerServer

