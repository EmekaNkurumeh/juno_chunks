local version = _VERSION:match("%d+%.%d+")
path = '../../rocks'
package.path = path .. '/share/lua/' .. version .. '/?.lua;' .. path ..'/share/lua/' .. version .. '/?/init.lua;' .. package.path
package.cpath = path .. '/lib/lua/' .. version .. '/?.so;' .. package.cpath
