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
local mid = (WIGHT-32)/2+32 -- Центральное слово
Bar.ansy = "1"
Bar.ansn = "2"
-------------------------------------------------

WIGHT, HEIGHT = Bar.Resolution(WIGHT, HEIGHT)
Bar.Ram("Чат избранных", COLOR1,COLOR2,WIGHT, HEIGHT)

		Bar.Word(mid - 24,7, "UChat", 0x000000)

Bar.MidR(WIGHT,28,"&bДобро пожаловать в мастер установки UChat от InfinityDark!")

if fs.exists("UChat.lua") then
	Bar.MidR(WIGHT,32,"&fUChat обнаружен. &dЖелаете продолжить? 1 - Да, 2 - Нет")
	term.setCursor(mid-2,33)
	local ans = Bar.Read({mask = "*", max = 1, accept = "0-9a-f", blink = true, center = true})
	if ans==Bar.ansy then
	Bar.MidR(WIGHT,33,"Начинаю установку UChat'a..")
	os.sleep(3)
	Dload()
	else
	os.execute("UChat.lua")
	end
end

function Dload()
print("Выполняем проверку компонентов...")
bridge=c.openperipheral_bridge
i=c.internet
i=c.data
print("Интернет карта,мост и карта данных(1 лвл) обнаружены!")
print("Для формирования настроек чата,вам нужно ввести ID вашей установки...")
print("Если вы не знаете что это такое,спросите у InfinityDark любым доступным способом(Discord)")
print("Введите ваш ID:")
id=io.read()
print("А сейчас введите НИК игрока,который будет администрировать чат на вашем сервере:")
odmen=io.read()
print("Вы уверены,что ввели всё правильно?ID: "..id..";Одмен: "..odmen)
print("Y/N ?")
i=io.read()
if require("string").lower(i)=="y" then
print("Создаём таблицу настроек...")
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
default_prefix="Человек"
}

print("Записываем настройки в файл....")
file=io.open(require("shell").getWorkingDirectory() .. "/UChatSettings", "w")
file:write(ser.serialize(settings))
file:close()
print("Скачиваем последнюю версию UChat...")
file=io.open(require("shell").getWorkingDirectory() .. "/UChat.lua","w")
for chunk in internet.request("https://raw.githubusercontent.com/BarawikS/BarashPad/master/programms/UChat.lua") do if chunk then file:write(chunk) end end
file:close()
print("Готово!")
print("Настраиваем автозапуск...")
file=io.open("/home/.shrc","a")
file:write("UChat")
file:close()
file=io.open(require("shell").getWorkingDirectory() .. "/UChatVersion","w")
file:write("0")
file:close()
print("UChat готов к использованию!")
require("shell").execute("rm UChatI.lua")
else
error("Попробуй ещё раз!")
end
end
