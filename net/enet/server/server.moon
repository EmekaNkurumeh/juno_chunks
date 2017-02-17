#!/usr/bin/env moon

init = ->
  dofile "../../init.lua"

xpcall init, os.exit

require "enet"

server = {
  running: true,
  port: arg[1] or 8081
  clients: {}
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
        id, msg = server.clients["#{event.peer}"], event.data
        if id and msg
          print "recieve: #{event.peer}  #{event.data}"
          server.host\broadcast "#{id}: #{msg}"
      when "connect"
        print "connect: #{event.peer}"
        event = server.host\service server.timeout
        id = event.data\match "(%x*)"
        server.clients["#{event.peer}"] = id
        if id
          server.host\broadcast "* #{id} has connected *"

      when "disconnect"
        print "disconnect: #{event.peer}"
        id = server.clients["#{event.peer}"]
        if id
          server.host\broadcast "* #{id} has disconnected *"
          server.clients["#{event.peer}"] = nil

      else
        print "got: request type #{event.type}; from #{event.peer}; #{event.data};"

server.host\flush!
