--|=======================|
--| UChat - Чат избранных |
--|    MCSkill.ru  TMSB   |
--|  Author InfinityDark  |
--|   Developer Barawik_  |
--|=======================|

internet=require("internet")
c=require("component")
term=require("term")
ser=require("serialization")
fs=require("filesystem")
shell=require("shell")
g=c.gpu

term.clear()

if not fs.exists("/lib/Bar.lua") then
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
end
local Bar = require("Bar")

--------------------Настройки--------------------
local WIGHT, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local COLOR1 = 0x30626b --Рамка
local COLOR2 = 0x240935 --Цвет кнопок
local COLOR3 = 0x00382b --Таблица
local COLOR_SHELL = 0xa73853 --Цвет шелла
local mid = (WIGHT-32)/2+32 -- Централизация :D
Bar.ansy = "1" -- Ответ на согласие установки на новую версии UChat'a
Bar.ansn = "2" -- Ответ на отказ установки новой версии UChat'a
-------------------------------------------------

local mid = (WIGHT-32)/2+32
local login, prog, tech = false, false, false
local sel = 0

WIGHT, HEIGHT = Bar.Resolution(WIGHT, HEIGHT)
Bar.Ram("Чат избранных", COLOR1,COLOR2,WIGHT, HEIGHT)

	start = false
	dload = false
	Bar.ClearL(HEIGHT)
	Bar.ClearR(WIGHT,HEIGHT)
	
		g.setForeground(COLOR1)
		Bar.Word(mid - 24,7, "UChat", 0x000000)
		Bar.MidR(WIGHT,28,"&bДобро пожаловать в мастер установки UChat от InfinityDark!")
if fs.exists("UChat.lua") then
	Bar.MidR(WIGHT,32,"&fUChat обнаружен. &dЖелаете продолжить? 1 - Да, 2 - Нет")
	term.setCursor(mid-2,33)
	local ans=io.Read
	if ans==1 then
	Bar.MidR(WIGHT,33,"Начинаю установку UChat'a..")
	os.sleep(3)
	Dload()
	else
	os.execute("UChat.lua")
	end
		end


-- Проверка компонентов

if not c.openperipheral_bridge then
error("Нету моста для очечек") else
Bar.MidL(WIGHT,15,"&bМост обнаружен.")
end

if not c.data then
error("Нету карты данных") else
Bar.MidL(WIGHT,16,"&bКарты данных есть")
end

if not c.internet then
error("Нету карточки с интернетам") else
Bar.MidL(WIGHT,17,"&bИнтернет обнаружен.")
end

Bar.MidR(WIGHT,30,"Для формирования настроек чата,вам нужно ввести ID вашей установки...")
Bar.MidR(WIGHT,31,"Если вы не знаете что это такое,спросите у InfinityDark любым доступным способом(Discord)")
Bar.MidR(WIGHT,33,"Введите ваш ID:")
	term.setCursor(mid-2,34)
id=io.read()
Bar.MidR(WIGHT,35,"А сейчас введите НИК игрока,который будет администрировать чат на вашем сервере:")
	term.setCursor(mid-2,36)
odmen=io.read()
Bar.MidR(WIGHT,37,"Вы уверены,что ввели всё правильно?ID: "..id..";Одмен: "..odmen)
Bar.MidR(WIGHT,38,"Y/N ?")
	term.setCursor(mid-2,39)
i=io.read()
if require("string").lower(i)=="y" then
Bar.MidL(WIGHT,20,"Создаём таблицу настроек...")
settings={
updates_enabled=true,
internetchat_enabled=true,
admin=odmen,
icimax=5,
updateimax=10,
server_id=id,
default_scale=1,
message_count=8,
trigger="ые",
default_x=1,
default_y=1,
default_prefix="Любимчик"
}

Bar.MidL(WIGHT,22,"Записываем настройки в файл....")
file=io.open(require("shell").getWorkingDirectory() .. "/UChatSettings", "w")
file:write(ser.serialize(settings))
file:close()
Bar.MidR("Скачиваем последнюю версию UChat...")
file=io.open(require("shell").getWorkingDirectory() .. "/UChat.lua","w")
for chunk in internet.request("https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/UChat/UChat.lua") do if chunk then file:write(chunk) end end
file:close()
Bar.MidL(WIGHT,23,"Готово!")
Bar.MidL(WIGHT,24,"Настраиваем автозапуск...")
file=io.open("/home/.shrc","a")
file:write("UChat")
file:close()
file=io.open(require("shell").getWorkingDirectory() .. "/UChatVersion","w")
file:write("0")
file:close()
Bar.MidR(WIGHT,39,"UChat готов к использованию!")
require("shell").execute("rm UChatI.lua")
else
error("Попробуй ещё раз!")
end
