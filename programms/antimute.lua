--|========================|
--|   Антимут | AntiMute   |
--| Проект MCSkill.ru TMSB |
--|  Author: InfinityDark  |
--|  Developer: Barawik_   |
--|========================|

local str=require("string")
local event=require("event")
local component=require("component")
local cb=component.chat_box
local plrs={}
cb.setDistance(100)
local term=require("term")
local gpu=component.gpu
term.clear()

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


term.clear()
for i,k in pairs(plrs) do
   gpu.set(1,i,k)
   if k==plr then cb.setName(plr);cb.say(msg) end
end
end