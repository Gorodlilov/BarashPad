--|========================|
--|   Антимут | AntiMute   |
--| Проект MCSkill.ru TMSB |
--|  Author: InfinityDark  |
--|  Developer: Barawik_   |
--|  Version 2.0 Lua Lang) |
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
local colors = require("colors")
cb.setName(plr)
term.clear()

local WIGHT, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local Bar = require("Bar")


cb.say("§aЗапущено!")

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
cb.say("§8[§a+§8] §f".. plr)
end
			
if msg=="-stop" then
rem(plr)
cb.say("§8[§c-§8] §f".. plr)
end

if msg=="-closeapp" then
print("\nЗакрытие программы..")
os.sleep(1)
os.execute("reboot")
end
	
if msg=="-updateapp" then
cb.say("\nНачинаю обновление программы.")
os.sleep(1)
os.execute("wget -f https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/antimute.lua Antimute.lua")
os.sleep(1)
os.execute("Antimute.lua")	
end
	
term.clear()
for i,k in pairs(plrs) do
   g.set(1,i,k)
   if k==plr then cb.say("§b"..msg) end
end
end
