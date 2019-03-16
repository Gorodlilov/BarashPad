--
-- Создано групой GoroDiloVvInc
--
-- Яндекс.Станция с голосовый помощником Алисой, разработана группой GoroDiloVvInc. Текущая версия Aplha 0.2
--
local component = require("component")
local term = require("term")
local event = require("event")
local unicode=require("unicode")
local computer = require("computer")
local colors = require("colors")
local shell = require("shell")
local os = require("os")
local g = component.gpu
local c = component.chat_box
local debug = computer.addUser
local BOT_NAME = "§8[§cЯ§1ндекс.§6Станция§8] §dАлиса§f: " --Преффикс и имя бота
local NEW_NAME = "§9[§6I§cnformation§9] "
local COLOR1 = "§6" --Цвет основного текста
local COLOR2 = "§a" --Цвет выделенных слов
local COLOR3 = "§6"
local COLOR_CMD = 0xffff00 --Цвет консоли
local dad = "Barawik_"
local dad2 =  {"Barawik_"}
local owe = {"alexowe"}
local ace = {"Master_ACE"}
local dad3 = {"Barawik_"}
local react = {"KirillReact"}
local ang = {"Hell_s_Angel"}
local MASS1 = {"Привет", "Привки", "Рада вас видеть", "Добрый день", "Какие планы", "Здравствуй", "Приветик", "Hello"}
local MASS2 = {"Норм","Нормас","Замечательно","Топово"}
local WORDS = {"солнце", "зайка", "пупсик", "котик", "сладкий", "милый", "медвежонок", "ангелочек", "одуванчик", "малыш", "кисик",
"любимый", "родной", "симпотяжка", "львеночек", "тигреночек", "пушистик", "мой герой", "персик", "пончик", "котенок"}
local glob, loc = {"Я вас приветствую! Команды: ~инфо"}, {"Чат"}
local w, h = 100, 33
term.clear()
c.setName("§bOBT")
function hello(msg) --Приветствие
                  if string.find(msg, "~привет" ) ~= nil then
                    c.say(BOT_NAME .. COLOR1 ..  MASS1[math.random(1, #MASS1)] .." братишь")
                    return true
                end
       return false
end
 
function loff(msg)
                if string.find(msg, "~выключи свет") ~= nil then
                 c.say(BOT_NAME .. COLOR1 .. "!Выключила❤")
                   rs.setBundledOutput(2,colors.black,0)
                    return true
                end
       return false
end
 
function lon(msg)
                if string.find(msg, "~включи свет" ) ~= nil then
                 c.say(BOT_NAME .. COLOR1 .. "Включила❤")
                  rs.setOutput(1,0)
                    rs.setBundledOutput(2,colors.black,15)
                end
       return false
 
end
 
function privat(msg)
                if string.find(msg, "~как дела?" ) ~= nil then
                    c.say(BOT_NAME .. COLOR1 ..  MASS2[math.random(1, #MASS2)] .." ,а у вас?")
                    return true
                end
       return false
end
 
function info(msg)
    if string.find(msg,"~инфо") ~= nil then
    c.say(BOT_NAME..COLOR1.."➢  Мой функционал ")
    c.say(BOT_NAME..COLOR2.."➢ ")
    c.say(BOT_NAME..COLOR2.."➢ Выключение света: ~выключи свет")
    c.say(BOT_NAME..COLOR2.."➢ Включение света:~включи свет")
    c.say(BOT_NAME..COLOR2.."➢ Info pastebin: ~pastebin")
    c.say(BOT_NAME..COLOR2.."➢ Жители острова:~остров")
    return true
    end
    return false
end
 
function reac(msg)
    if string.find(msg,"поуподупоулптулпоутпоуопщ") ~= nil then
    c.say(BOT_NAME..COLOR1.."➢ Вывожу информацию с реакторов . . .")
    os.sleep(2)
     rs.setBundledOutput(2,colors.orange,15)
    os.sleep(2)
    rs.setBundledOutput(2,colors.orange,0)
    return true
    end
    return false
 end
 
function online(msg)
  if string.find(msg, "~остров") ~= nil then
    prov=computer.addUser(name)
        c.say(BOT_NAME..COLOR1.."Жители острова AlexOwe")
        c.say(BOT_NAME..COLOR3.."➢ alexowe ")
        c.say(BOT_NAME..COLOR3.."➢ Barawik_ ")
        c.say(BOT_NAME..COLOR3.."➢ Master_ACE")
        c.say(BOT_NAME..COLOR3.."Это все жители <3")
     end
end
function pastebin(msg)
	if string.find(msg, "~pastebin") ~= nil then
		c.say(NEW_NAME..COLOR2.."Pastebin")
		c.say(NEW_NAME..COLOR1.."Оригинальные записи на Pastebin")
		c.say(NEW_NAME..COLOR2.."Информация о проекте - написана в шапке.")
	end
end
function draw()
      term.clear()
      g.setForeground(COLOR_CMD)
      g.set(1,1,"┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓")
      g.set(1,33,"┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛")
      g.fill(1,2,1,31,"┃")
      g.fill(100,2,1,31,"┃")
    for i = 1, #loc do
        g.set(4,i+1,"[   ]" .. loc[i])
        g.setForeground(0x00ff00)
        g.set(5,i+1, "PMC")
        g.setForeground(0xffffff)
    end
    for i = 1, #glob do
       g.set(53,i+1,"<   >" .. glob[i])
        g.setForeground(0xff9900)
        g.set(54,i+1, "CMD")
        g.setForeground(0xffffff)
    end
end
function message(msg, nick)
    msg2 = msg
    msg = unicode.lower(msg)
        local privat = privat(msg)
        local hello = hello(msg)
        local lon= lon(msg)
        local loff= loff(msg)
        local reac= reac(msg)
        local info= info(msg)
        local online= online(msg)
		local pastebin= pastebin(msg)
    if (privat)  or (hello) or (lon) or (loff) or (reac) or (info) or (online) then
            if #glob == 38 then
                table.remove(glob, 1)
            end
            table.insert(glob, nick .. " >> " .. msg2)
            draw()
      else
        local user_say = user_say(msg2, nick)
               if #loc == 38 then
                table.remove(loc, 1)
            end
            table.insert(loc, nick .. " >> " .. msg2)
            draw()
    end
end
 
function user_say(msg, nick)
  if string.find(msg, "=") ~= nil then
    if string.find(msg, "=") == 1 and (nick == dad ) then
         c.say(BOT_NAME .. COLOR1 .. unicode.sub(msg,2, unicode.len(msg)))
    end
  end
        if string.find(msg, "~рестарт") ~= nil and (nick == "Barawik_" or nick == "alexowe") then
        c.say(NEW_NAME .. COLOR1 .. "Перезапуск системы компьютера.")
                dofile("/bin/reboot.lua")
    end
        if string.find(msg, "~споки") ~= nil and  (nick == "Barawik_" or nick == "alexowe") then
         c.say(BOT_NAME .. COLOR1 .. "Споки(((99(")
              computer.shutdown()
    end
        if string.find(msg, "~рестарт") ~= nil and  (nick ~= "Barawik_" or nick ~= "alexowe")  then
        c.say(BOT_NAME .. COLOR1 .. "Иди нафиг, " ..COLOR3 .. nick)
    end
        if string.find(msg, "~споки") ~= nil and  (nick ~= "Barawik_" or nick ~= "alexowe")  then
         c.say(BOT_NAME .. COLOR1 .. "ПШЕЛ ОТСЮДА КУДА ПОДАЛЬШЕ, "..COLOR3.. nick)
    end
    if string.find(msg, "~обновление") ~= nil and  (nick == "Barawik_" or nick == "alexowe")  then
      c.say(NEW_NAME .. COLOR1 .. "Получение обновлений...")
	  c.say(NEW_NAME .. COLOR1 .. "Обновления получены. Обновление.")
        os.execute("wget -f https://pastebin.com/raw/68SDDh5V home.lua")
		c.say(NEW_NAME .. COLOR2 .. "Перезагрузка систем.")
        os.sleep(3)
        os.execute("home")
        os.exit()
    end
   if string.find(msg, "~обновление") ~= nil and  (nick ~= "Barawik_" or nick ~= "alexowe") then
       c.say(BOT_NAME .. COLOR1 .. "ТЫ ЗАЕБАЛ! МОЙ 3Б УЖЕ ВЫЕХАЛ!!" .."§6"..nick.."§b. Ты не достоин этого!")
    end
    if string.find(msg, "love") ~= nil and (nick == "Barawik_" or nick == "alexowe") then
      c.say(BOT_NAME .. "§4❤")
    end
    if string.find(msg, "~debug") ~= nil and (nick == "Barawik_") then
       c.say(NEW_NAME .. COLOR1 .. "Выполняю . . .")
        computer.addUser(dad2)
    end
      if string.find(msg, "~кто я тебе?" ) ~= nil and (nick == "Barawik_" or nick == "alexowe") then
             c.say(BOT_NAME .."§dВы мой любимый❤")
    end
      if string.find(msg, "~кто я тебе?" ) ~= nil and (nick ~= "Barawik_" or nick ~= "alexowe") then
            c.say(BOT_NAME .."§9Фу,ты страшный!1!")
            c.say(BOT_NAME .."§9Тебе даже молоко корова не даст!!")
      end
   if string.find(msg, "~извинись") ~= nil and  (nick == "Barawik_") then
       c.say(BOT_NAME .. COLOR1 .. "Простите меня(" .."§6Я была не права")
    end
   if string.find(msg, "~извинись") ~= nil and  (nick ~= "Barawik_") then
       c.say(BOT_NAME .. COLOR1 .. "Пускай это напишет Barawik_" .."§6Тогда я извинюсь!")
	end
	   if string.find(msg, "~админские") ~= nil and  (nick == "Barawik_" or nick == "alexowe") then
       c.say(BOT_NAME .. COLOR1 .. "Список функций " .."§6для админиов")
	   c.say(BOT_NAME .. COLOR1 .. "Перезапуск компа " .."§b~рестарт")
	   c.say(BOT_NAME .. COLOR1 .. "Обновление " .."§b~обновление")
	   c.say(BOT_NAME .. COLOR1 .. "Конфиги " .."§b~configs")
	   c.say(BOT_NAME .. COLOR1 .. "Выключение компа " .."§b~споки")
    end
	   if string.find(msg, "~motd") ~= nil and  (nick == "Barawik_" or nick ~= "alexowe") then
c.say(NEW_NAME..COLOR1.."Здравствуйте, я Алиса. Голосовой помощник Яндекса.".. "§4")
c.say(NEW_NAME..COLOR1.."Сборка на PasteBin ".. "§4https://clck.ru/DnH52")
c.say(NEW_NAME..COLOR1.."GoroDiloVvInc (GitHub) ".. "§4https://clck.ru/DnH5k")
	end
	   if string.find(msg, "~motd") ~= nil and  (nick ~= "Barawik_" or nick ~= "alexowe") then
       c.say(BOT_NAME .. COLOR1 .. "Для использования команды вы должны быть" .." §bмоим хозяином :D")
	end
	   if string.find(msg, "~configs") ~= nil and  (nick == "Barawik_" or nick == "alexowe") then
       c.say(BOT_NAME .. COLOR1 .. "ПО от Barawik_:" .." §cЯ§3ндекс.§6Станция")
	   c.say(BOT_NAME .. COLOR1 .. "Версия прошивки:" .." §4LuaOST5M6S1B6")
	   c.say(BOT_NAME .. COLOR1 .. "Голосовой помощник:" .." §bОтсутствует")
	   c.say(BOT_NAME .. COLOR1 .. "Версия ПО:" .." §cAlpha v.0.2")
	   c.say(BOT_NAME .. COLOR1 .. "Разработка:" .." §aBarawik_")
	end
	        if string.find(msg, "~logis") ~= nil and (nick ~= "Barawik_" or nick ~= "alexowe") then
         c.say(BOT_NAME .. COLOR1 .. "Вы не достоины, уважаемый, "..COLOR3.. nick)
    end
		   if string.find(msg, "~logis") ~= nil and  (nick == "Barawik_" or nick == "alexowe") then
		    c.say(BOT_NAME .. COLOR1 .. "Ожидание доступа.")
			c.say(BOT_NAME .. COLOR2 .. "Доступ разрешен.")
			dofile("/home/ll.lua")
	end
end
 
c.say(NEW_NAME..COLOR1.."Здравствуйте, я Алиса. Голосовой помощник Яндекса.".. "§4")
c.say(NEW_NAME..COLOR1.."Сборка на PasteBin ".. "§4https://clck.ru/DnH52")
c.say(NEW_NAME..COLOR1.."GoroDiloVvInc (GitHub) ".. "§4https://clck.ru/DnH5k")
 
while true do
    local _, _, nick, msg = event.pull(1, "chat_message")
    if msg ~= nil and nick ~= nil then
        message(msg, nick)
    end
end
