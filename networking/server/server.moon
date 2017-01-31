#!/usr/bin/env moon

socket = require 'socket'

server = {
  running: true,
  port: arg[1] or 8080
  client: {}
}

server.udp = socket.udp!
server.udp\settimeout 0
res, err = server.udp\setsockname '*', server.port

if res
  print('*server started on port ' .. server.port .. '*')
else
  error err

while server.running
  data, msg_or_ip, port_or_nil = server.udp\receivefrom!
  if data
    cmd, id, msg = data\match '(%a+) (%x*) (.*)'
    switch cmd
      when 'post'
        if id and msg
          print id .. ': ' .. msg
          for _, info in pairs server.client
            server.udp\sendto id .. ' ' .. msg, info.ip, info.port
      when 'login'
        server.client[id] = ip: msg_or_ip, port: port_or_nil
        print '* ' .. id .. ' connected *'
      when 'logout'
        server.client[id] = nil
        print '* ' .. id .. ' disconnected *'
      else
        print data, cmd, id, msg
  elseif msg_or_ip != 'timeout' then
  	error 'unknown network error: ' .. tostring msg
  socket.sleep 0.01

server.udp\close!
