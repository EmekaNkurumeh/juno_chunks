local Object = require "lib.classic"
local _ = require "lib.lume"


local Group = Object:extend()

function Group:new()
  Group.count = (Group.count and Group.count or 0)+ 1
end

function Group:__tostring()
  return "Group " .. tonumber(Group.count, 16)
end

function Group:__gc()
  Group.count = Group.count - 1
end

return Group
