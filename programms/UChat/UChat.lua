--|============================|
--|          UChat             |
--|    Автор: InfinityDark     |
--| Проект McSkill,cервер TMSB |
--|============================|

--todo:Новый дизайн(?),GUI для управлений

-----------
SETTINGS={
trigger="ые",
admin="InfinityDark",
default_x=1,
default_y=1,
default_prefix="Человек",
default_scale=1,
message_count=8,
updates_enabled=true,
internetchat_enabled=true,
updateimax=10,
icimax=5,
server_id="HTC"
}
-----------

local c=require("component")
local event=require("event")
local computer=c.computer
local os =require("os")
local shell = require("shell")
local serial = require("serialization")
local gpu=c.gpu
local bridge=c.openperipheral_bridge
local fs=require("filesystem")
local component=require("component")
local data=component.data
local glasses = component.openperipheral_bridge
local str = require("string")


online=glasses.addText(1,1,"")
tusers={}
local messages={}

local blacklist={}

local muted={}

local vanished={}

lineFields={}

usersMessages={}

userMessages={}

usersLineFields={}

userSettings={}



local chars={
{origin=" ",result=" "},
{origin="~",result="ё"},
{origin="q",result="й"},
{origin="w",result="ц"},
{origin="e",result="у"},
{origin="r",result="к"},
{origin="t",result="е"},
{origin="y",result="н"},
{origin="u",result="г"},
{origin="i",result="ш"},
{origin="o",result="щ"},
{origin="p",result="з"},
{origin="[",result="х"},
{origin="s",result="ы"},
{origin="d",result="в"},
{origin="f",result="а"},
{origin="a",result="ф"},
{origin="g",result="п"},
{origin="h",result="р"},
{origin="j",result="о"},
{origin="k",result="л"},
{origin="l",result="д"},
{origin=":",result="ж"},
{origin="'",result="э"},
{origin="z",result="я"},
{origin="x",result="ч"},
{origin="c",result="с"},
{origin="v",result="м"},
{origin="b",result="и"},
{origin="n",result="т"},
{origin="m",result="ь"},
{origin="<",result="б"},
{origin=".",result="ю"}
}



flag=false
mflag=false
vflag=false
used=-2

glasses.clear()
glasses.sync()
require("term").clear()
local time=""
y=2
i=1

local helpTable={
"/prefix префикс - поставить себе префикс",
"/scale 0.8 - изменить размер чата(норма-1)",
"/setx 1 - изменить x координат чата(норма-1)",
"/sety 1 - изменить y координат чата(норма-1)",
"/w ник смс - личное сообщение",
"/clear - очистить чат",
"Напишите IC в начале сообщения,что бы оно пошло в интер-серверный чат."
}

local motd="Для того,что бы писать в этот чат,начни сообщение с символа % "

print("Ждём 10 секунд перед запуском...")
--os.sleep(10)
print("Запускаемся")

local function loadUserSettings()
  file = io.open(shell.getWorkingDirectory() .. "/UChatUserSettings", "r") 
  userSettings = serial.unserialize(file:read(9999999)) 
  file:close()
end

local function loadMuted()
  file = io.open(shell.getWorkingDirectory() .. "/UChatMuted", "r") 
  muted = serial.unserialize(file:read(9999999)) 
  file:close()
end

local function loadVanished()
  file = io.open(shell.getWorkingDirectory() .. "/UChatVanished", "r") 
  vanished = serial.unserialize(file:read(9999999)) 
  file:close()
end

local function loadBlacklist()
  file = io.open(shell.getWorkingDirectory() .. "/UChatBlacklist", "r") 
  blacklist = serial.unserialize(file:read(9999999)) 
  file:close()
  
end

local function loadSettings()
  file= io.open(shell.getWorkingDirectory() .. "/UChatSettings", "r")
  SETTINGS = serial.unserialize(file:read(99999999))
  file:close()
end 

local function saveSettings()
  file=io.open(shell.getWorkingDirectory() .. "/UChatSettings", "w")
  file:write(serial.serialize(SETTINGS))
  file:close()
end

local function saveUserSettings()
  file=io.open(shell.getWorkingDirectory() .. "/UChatUserSettings", "w")
  file:write(serial.serialize(userSettings))
  file:close()
end

local function saveMuted()
  file=io.open(shell.getWorkingDirectory() .. "/UChatMuted", "w")
  file:write(serial.serialize(muted))
  file:close()
end

local function saveVanished()
  file=io.open(shell.getWorkingDirectory() .. "/UChatVanished", "w")
  file:write(serial.serialize(vanished))
  file:close()
end

local function saveBlacklist()
  file=io.open(shell.getWorkingDirectory() .. "/UChatBlacklist", "w")
  file:write(serial.serialize(blacklist))
  file:close()
end

if fs.exists(shell.getWorkingDirectory() .. "/UChatSettings") then
  loadSettings()
end

local function update()
	print("Проверяем наличие обновлений...")
	version=""
	for chunk in internet.request("http://superminecraft.000webhostapp.com/UChat/version") do version=version..chunk end
	if tonumber(version) then
  if fs.exists(shell.getWorkingDirectory() .. "/UChatVersion") then
		file = io.open(shell.getWorkingDirectory() .. "/UChatVersion", "r") 
		localVersion=tonumber(file:read(9999999))
		file:close()	
  else
  localVersion=0
  end
		if localVersion<tonumber(version) then
			print("Новая версия обнаружена!")
   print("Сохраняем настройки!")
   saveSettings()
			print("Ждём 5 секунд перед началом загрузки!")
			os.sleep(5)
			print("Начинаем загрузку!НЕ ВЫКЛЮЧАТЬ КОМП!")
			file=io.open(shell.getWorkingDirectory() .. "/UChat.lua","w")
			for chunk in internet.request("http://superminecraft.000webhostapp.com/UChat/UChat.lua") do if chunk then file:write(chunk) end end
			file:close()
			file=io.open(shell.getWorkingDirectory() .. "/UChatVersion", "w")
			file:write(version)
			file:close()
			print("Новая версия загружена!")
			print("Это версия: "..version)
			print("Перезагружаемся...")
			os.sleep(5)
			shell.execute("reboot")
  end
	end
end

if SETTINGS.updates_enabled then
	if not fs.exists(shell.getWorkingDirectory() .. "/UChatVersion") then
		file=io.open(shell.getWorkingDirectory() .. "/UChatVersion", "w")
		file:close()
	end
	internet=require("internet")
	update()
end

function transformByTable(strToTransform)
output=""
for char in string.gmatch(strToTransform, ".") do
for k,v in pairs(chars) do
  if v.origin==char then used=k;output=output..v.result;break end
end
if used<-1 then output=output..char end
used=-2
end
return output
end


function addGlobalMessage(msg)
users=bridge.getUsers()
for k,v in pairs(users) do
  for kk,vv in pairs(blacklist) do
    if vv==v.name then flag=true;break end
    end
  if not flag then
	addPrivateMessage(v.name,msg)
  end
  flag=false
  end
end

function addGlobalMessageFromTable(foo)
users=bridge.getUsers()
for k,v in pairs(users) do
  for kk,vv in pairs(blacklist) do
    if vv==v.name then flag=true;break end
    end
  if not flag then
  addPrivateMessageFromTable(v.name,foo)
  end
  flag=false
  end
end

function addPrivateMessageFromTable(nick,foo)
for k,v in pairs(foo) do 
  addPrivateMessage(nick,v)
end
end

function addPrivateMessage(nick,msg)
if usersMessages[nick] then
  for i=1,SETTINGS.message_count-1,1 do
    usersMessages[nick][i]=usersMessages[nick][i+1]
  end
  usersMessages[nick][SETTINGS.message_count]="§7["..real_time().."] §8[§6G§8] §r"..msg
else
setupPlayerMessages(nick)
for i=1,SETTINGS.message_count-1,1 do
  usersMessages[nick][i]=usersMessages[nick][i+1]
end
usersMessages[nick][SETTINGS.message_count]="§7["..real_time().."]§8[§6G§8]§r"..msg
end
end

function printMessages()
glasses.clear()
users=bridge.getUsers()
for k,v in pairs(users) do
  if userSettings[v.name] then
		for i=1,SETTINGS.message_count,1 do
        line=glasses.getSurfaceByName(v.name).addText(userSettings[v.name].x,userSettings[v.name].y+10*i,usersMessages[v.name][i])
        line.setScale(userSettings[v.name].scale)
		end
  else
    setupSettings(v.name)
	for i=1,SETTINGS.message_count,1 do
        line=glasses.getSurfaceByName(v.name).addText(userSettings[v.name].x,userSettings[v.name].y+10*i,usersMessages[v.name][i])
        line.setScale(userSettings[v.name].scale)
	end
end
end
glasses.sync()
end

function setupSettings(nick)
playertable={x=SETTINGS.default_x;y=SETTINGS.default_y;prefix=SETTINGS.default_prefix,scale=SETTINGS.default_scale}
userSettings[nick]=playertable
end

function setupMessages()
users=glasses.getUsers()
usersMessages={}
for k,v in pairs(users) do
  setupPlayerMessages(v.name)
end
end

function setupPlayerMessages(nick)
lines={}
for i=1,SETTINGS.message_count,1 do
  lines[i]=" : "
end
usersMessages[nick]=lines
addPrivateMessage(nick,motd)
end

function getHostTime(timezone)
    timezone = timezone or 2
    local file = io.open("/HostTime.tmp", "w")
    file:write("")
    file:close()
    local timeCorrection = timezone * 3600
    local lastModified = tonumber(string.sub(fs.lastModified("/HostTime.tmp"), 1, -4)) + timeCorrection
    fs.remove("/HostTime.tmp")
    local year, month, day, hour, minute, second = os.date("%Y", lastModified), os.date("%m", lastModified), os.date("%d", lastModified), os.date("%H", lastModified), os.date("%M", lastModified), os.date("%S", lastModified)
    return tonumber(day), tonumber(month), tonumber(year), tonumber(hour), tonumber(minute), tonumber(second)
end
 

function real_time()
  local time = {getHostTime(3)}
  local text = string.format("%02d:%02d", time[4], time[5])
  return text
end

local function internetChatUpdate()
answer=""
for chunk in require("internet").request("http://superminecraft.000webhostapp.com/UChat/chatread.php?id="..SETTINGS.server_id) do
  if tostring(chunk) then
	chunk=str.gsub(chunk,"_"," ")
    answer=answer..chunk
    end
  end
for i in string.gmatch(answer,"([^$$$]+)") do addGlobalMessage(i) end
pcall(printMessages)
end

local function internetChatSend(msg)
if msg then
  msg=str.gsub(msg," ","_")
  require("internet").request("http://superminecraft.000webhostapp.com/UChat/chatsend.php?id="..SETTINGS.server_id.."&msg=".."["..real_time().."]"..msg)
end
end


local function chatmsg(nick,message)

d64message=message
output=""

if str.sub(d64message,1,1) == "%" then

d64message=str.sub(d64message,2,str.len(d64message))
d64message=str.gsub(d64message,"&","§")

if str.sub(d64message,1,1)== "/" then
---------------------Внутричатовые команды--------------------------
i=1
words={}
for w in d64message:gmatch("%S+") do words[i]=w;i=i+1 end

if words[1] then

  if str.lower(words[1])=="/help" then
  addPrivateMessageFromTable(nick,helpTable)
  printMessages()
  end

  if str.lower(words[1])=="/clear" then
  setupPlayerMessages(nick)
  printMessages()
  end
  
  if str.lower(words[1])=="/list" then
  addPrivateMessage(nick,"Игроки в чате:")
  users=bridge.getUsers()
  for k,v in pairs(users) do
    addPrivateMessage(nick,v.name)
  end 
  printMessages()
  end

  if nick==SETTINGS.admin then --Команды одмена
	if words[1]=="/blacklist" then
addPrivateMessage(nick,"Игроки в чёрном списке:")
	for k,v in pairs(blacklist) do
		addPrivateMessage(nick,v)
	end
addPrivateMessage(nick,"Конец списка!")
	printMessages()
	end
	
	if words[1]=="/muted" then
addPrivateMessage(nick,"Игроки в муте:")
	for k,v in pairs(muted) do
		addPrivateMessage(nick,v)
	end
addPrivateMessage(nick,"Конец списка!")
	printMessages()
	end

  end--Команды одмена
  
end--1

if words[1] and words[2] then
	
	if str.lower(words[1])=="/prefix" then
		if userSettings[nick] then
			userSettings[nick].prefix=str.gsub(words[2],"&","§")
		else
			setupSettings(nick)
			userSettings[nick].prefix=str.gsub(words[2],"&","§")
		end
		saveUserSettings()
	end

	if str.lower(words[1])=="/scale" then
		if tonumber(words[2]) then
			if userSettings[nick] then
				userSettings[nick].scale=tonumber(words[2])
		else
			setupSettings(nick)
			userSettings[nick].scale=tonumber(words[2])
		end
		saveUserSettings()
		end
	end

	if str.lower(words[1])=="/setx" then
		if tonumber(words[2]) then
			if userSettings[nick] then
			userSettings[nick].x=tonumber(words[2])
		else
			setupSettings(nick)
			userSettings[nick].x=tonumber(words[2])
		end
		saveUserSettings()
		end
	end

	if str.lower(words[1])=="/sety" then
		if tonumber(words[2]) then
			if userSettings[nick] then
			userSettings[nick].y=tonumber(words[2])
		else
			setupSettings(nick)
			userSettings[nick].y=tonumber(words[2])
		end
		saveUserSettings()
		end
	end
	
	if nick==SETTINGS.admin then--Команды одмена
		
		if words[1]=="/mute" then
		if glasses.getSurfaceByName(words[2]) then
			table.insert(muted,words[2])
			addGlobalMessage(SETTINGS.admin.." замутил "..words[2])
			printMessages()
			saveMuted()
		else 
			addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
		end
		printMessages()
		end

		if words[1]=="/block" then
		if glasses.getSurfaceByName(words[2]) then
			table.insert(blacklist,words[2])
			addGlobalMessage(SETTINGS.admin.." добавил "..words[2].." в черный список")

			saveBlacklist()
		else 
			addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
		end
		printMessages()
		end
	
		if words[1]=="/vanish" then
			table.insert(vanished,words[2])
			saveVanished()
		end

  if words[1]=="/bc" then
  addGlobalMessage(transformByTable(str.sub(d64message,words[1]:len()+2,str.len(d64message))))
  printMessages()
  end

		if words[1]=="/unmute" then 
		if glasses.getSurfaceByName(words[2]) then
		for k,v in pairs(muted) do
			if v==words[2] then
				muted[k]=nil
				addGlobalMessage(SETTINGS.admin.." размутил "..words[2])
				break
			end
		end 
		saveMuted()
		else 
			addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
		end
		printMessages()
		end

		if words[1]=="/unvanish" then
		for k,v in pairs(vanished) do
			if v==words[2] then vanished[k]=nil;break end
		end
		saveVanished()
		end

if words[1]=="/unblock" then
if glasses.getSurfaceByName(words[2]) then
  for k,v in pairs(blacklist) do 
     if v==words[2] then blacklist[k]=nil;break end
  end
addGlobalMessage(SETTINGS.admin.." убрал "..words[2] .." с чёрного списка")
saveBlacklist()
else 
	addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
end
printMessages()
end

	end--Команды одмена

end--1+2

if words[1] and words[2] and words[3] then
	
	if words[1]=="/w" then
		if glasses.getSurfaceByName(words[2]) then
			message=str.sub(d64message,words[1]:len()+words[2]:len()+3,str.len(d64message))
			addPrivateMessage(nick,"§6[§cЯ§6] -> [§c"..words[2].."§6] §r"..message)
			addPrivateMessage(words[2],"§6[§c"..nick.."§6] -> [§cЯ§6] §r"..message)
--			print("["..nick.."] -> ["..words[2].."] "..message)
		else
			addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
		end
	printMessages()
	end
	
	
end--1+2+3


isCommand=true
end

-------------------------------------Конец Команд-------------------

if not isCommand then

for k,v in pairs(muted) do 
if v==nick then mflag=true end
end
if not mflag then
if userSettings[nick] then
temp=str.sub(message,2,str.len(message))
addGlobalMessage("§8["..userSettings[nick].prefix.."§8] §7"..nick.."§f: "..temp)
printMessages()
if true then
  internetChatSend("[ICM]".."["..SETTINGS.server_id.."]"..nick..":"..temp)
  end
else 
setupSettings(nick)
addGlobalMessage("§8["..userSettings[nick].prefix.."§8] §7"..nick.."§f: "..temp)
printMessages()
if true then
  internetChatSend("[ICM]".."["..SETTINGS.server_id.."]"..nick..":"..temp)
  end
end
end
mflag=false
end
end
isCommand=false
end

local function dchatmsg(nick,message)

d64message=data.decode64(message)
output=""

if str.sub(d64message,1,1) == "a" then

d64message=str.sub(d64message,2,str.len(d64message))
d64message=str.gsub(d64message,"&","§")

if str.sub(d64message,1,1)== "/" then
---------------------Внутричатовые команды--------------------------
i=1
words={}
for w in d64message:gmatch("%S+") do words[i]=w;i=i+1 end

if words[1] then

  if str.lower(words[1])=="/help" then
  addPrivateMessageFromTable(nick,helpTable)
  printMessages()
  end

  if str.lower(words[1])=="/clear" then
  setupPlayerMessages(nick)
  printMessages()
  end
  
  if str.lower(words[1])=="/list" then
  addPrivateMessage(nick,"Игроки в чате:")
  users=bridge.getUsers()
  for k,v in pairs(users) do
    addPrivateMessage(nick,v.name)
  end 
  printMessages()
  end

  if nick==SETTINGS.admin then --Команды одмена
  if words[1]=="/blacklist" then
addPrivateMessage(nick,"Игроки в чёрном списке:")
  for k,v in pairs(blacklist) do
    addPrivateMessage(nick,v)
  end
addPrivateMessage(nick,"Конец списка!")
  printMessages()
  end
  
  if words[1]=="/muted" then
addPrivateMessage(nick,"Игроки в муте:")
  for k,v in pairs(muted) do
    addPrivateMessage(nick,v)
  end
addPrivateMessage(nick,"Конец списка!")
  printMessages()
  end

  end--Команды одмена
  
end--1

if words[1] and words[2] then
  
  if str.lower(words[1])=="/prefix" then
    if userSettings[nick] then
      userSettings[nick].prefix=str.gsub(transformByTable(words[2]),"&","§")
    else
      setupSettings(nick)
      userSettings[nick].prefix=str.gsub(transformByTable(words[2]),"&","§")
    end
    saveUserSettings()
  end

  if str.lower(words[1])=="/scale" then
    if tonumber(words[2]) then
      if userSettings[nick] then
        userSettings[nick].scale=tonumber(words[2])
    else
      setupSettings(nick)
      userSettings[nick].scale=tonumber(words[2])
    end
    saveUserSettings()
    end
  end

  if str.lower(words[1])=="/setx" then
    if tonumber(words[2]) then
      if userSettings[nick] then
      userSettings[nick].x=tonumber(words[2])
    else
      setupSettings(nick)
      userSettings[nick].x=tonumber(words[2])
    end
    saveUserSettings()
    end
  end

  if str.lower(words[1])=="/sety" then
    if tonumber(words[2]) then
      if userSettings[nick] then
      userSettings[nick].y=tonumber(words[2])
    else
      setupSettings(nick)
      userSettings[nick].y=tonumber(words[2])
    end
    saveUserSettings()
    end
  end
  
  if nick==SETTINGS.admin then--Команды одмена
    
    if words[1]=="/mute" then
    if glasses.getSurfaceByName(words[2]) then
      table.insert(muted,words[2])
      addGlobalMessage(SETTINGS.admin.." замутил "..words[2])
      printMessages()
      saveMuted()
    else 
      addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
    end
    printMessages()
    end

    if words[1]=="/block" then
    if glasses.getSurfaceByName(words[2]) then
      table.insert(blacklist,words[2])
      addGlobalMessage(SETTINGS.admin.." добавил "..words[2].." в черный список")

      saveBlacklist()
    else 
      addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
    end
    printMessages()
    end
  
    if words[1]=="/vanish" then
      table.insert(vanished,words[2])
      saveVanished()
    end

  if words[1]=="/bc" then
  addGlobalMessage(transformByTable(str.sub(d64message,words[1]:len()+2,str.len(d64message))))
  printMessages()
  end

    if words[1]=="/unmute" then 
    if glasses.getSurfaceByName(words[2]) then
    for k,v in pairs(muted) do
      if v==words[2] then
        muted[k]=nil
        addGlobalMessage(SETTINGS.admin.." размутил "..words[2])
        break
      end
    end 
    saveMuted()
    else 
      addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
    end
    printMessages()
    end

    if words[1]=="/unvanish" then
    for k,v in pairs(vanished) do
      if v==words[2] then vanished[k]=nil;break end
    end
    saveVanished()
    end

if words[1]=="/unblock" then
if glasses.getSurfaceByName(words[2]) then
  for k,v in pairs(blacklist) do 
     if v==words[2] then blacklist[k]=nil;break end
  end
addGlobalMessage(SETTINGS.admin.." убрал "..words[2] .." с чёрного списка")
saveBlacklist()
else 
  addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
end
printMessages()
end

  end--Команды одмена

end--1+2

if words[1] and words[2] and words[3] then
  
  if words[1]=="/w" then
    if glasses.getSurfaceByName(words[2]) then
      message=transformByTable(str.sub(d64message,words[1]:len()+words[2]:len()+3,str.len(d64message)))
      addPrivateMessage(nick,"§6[§cЯ§6] -> [§c"..words[2].."§6] §r"..message)
      addPrivateMessage(words[2],"§6[§c"..nick.."§6] -> [§cЯ§6] §r"..message)
--      print("["..nick.."] -> ["..words[2].."] "..message)
    else
      addPrivateMessage(nick,"Игрок §c"..words[2].."§r не найден!Проверьте ник.")
    end
  printMessages()
  end
  
  
end--1+2+3


isCommand=true
end

-------------------------------------Конец Команд-------------------

if not isCommand then

d64message=transformByTable(d64message)

for k,v in pairs(muted) do 
if v==nick then mflag=true end
end
if not mflag then
if userSettings[nick] then

addGlobalMessage("§8["..userSettings[nick].prefix.."§8] §7"..nick.."§f: "..output)

printMessages()
if true then
  internetChatSend("[ICM]".."["..SETTINGS.server_id.."]"..nick..":"..str.sub(" "..output,2,str.len(output)+1))
  end
else 
setupSettings(nick)
addGlobalMessage("§8["..userSettings[nick].prefix.."§8] §7"..nick.."§f: "..output)
printMessages()
if true then
  internetChatSend("[ICM]".."["..SETTINGS.server_id.."]"..nick..":"..str.sub(" "..output,2,str.len(output)+1))
  end
end
end
mflag=false
end
end
isCommand=false
end

setupMessages()
printMessages()

if fs.exists(shell.getWorkingDirectory() .. "/UChatUserSettings") then
  loadUserSettings()
end
if fs.exists(shell.getWorkingDirectory() .. "/UChatMuted") then
  loadMuted()
end
if fs.exists(shell.getWorkingDirectory() .. "/UChatVanished") then
  loadVanished()
end
if fs.exists(shell.getWorkingDirectory() .. "/UChatBlacklist") then
  loadBlacklist()
end


updatei=1
ici=1

if SETTINGS.internetchat_enabled then
  internet.request("http://superminecraft.000webhostapp.com/UChat/chatread.php?id="..SETTINGS.server_id)
  internet.request("http://superminecraft.000webhostapp.com/UChat/chatsend.php?id="..SETTINGS.server_id.."&msg=UChat_с_ID_"..SETTINGS.server_id.."_начал_свою_работу!")
end


while true do
_,_,nick,_,message=event.pull(5,"glasses_chat_message")
if nick then chatmsg(nick,message);dchatmsg(nick,message) end
users=bridge.getUsers()
for k,v in pairs(users) do
  for kk,vv in pairs(vanished) do
  if vv==v.name then vflag=true end
  end
  if not vflag then tusers[i]=v.name;i=i+1 end
  vflag=false
end
i=1
online.delete()
if tusers[1] then
online=glasses.addText(12,1,table.concat(tusers,";"))
end
glasses.sync()



tusers={}

if SETTINGS.updates_enabled then
	if updatei==SETTINGS.updateimax then
		update()
		updatei=0
	end
	updatei=updatei+1
end

if SETTINGS.internetchat_enabled then
  if ici==SETTINGS.icimax then
  internetChatUpdate()
  ici=-1
  end
ici=ici+1
end

end