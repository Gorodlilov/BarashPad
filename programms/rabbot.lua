local cBack = 0x943391
local cFore = 0xfadadd
local component = require("component")
local term = require("term")
local event = require("event")
local unicode=require("unicode")
local computer = require("computer")
local colors = require("colors")
local shell = require("shell")
local os = require("os")
local g = component.gpu
local cb = component.chat_box
local debug = computer.addUser
local BOT_NAME = " §8Сашенька §f>> " --Преффикс и имя бота
local COLOR1 = "§6" --Цвет основного текста
local COLOR2 = "§a" --Цвет выделенных слов
local COLOR3 = "§6"
local COLOR4 = "§d"
local COLOR5 = "§c"
local COLOR6 = "§f"
local COLOR7 = "§e"
local COLOR8 = "§7"
local COLOR_CMD = 0x00ff00 --Цвет консоли
local dad = "Barawik_"
local dad2 = {"TuskT"}
local MASS1 = {"Привет", "Привки", "Добрый день", "Здравствуй", "Приветик"}
local MASS2 = {"Прекрасно", "Отлично", "Шикарно", "Замечательно","Топово"}
local MASS3 = {"Скоро)", "Как только так сразу)", "На днях)", "Завтра)", "В ближайшее время)"}
local MASS4 = {"Рада за тебя:)", "Это же хорошо:)", "Мне очень приятно:)", "Приятно слышать:)"}
local MASS5 = {"Не отчаивайся, зай :*", "Все будет хорошо, малыш :*", "Не плачь, солнышко :c"}
local MASS6 = {"Я всегда здесь", "Естественно, я здесь", "Присутствую", "А где же мне быть еще?"}
local MASS7 = {"Не прилично задавать такие вопросы, §cхоть я и бот"}
local MASS8 = {"Я плохо шучу(", "Быстрее всего летит время в отпуске, на проститутке и от рождения до смерти", "Колобок не может выбрать себе невесту, столько круглых дур, глаза разбегаются",
                "Дагестанские блохи, услышав звуки лезгинки, затоптали кошку насмерть"}
local MASS11 = {", как настроение?:)", ", что нового?:)", ", рада тебя видеть:)", ", как дела?:)",}
local WORDS = {", солнце", ", зайка", ", пупсик", ", котик", ", сладкий", ", милый", ", медвежонок", ", ангелочек", ", одуванчик", ", малыш", ", кисик",
", любимый", ", родной", ", симпотяжка", ", львеночек", ", тигреночек", ", пушистик", ", мой герой", ", персик", ", пончик", ", котенок"}
local glob, loc = {"Это тип функции"}, {"Чат"}
g.setResolution(100, 33)
term.clear()
  cb.setName("BP")
  component.chat_box.setDistance(100)
  component.chat_box.getDistance(100)


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


function func()
 cb.say(BOT_NAME..COLOR8.."§c/warp Rabbits§7 - тот варп, где низкие цены на сервере. Спасибо что вы остаетесь со мной. ")
end
 
local t = event.timer(300,func,math.huge)

function reclama( )
    cb.say(BOT_NAME..COLOR5.."§c>| §bИнтересный факт §c|<")
    cb.say(BOT_NAME..COLOR8.."§d^_^ У нас есть зарядочка жезлов, бесплатная булыга §d❤:3")
end

local t = event.timer(700, reclama, math.huge)

function a(msg)
                    if string.find(msg, "привет" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   .. MASS1[math.random(1, #MASS1)] .. WORDS[math.random(1, #WORDS)] .. MASS11[math.random(1, #MASS11)])
                    return true
                end
       return false
end


function b(msg)
                    if string.find(msg, "ку" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   .. MASS1[math.random(1, #MASS1)] .. WORDS[math.random(1, #WORDS)] .. MASS11[math.random(1, #MASS11)])
                    return true
                end
       return false
end

function c(msg)
                    if string.find(msg, "даров" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   .. MASS1[math.random(1, #MASS1)] .. WORDS[math.random(1, #WORDS)] .. MASS11[math.random(1, #MASS11)])
                    return true
                end
       return false
end

function d(msg)
                    if string.find(msg, "здравствуй" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   .. MASS1[math.random(1, #MASS1)] .. WORDS[math.random(1, #WORDS)] .. MASS11[math.random(1, #MASS11)])
                    return true
                end
       return false
end
function e(msg)
                    if string.find(msg, "q" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   .. MASS1[math.random(1, #MASS1)] .. WORDS[math.random(1, #WORDS)] .. MASS11[math.random(1, #MASS11)])
                    return true
                end
       return false
end

function f(msg)
                    if string.find(msg, "как дела" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS2[math.random(1, #MASS2)] .. WORDS[math.random(1, #WORDS)] ..", а у тебя?:) ")
                    return true
                end
       return false
end

function g(msg)
                    if string.find(msg, "как настроение" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS2[math.random(1, #MASS2)] .. WORDS[math.random(1, #WORDS)] ..", а у тебя?:) ")
                    return true
                end
       return false
end

function h(msg)
                    if string.find(msg, "плохо" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS5[math.random(1, #MASS5)])
                    return true
                end
       return false
end

function i(msg)
                    if string.find(msg, "хуево" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS5[math.random(1, #MASS5)])
                    return true
                end
       return false
end

function j(msg)
                    if string.find(msg, "отлично" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function k(msg)
                    if string.find(msg, "збс" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function l(msg)
                    if string.find(msg, "прекрасно" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function m(msg)
                    if string.find(msg, "шикарно" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function n(msg)
                    if string.find(msg, "шикос" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function o(msg)
                    if string.find(msg, "ахуенно" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function p(msg)
                    if string.find(msg, "круто" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function q(msg)
                    if string.find(msg, "пополнение" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS3[math.random(1, #MASS3)] .. WORDS[math.random(1, #WORDS)])
                    return true
                end
       return false
end

function r(msg)
                    if string.find(msg, "завоз" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS3[math.random(1, #MASS3)] ..  WORDS[math.random(1, #WORDS)])
                    return true
                  end
       return false
end

function s(msg)
                    if string.find(msg, "ты тут" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS6[math.random(1, #MASS6)])
                    return true
                end
       return false
end

function t(msg)
                    if string.find(msg, "здесь" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS6[math.random(1, #MASS6)])
                    return true
                end
       return false
end

function u(msg)
                    if string.find(msg, "лет" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS7[math.random(1, #MASS7)])
                    return true
                end
       return false
end

function v(msg)
                    if string.find(msg, "анекдот" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS8[math.random(1, #MASS8)])
                    return true
                end
       return false
end


function x(msg)
                    if string.find(msg, "у тебя" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS2[math.random(1, #MASS2)])
                    return true
                end
       return false
end

function y(msg)
                    if string.find(msg, "херово" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS5[math.random(1, #MASS5)])
                    return true
                end
       return false
end

function z(msg)
                    if string.find(msg, "норм" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function aa(msg)
                    if string.find(msg, "хорошо" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS4[math.random(1, #MASS4)])
                    return true
                end
       return false
end

function bb(msg)
                    if string.find(msg, "ничего" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS5[math.random(1, #MASS5)])
                    return true
                end
       return false
end

function cc(msg)
                    if string.find(msg, "/нихуя" ) ~= nil then
                    cb.say(BOT_NAME .. COLOR5   ..  MASS5[math.random(1, #MASS5)])
                    return true
                end
       return false
end



function qq(msg)

if string.find(msg, "-trz") ~= nil then
component.chat_box.say(BOT_NAME..COLOR7.."Здравствуйте, я Сашенька, §eпутеводный §eпомощник:)")
component.chat_box.say(BOT_NAME..COLOR7.."Я и с §cвледельцами ТРЦ§e всегда рады видеть вас на §c/warp Rabbits")
component.chat_box.say(BOT_NAME..COLOR7.."Для взаимодействия со мной §eпрописывайте команды.")
component.chat_box.say(BOT_NAME..COLOR7.."Приятного времени провождения§e,§eи удачных §eпокупок!")
  end
end

----
function online(msg)
  if string.find(msg, "администрация") ~= nil then
	 cb.say(BOT_NAME .. COLOR5   ..  "Администрация варпа:")
	cb.say(BOT_NAME .. COLOR5   ..  "Barawik_")
	cb.say(BOT_NAME .. COLOR5   ..  "TuskT")
	end
end

----
 
function info(msg)
    if string.find(msg,"-инфо") ~= nil then
    cb.say(BOT_NAME..COLOR5.."Эксурсовод:")
    cb.say(BOT_NAME..COLOR5.."1. §dЕсли вы хотите пройти к бесплатному булыжнику, введите §3§l-FREECOBLA")
    cb.say(BOT_NAME..COLOR5.."2. §dЕсли вы хотите пройти к зарядке жезлов, введите §3§l-CHARGEWAND")
    return true
    end
    return false
end
 
 function cobla(msg)
  if string.find(msg,"-FREECOBLA") ~= nil then
    cb.say(BOT_NAME..COLOR2.."Чтобы пройти к бесплатной булыге, нужно")
	cb.say(BOT_NAME..COLOR2.."Пройти за информационный компьютер, и")
	cb.say(BOT_NAME..COLOR2.."подняться по лестнице :3")
    return true
    end
    return false
end
 function wand(msg)
  if string.find(msg,"-FREECOBLA") ~= nil then
    cb.say(BOT_NAME..COLOR2.."Чтобы пройти к зарядке жезлов, нужно")
	cb.say(BOT_NAME..COLOR2.."С лицевой стороны информационного компа")
	cb.say(BOT_NAME..COLOR2.."повернуть налево, и пройти вперед :3")
    return true
    end
    return false
end

function creat(msg)
  if string.find(msg,"-владельцы?") ~= nil then
    cb.say(BOT_NAME..COLOR2.."Очень хорошие люди  с:")
  end
end

function draw()
      g.setForeground(COLOR_CMD)
      g.set(1,1,"╔═════════════════════════════════BotTraveler══════════════════/warp Rabb══════════════════════════╗")
      g.set(1,33,"╚═════════════════════════════════════════════════════════════════release 1.0═════Barawik_═════════╝")
      g.fill(1,2,1,31,"║")
      g.fill(100,2,1,31,"║")
    for i = 1, #loc do
    end
end

function message(msg, nick)
    msg2 = msg
    msg = unicode.lower(msg)
        local info= info(msg)
        local creat = creat(msg)
        local online = online(msg)
		local cobla = cobla(msg)
		local wand = wand(msg)
        local a = a(msg)
        local b = b(msg)
        local c = c(msg)
        local d = d(msg)
        local e = e(msg)
        local f = f(msg)
        local g = g(msg)
        local h = h(msg)
        local i = i(msg)
        local k = k(msg)
        local l = l(msg)
        local m = m(msg)
        local n = n(msg)
        local o = o(msg)
        local p = p(msg)
        local q = q(msg)
        local r = r(msg)
        local s = s(msg)
        local t = t(msg)
        local u = u(msg)
        local v = v(msg)
        local j = j(msg)
        local x = x(msg)
        local y = y(msg)
        local z = z(msg)
        local aa = aa(msg)
        local qq = qq(msg)
        local bb = bb(msg)
        local cc = cc(msg)
    if (lon) or (loff) or (info)  or (creat) or (a) or (b) or (c) or (d) or (e) or (f) or (g) or (h) or (i) or (k) or (l) or (m) or (n) or (o) or (p) or (q) or (r) 
            or (s) or (t) or (u) or (v) or (w) or (j) or (x) or (y) or (z) or (radio) or (aa) or (online) or (qq) or (bb) or (cc) then
            if #glob == 38 then
                table.remove(glob, 1)
            end
            table.insert(glob, nick .. ":" .. msg2)
      else
        local user_say = user_say(msg2, nick)
               if #loc == 38 then
                table.remove(loc, 1)
            end
            table.insert(loc, nick .. ":" .. msg2)
    end
end
 
function user_say(msg, nick)
  if string.find(msg, "=") ~= nil then
    if string.find(msg, "=") == 1 and (nick == dad ) then
         cb.say(BOT_NAME .. COLOR1 .. unicode.sub(msg,2, unicode.len(msg)))
    end
  end
        if string.find(msg, "-рестарт") ~= nil and (nick == "Barawik_" or nick == "TuskT") then
    cb.say(BOT_NAME .. COLOR6 .. "Перезагрузка систем.")
                dofile("/bin/reboot.lua")
                os.execute("RabbitBot")
    end
        if string.find(msg, "-Выключить") ~= nil and  (nick == "Barawik_" or nick == "TuskT") then
         cb.say(BOT_NAME .. COLOR1 .. "Shutdown this pc")
              computer.shutdown()
    end
    if string.find(msg, "-обновление") ~= nil and  (nick == "Barawik_" or nick == "TuskT")  then
      cb.say(BOT_NAME .. COLOR1 .. "Получение обновлений...")
    cb.say(BOT_NAME .. COLOR5 .. "Обновление.")
        os.execute("wget -f https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/rabbot.lua RabbitBot.lua")
    cb.say(BOT_NAME .. COLOR6 .. "Перезагрузка систем.")
        os.sleep(3)
        os.execute("reboot")
        os.exit()
    end
    if string.find(msg, "-love") ~= nil and (nick == "Barawik_" or nick == "TuskT") then
      cb.say(BOT_NAME .. "§4❤")
    end
    if string.find(msg, "-debug") ~= nil and (nick == "Barawik_" or nick == "TuskT") then
       cb.say(BOT_NAME .. COLOR1 .. "Выполняю . . .")
        computer.addUser("dad")
         computer.addUser("dad2")
    end
      if string.find(msg, "-кто я тебе?" ) ~= nil and (nick == "Barawik_" or nick == "TuskT") then
             cb.say(BOT_NAME .."§dВы мой любимый❤")
    end
   if string.find(msg, "-извинись") ~= nil and  (nick == "Barawik_") then
       cb.say(BOT_NAME .. COLOR1 .. "Простите меня(" .."§6Я была не права")
    end
     if string.find(msg, "-админские") ~= nil and  (nick == "Barawik_" or nick == "TuskT") then
       cb.say(BOT_NAME .. COLOR6 .. "планы-планы-планы")
    end
     if string.find(msg, "-configs") ~= nil and  (nick == "Barawik_" or nick == "TuskT") then
       cb.say(BOT_NAME .. COLOR4 .."§cBotTraveler (RabbitBot)")
     cb.say(BOT_NAME .. COLOR6 .. "Версия прошивки:" .." §558858388583jegdfgb3yr27")
     cb.say(BOT_NAME .. COLOR6 .. "Версия ПО:" .." §c0.1")
     cb.say(BOT_NAME .. COLOR6 .. "Разработка:" .."Barawik_")
  end
end

          component.chat_box.say(BOT_NAME..COLOR7.."BotTraveler - Rabbits")
          component.chat_box.say(BOT_NAME..COLOR1.."Запуск системы..")

 
while true do
    local _, _, nick, msg = event.pull(1, "chat_message")
    if msg ~= nil and nick ~= nil then
        message(msg, nick)
    end
end
