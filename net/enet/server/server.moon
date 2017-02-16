#!/usr/bin/env moon

init = ->
  dofile "../../init.lua"

xpcall init, os.exit

require "enet"

server = {
  running: true,
  port: arg[1] or 8081
  client: {}
  timeout: 100
}

server.udp = enet.host_create "localhost" .. ":" .. server.port

if server.udp
  print "*server started on port " .. server.port .. "*"
else
  error "*could not start server*"

while server.running
  event = server.udp\service server.timeout
  while event
    switch event.type
      when "recieve"
        print "got message: ", event.data
        -- id, msg = data\match "(%x*) (.*)"
        -- if id and msg
          -- print id .. ": " .. msg
          -- server.udp\broadcast id .. " " .. msg
          --
      when "connect"
        -- print "* " .. event.peer .. " connected *"
        print "* connected *"

      when "disconnect"
        -- print "* " .. event.peer .. " disconnected *"
        print "* disconnected *"

    event = server.udp\service!

server.udp\flush!
