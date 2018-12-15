--|========================|
--|   Антимут | AntiMute   |
--| Проект MCSkill.ru TMSB |
--|  Author: InfinityDark  |
--|  Developer: Barawik_   |
--|========================|

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
local INF = "§6[§bAntiMute§6]"
term.clear()

local WIGHT, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local Bar = require("Bar")

print("\nАнтимут - обходит мут в локальном чате")
print("\nАвтор - InfinityDark, доработано Barawik_")

cb.say(INF.."§aУниверсальная программа для обхода мута." .." §fAuthor: §eInfinityDark.")
cb.say(INF.."§aЖелаем приятного пользования.".. "§fMODDED: §dBarawik_")

local function rem(player)
for i,k in pairs(plrs) do
if k==player then
  table.remove(plrs,i)
  end
end
end

while true do
evt,_,plr,msg=event.pull("chat_message")
if msg=="-start" then
plrs[#plrs+1]=plr
end

if msg=="-stop" then
rem(plr)
end

if msg=="-closeapp" then
print("\nЗакрытие программы..")
os.sleep(1)
os.execute("reboot")
end

if str.fing(msg, "-upd") ~= nil then (nick == "Barawik_") then
	cb.say(INF.."§4Обновляюсь..")
	os.sleep(1)
	shell.execute("rm Antimute.lua")
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/antimute.lua Antimute.lua")
	shell.execute("Antimute.lua")

term.clear()
for i,k in pairs(plrs) do
   g.set(1,i,k)
   if k==plr then cb.say(..plr..msg) end
end
end
