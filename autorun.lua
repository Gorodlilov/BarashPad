local shell = require('shell')
local term = require('term')
os.sleep(0.5)
shell.execute("wget -f https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
shell.execute("wget -f https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barapad.lua /Barapad.lua")
shell.execute("wget -f https://raw.githubusercontent.com/BarawikS/BarashPad/master/Programms.lua /Programms.lua")
term.clear()
local dir = " .. shell.getWorkingDirectory() .. "
if dir ~= '/' then shell.setWorkingDirectory(dir) end
shell.execute('/Barapad')
