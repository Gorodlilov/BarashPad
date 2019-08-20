local component = require("component")
local term = require("term")
local event = require("event")
local unicode=require("unicode")
local computer = require("computer")
local colors = require("colors")
local shell = require("shell")
local fs = require("filesystem")
local os = require("os")
local g = component.gpu
local c = component.chat_box
local COLOR_CMD = 0xffff00 --Цвет консоли
local NAMES = {"Дядюшка Стэнфорд", "Стэнли", "Александр", "Сашенька", "Фиона", "Малыш", "Единорожка", "Любоффничек"}
local PIDOR = {"какафка", "писька", "ванючка", "саленый агурец", "агуша"}
local fruit = {"апельсины", "мандарины", "ананасы", "яблоки", "картошку", "воду", "бананы"}
local BOT_NAME = "§a§l" .. NAMES[math.random(1, #NAMES)] .. " §f>> "
local loc = {"Чат"}
local w, h = 100, 33
term.clear()
g.setResolution(100,33)

c.setName("§aЛоггер§7")

if not (fs.exists("/nlogs.lua")) then
	print("\nСоздаем файл для записи логов /nlogs.lua ")
	file = io.open("/nlogs.lua", "a")
	file:write("--Файл для логов хы \n local component = require('component')\nlocal c = component.chat_box \n")
	file:close()
	os.sleep(1)
end

function draw()
      term.clear()
      g.setForeground(COLOR_CMD)
      g.set(4,1,"ОвечкасЛоггер любит жрать " .. fruit[math.random(1, #fruit)] )
    for i = 1, #loc do
        g.set(4,i+1,"[   ] " .. loc[i])
        g.setForeground(0x00ff00)
        g.set(5,i+1,"Чат")
        g.setForeground(0xffffff)
    end
    	g.set(63,2, "Список доступных команд:")
    	g.set(63,3, "~логи - просмотр логов чата")
    	g.set(63,4, "~обновление - обновление")
    	g.set(63,5, "~выключись - выключение проги")
end

function message(msg, nick)
    msg2 = msg
    msg = unicode.lower(msg)
        local user_say = user_say(msg2, nick)
            if #loc == 30 then
                table.remove(loc, 1)
            end
		if string.find(msg2, "~ds") then
			msg3 = string.gsub(msg2, "~ds", " ")
			c.say(COLOR1 .. nick .. " >>" .. msg3)
			table.insert(loc, nick .. " >>" .. msg3)
		elseif string.find(msg2, "!") then
			msg2 = string.gsub(msg2, "!", "")
			table.insert(loc, " [G] " .. nick .. " >> " .. msg2)
		else
			table.insert(loc," [L] " .. nick .. " >> " .. msg2)
		end
        draw()
        file2 = io.open("/nlogs.lua", "a")
		file2:write("c.say('"..nick .. " >> " .. msg2 .. "')\n")
		file2:close()
	end

function user_say(msg, nick)
  if string.find(msg, "=") ~= nil then
    if string.find(msg, "=") == 1 and (nick == dad ) then
         c.say(BOT_NAME.. unicode.sub(msg,2, unicode.len(msg)))
    end
  end
    if string.find(msg, "~обновление") ~= nil then
	  c.say("Проверяем обновления..")
      os.sleep(1)
      c.say("Обновления обнаружены")
      os.sleep(3)
	  c.say("Обновляемся...")
      os.execute("wget -f https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/Logger.lua logger.lua")
	  c.say("Перезагрузка систем.")
      os.sleep(3)
      os.execute("logger")
      os.exit()
	end
    if string.find(msg, "~выключись") ~= nil and (nick == "Barawik_") then
    	c.say(c_e .. "Вырубаюсь")
    	os.exit()
    elseif string.find(msg, "~выключись") ~= nil and (nick ~= "Barawik_")  then
    	c.say(c_e .. "Атань," ..PIDOR[math.random(1, #PIDOR)] .. " " .. nick .. ", ты ни дастоен этаго")
    end
    if string.find(msg, "~логи") ~= nil then
    	os.execute("/nlogs.lua")
    end
end
if BOT_NAME == "Дядюшка Стэнфорд" or BOT_NAME == "Стэнли" or BOT_NAME == "Александр" or BOT_NAME == "Любоффничек" then
c.say(BOT_NAME .. " Батя в здании!")
c.say(BOT_NAME .. " Текущая версия - §4Release - 1.0")
else
c.say(BOT_NAME .. " Девочки, а дезика не найдется?")
c.say(BOT_NAME .. " Я работаю на версии - §dRelease - 1.0")
end
 
while true do
    local _, _, nick, msg = event.pull(1, "chat_message")
    if msg ~= nil and nick ~= nil then
        message(msg, nick)
    end
end
