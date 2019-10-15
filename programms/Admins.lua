local component = require("component")
local computer=require("computer")
local event = require("event")
local term = require("term")
local shell = require("shell")
local fs = require("filesystem")
local unicode=require("unicode")
local serial = require("serialization")
local g = component.gpu
event.shouldInterrupt = function () return false end
--------------------Настройки--------------------
local WIDTH, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local COLOR1 = 0x00ffff --Рамка
local COLOR2 = 0x333333 --Цвет кнопок
local UPDATE = 300 --Апдейт отображения информации в сек.
local SCOREBOARDS = {"Admin", "TAdmin", "Global", "Global", "GD", "GM", "STMod", "Dev", "Builder", "Modn",
"Helper2", "Helper1"} --Названия Скорбордов (Создать такие же на серве, либо поменять тут)
local MOD_CHAT_COLOR = {"&8", "&8", "&8", "&8", "&9", "&9", "&3", "&5", "&5", "&6", "&2", "&a"} --Изменение цвета ника в Мод.Чате
-------------------------------------------------
if not (fs.exists(shell.getWorkingDirectory() .. "/lib/sky.lua")) then
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/sky.lua /lib/sky.lua -f")
end
local sky = require("sky")
local mid = WIDTH / 2
local sel = nil
local admins
local timer = 0
local stat = {"&0[&4Админ&0] - &0", "&0[&4Тех.Админ&0] - &0", "&0[&4Глобал Мод&0] - &0", "&0[&4Куратор&0] - &0", "&0[&9Дизайнер&0] - &3","&0[&9Гл.Модератор&0] - &3",
"&0[&3Ст.Модератор&0] - &3", "&0[&5Разработчик&0] - &d", "&0[&5Строитель&0] - &d", "&0[&4Модератор&0] - &6","&0[&2Помощник&0] - &2", "&0[&aСтажёр&0] - &2"}

file = io.open("/AdminsBD.lua", "r")
local reads = file:read(9999999)
if reads ~= nil then
	admins = serial.unserialize("{" .. reads .. "}")
else
	admins = {}
end
file:close()

g.setResolution(WIDTH, HEIGHT)
sky.logo("OpenAdmins", COLOR1, COLOR2, WIDTH, HEIGHT)

function Save()
	file = io.open("/AdminsBD.lua", "w")
	local text = ""
	for i = 1, #admins do
		text = text .. "{'"..admins[i][1].."','"..admins[i][2].."','"..admins[i][3].."'},\n"		
	end
	file:write(text)
	file:close()
end

function Seen(nick)
	local year, month, day, hour, minute = 0,0,0,0,0
	local c = sky.com("seen " .. nick)
	if string.find(c, "Ошибка") ~= nil then
		return "&4error"
	end
	local _, b = string.find(c, "§6 с §c")
	local text = string.sub(c, b+1, unicode.len(c))
	if string.find(text, "лет") ~= nil then
		year = string.sub(text, string.find(text, " лет")-2, string.find(text, " лет")-1)
	end
	if string.find(text, "год") ~= nil then
		year = 1
	end
	if string.find(text, "месяц") ~= nil then
		month = string.sub(text, string.find(text, " месяц")-2, string.find(text, " месяц")-1)
	end
	if string.find(text, "дн") ~= nil then
		day = string.sub(text, string.find(text, " дн")-2, string.find(text, " дн")-1)
	elseif string.find(text, "день") ~= nil then
		day = 1
	end
	if string.find(text, "час") ~= nil then
		hour = string.sub(text, string.find(text, " час")-2, string.find(text, " час")-1)
	end
	if string.find(text, "минут") ~= nil then
		minute = string.sub(text, string.find(text, " минут")-2, string.find(text, " минут")-1)
	end
	local status
	if string.find(c, "онлайн") ~= nil then
		status = "&2online"
	else
		status = "&0offline"
	end
	return status, tonumber(year), tonumber(month), tonumber(day), tonumber(hour), tonumber(minute)
end

function Update()
	for i = 1, #admins do
		g.set(mid-45,i+13,"                                     ")
		sky.text(mid-45, i+13, admins[i][1] .. admins[i][2])
		sky.text(mid-8, i+13, admins[i][3] .. "  ")
		
		sky.text(mid+4, i+13, "&6" .. sky.playtime(admins[i][2]) .. "    ")
		
		local status, year, month, day, hour, minute = Seen(admins[i][2]) 
		g.set(mid+20,i+13,"                       ")
		if status == "&4error" then
			sky.text(mid+20,i+13, status)
		elseif year ~= 0 then
			sky.text(mid+20,i+13, status .. " - " .. year .. " лет " .. month .. " мес. ")
		elseif month ~= 0 then
			sky.text(mid+20,i+13, status .. " - " .. month .. " мес. " .. day .. " дн. ")
		elseif day ~= 0 then
			sky.text(mid+20,i+13, status .. " - " .. day .. " дн. " .. hour .. " ч. ")
		else
			sky.text(mid+20,i+13, status .. " - " .. hour .. " ч. " .. minute .. " мин. ")
		end
	end
end

function Sort()
	local buffer = {}
	for i = 1, #stat do
		for j = 1, #admins do
			if stat[i] == admins[j][1] then
				table.insert(buffer, admins[j])
			end
		end
	end
	admins = buffer
end

function Sel()
	for i = 1, #admins do
		sky.text(mid-51,i+13, "   ")
		sky.text(mid+45,i+13, "   ")
		if sel~= nil then
			if sel == admins[i][2] then
				sky.text(mid-51,i+13, "&b>>>")
				sky.text(mid+45,i+13, "&b<<<")
			end
		end
	end
end

function Draw()
	if sel ~= nil then
		sky.button(mid-44,HEIGHT-4,20,3,COLOR1,COLOR2,"Повысить")
		sky.button(mid-22,HEIGHT-4,20,3,COLOR1,COLOR2,"Понизить")
		sky.button(mid+6,HEIGHT-4,20,3,COLOR1,COLOR2,"Male/Female")
		sky.button(mid+28,HEIGHT-4,20,3,COLOR1,COLOR2,"Удалить")
	else
		g.fill(3,HEIGHT-6, WIDTH-11, 5, " ")
	end
end

function Index(array, value)
	for i = 1, #array do
		if value == array[i] then
			return i
		end
	end
end

function Click(w,h)
	if sel~= nil then
		local sel_id
		for i = 1, #admins do
			if sel == admins[i][2] then
				sel_id = i
				break
			end
		end
		if w>=mid-44 and w<=mid-25 and h>=HEIGHT-4 and h<=HEIGHT-2 then
			index = Index(stat,admins[sel_id][1]) - 1
			if index == 0 then index = 1 end
			admins[sel_id][1] = stat[index]		
			Sort()
			sky.com("scoreboard teams join " .. SCOREBOARDS[index] .. " " .. sel)
			sky.com("nick " .. sel .. " " .. MOD_CHAT_COLOR[index] .. sel)
		elseif w>=mid-22 and w<=mid-3 and h>=HEIGHT-4 and h<=HEIGHT-2 then
			index = Index(stat,admins[sel_id][1]) + 1
			if index == #stat + 1 then index = #stat end
			admins[sel_id][1] = stat[index]	
			Sort()
			sky.com("scoreboard teams join " .. SCOREBOARDS[index] .. " " .. sel)
			sky.com("nick " .. sel .. " " .. MOD_CHAT_COLOR[index] .. sel)
		elseif w>=mid+6 and w<=mid+25 and h>=HEIGHT-4 and h<=HEIGHT-2 then
			if admins[sel_id][3] == "&bMale" then
				admins[sel_id][3] = "&dFemale"
			else
				admins[sel_id][3] = "&bMale"
			end
		elseif w>=mid+28 and w<=mid+47 and h>=HEIGHT-4 and h<=HEIGHT-2 then
			table.remove(admins, sel_id)
			g.fill(3,13,WIDTH-4,25, " ")
			sky.com("scoreboard teams leave " .. sel)
			sky.com("nick " .. sel .. " " .. sel)
		end
		Update()
		Save()
	end
	
	if w>=WIDTH-8 and w<=WIDTH-4 and h>=HEIGHT-4 and h<=HEIGHT-2 then
		sky.text(mid-44, HEIGHT-6,"&bВведите ник:")
		term.setCursor(mid-30, HEIGHT-6)
		local n = io.read()
		table.insert(admins, {stat[#stat], n, "&bMale"})
		g.set(mid-44, HEIGHT-6,"                                                                                        ")
		Update()
		Save()
		sky.com("scoreboard teams join " .. SCOREBOARDS[#SCOREBOARDS] .. " " .. n)
		sky.com("nick " .. n .. " " .. MOD_CHAT_COLOR[#MOD_CHAT_COLOR] .. n)
	end
	
	if h-13 >= 1 and h-13 <= #admins then
		sel = admins[h-13][2]
		Sel()
	else
		sel = nil
		Sel()
	end
	
	Draw()
end

sky.button(WIDTH - 8,HEIGHT-4,5,3,COLOR1,COLOR2,"+")
Update()

while true do
	local e,_,w,h,_,nick = event.pull(UPDATE, "touch")
	if e == "touch" then
		Click(w,h)
	end
	if sel == nil then
		Update()
	end
end
