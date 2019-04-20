--|========================|
--|   Антимут | AntiMute   |
--| Проект MCSkill.ru TMSB |
--|  Author: InfinityDark  |
--|  Developer: Barawik_   |
--|  Version 0.3 Lua Lang  |
--|========================|

-- | Планируется графический интерфейс.

local str=require("string")
local event=require("event")
local component=require("component")
local shell=require("shell")
local cb=component.chat_box
local plrs={}
cb.setDistance(100)
local term=require("term")
local g=component.gpu
local color = g.setForeground
local colors = require("colors")
cb.setName("§a§lBP§7§o")
local BOTNAME = "§3Antimute System >> "
term.clear()

local WIGHT, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local Bar = require("Bar")

local colorsTable = {
            ['&0'] = function() color(0x000000) end,
            ['&1'] = function() color(0x0000AA) end,
            ['&2'] = function() color(0x00AA00) end,
            ['&3'] = function() color(0x00AAAA) end,
            ['&4'] = function() color(0xAA0000) end,
            ['&5'] = function() color(0xAA00AA) end,
            ['&6'] = function() color(0xFFAA00) end,
            ['&7'] = function() color(0xAAAAAA) end,
            ['&8'] = function() color(0x555555) end,
            ['&9'] = function() color(0x5555FF) end,
            ['&a'] = function() color(0x55FF55) end,
            ['&b'] = function() color(0x55FFFF) end,
            ['&c'] = function() color(0xFF5555) end,
            ['&d'] = function() color(0xFF55FF) end,
            ['&e'] = function() color(0xFFFF55) end,
            ['&f'] = function() color(0xFFFFFF) end }

cb.say(BOTNAME.."§aЗапущено!")
cb.say(BOTNAME.."§aТекущая версия: 0.3")
local function rem(player)
for i,k in pairs(plrs) do
if k==player then
  table.remove(plrs,i)
end
end
end


local function check(nick)
for k,v in pairs(plrs) do
if v==nick then 
print("\nPrivuet")
return true
end
end
	end
		
while true do
evt,_,plr,msg=event.pull("chat_message")
if msg=="-start" then
plrs[#plrs+1]=plr
cb.say(BOTNAME.."§8[§a+§8] §f".. plr)
end
			
if msg=="-stop" then
rem(plr)
cb.say(BOTNAME.."§8[§c-§8] §f".. plr)
end

if msg=="-closeapp" then
print("\nЗакрытие программы..")
os.sleep(1)
os.execute("reboot")
end
	
if string.find(msg, "-help") then
cb.say(BOTNAME.."§c§lCписок доступных команд:")
cb.say(BOTNAME.."§a§o-start §fприсоединиться к антимуту")
cb.say(BOTNAME.."§a§o-stop §fвыйти с антимута")
cb.say(BOTNAME.."§a§o-closeapp §fвыключает программу")
cb.say(BOTNAME.."§a§o-updateapp §fобновляет программу")
end
		
	
if msg=="-updateapp" then
cb.say(BOTNAME.."Начинаю обновление программы.")
os.sleep(1)
os.execute("wget -f https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/antimute.lua Antimute.lua")
os.sleep(1)
os.execute("Antimute.lua")	
end
	
	
term.clear()
for i,k in pairs(plrs) do
   g.set(1,i,k)
   if k==plr then cb.say(plr.." §b"..msg) end
end
end
