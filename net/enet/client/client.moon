require "enet"
_  = require "lume"

math.randomseed os.time!

class client
  new: (port, addr, id, updr) =>
    @ticks = 0
    @cursor = 0
    @vursor = 1
    @size = 0

    @history = {}
    @lines = {}

    @textbuf = ""
    @inbuf = ""
    @enbuf = ""
    @caret = "_"

    @font = juno.Font.fromEmbedded 16
    @framebuffer = juno.Buffer.fromBlank juno.graphics.getSize!
    @returnbuffer = juno.Buffer.fromBlank juno.graphics.getSize!

    @port = port or 8081
    @addr = addr or "localhost"
    @updr = updr or 0.1
    @id = id or "%06x"\format math.random 0xffffff

  connect: =>
    @host = enet.host_create!
    @server = @host\connect @addr .. ":" .. @port
    -- event = @host\service 100
    -- if not event
    --   os.exit!

  disconnect: =>
    @server\disconnect!
    @host\flush!
    -- event = @host\service 100
    -- if event
    --   if event.type ~= "disconnect"
    --     os.exit!

  update: (dt) =>
    @ticks += dt
    @caret = (juno.time.getTime! % .6 < .3) and "_" or " "
    if @ticks > @updr
      event = @host\service 100
      if event
        if @line then
          @server\send @line
          @line = nil
        switch event.type
          when "receive"
            print "receive: #{event.peer} says #{event.data}"

        -- id, msg = data\match "(%x*) ?(.*)"
        -- table.insert @lines, id .. ": " .. msg
      @ticks -= @updr

  input: (key,char) =>
    switch key
      when "return"
        if #@textbuf > 0
          @line = "%s %s"\format @id, @textbuf
          table.insert @history, 2, @textbuf
          @textbuf = ""
          @inbuf, @enbuf = "", ""
          @size, @cursor = 0, 0
          @history[1] = ""
      when "backspace"
        temp, temp1 = _.cut @textbuf, @cursor
        @size = math.max 0, #@textbuf - 1
        @cursor = math.max 0, @cursor - 1
        temp = temp\sub 1, @cursor
        @textbuf = temp .. temp1
        @history[1] = @textbuf
      when "right"
        @cursor += 1
      when "left"
        @cursor = math.max 0, @cursor - 1
      when "home"
        @cursor = 0
      when "end"
        @cursor = @size
      when "up"
        @vursor = math.min #@history, @vursor + 1
        @textbuf = @history[@vursor]
        @size = #@textbuf
        @cursor = @size
      when "down"
        @vursor = math.max 1, @vursor - 1
        @textbuf = @history[@vursor]
        @size = #@textbuf
        @cursor = @size
      else
        if char
          temp, temp1 = _.cut @textbuf, @cursor
          @cursor += 1
          @textbuf = temp .. char .. temp1
          @size = #@textbuf
          @history[1] = @textbuf

    @inbuf,@enbuf = _.cut @textbuf, @cursor


  draw: () =>
    text = @inbuf .. @enbuf
    h = @font\getHeight!
    w = math.max 256, @font\getWidth text .. "_ "
    b = {x: 0,y: @framebuffer\getHeight! - 132, w: @framebuffer\getWidth!, h: 132}
    if #@lines > 0
      rh = #@lines * h
      for i, v in ipairs @lines
        w = math.max w, @font\getWidth v .. " "
      for i, line in ipairs @lines
        id, msg = line\match "(%x*): (.*)"
        y = @returnbuffer\getHeight! - (#@lines - i + 1) * h
        if id == @id
          @returnbuffer\setColor 086 / 255, 193 / 255, 215 / 255
          @returnbuffer\drawText @font, line, 8, y - 30
          @returnbuffer\setColor 1, 1, 1
        else
          @returnbuffer\setColor 205 / 255, 89 / 255, 90 / 255
          @returnbuffer\drawText @font, line, 8, y - 30
          @returnbuffer\setColor 1, 1, 1
      @framebuffer\copyPixels @returnbuffer, 0, @framebuffer\getHeight! - 132, b
      @framebuffer\drawBox 4, math.max(@framebuffer\getHeight! - rh - 32, @framebuffer\getHeight! - (h * 6) - 32), w - 2, math.min(rh + 4, 106)
    @framebuffer\drawBox 4, @framebuffer\getHeight! - h - 8, w - 2, h + 4
    @framebuffer\drawText @font, @inbuf .. @caret .. @enbuf, 8, (@framebuffer\getHeight! - h - 9) + 2
    juno.graphics.copyPixels @framebuffer, 0, 0
    @framebuffer\clear!
    @returnbuffer\clear!
client
