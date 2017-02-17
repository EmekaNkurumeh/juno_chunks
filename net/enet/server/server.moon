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

server.host = enet.host_create "localhost" .. ":" .. server.port

if server.host
  print "*server started on port " .. server.port .. "*"
else
  error "*could not start server*"

while server.running
  event = server.host\service server.timeout
  if event
    switch event.type
      when "receive"
        print "recieve: #{event.peer} says #{event.data}"
        server.host\broadcast "#{event.peer}: says #{event.data}"
        -- id, msg = data\match "(%x*) (.*)"
        -- if id and msg
          -- print id .. ": " .. msg
          -- server.host\broadcast id .. " " .. msg
          --
      when "connect"
        print "connect: #{event.peer}"
        server.host\broadcast "client #{event.peer} has connected"

      when "disconnect"
        print "disconnect: #{event.peer}"
        server.host\broadcast "client #{event.peer} has disconnected"

      else
        print "got: #{event.type}; #{event.peer}; "

server.host\flush!
