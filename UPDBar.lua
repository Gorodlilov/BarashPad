--|===================|
--| Обновлялка ofline |
--|  MCSkill.ru TMSB  |
--| BaraPad |  Und.OS |
--|Developer: Barawik_|
--|===================|

local shell = require("shell")
local fs = require("filesystem")
local event=require("event")
local component=require("component")
local colors = require("colors")
local g = component.gpu
local Bar = require("Bar")

if not fs.exists("/lib/Bar.lua") then
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
end

--------------------Настройки--------------------
local WIGHT, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local COLOR1 = 0x00ffff --Рамка
local COLOR2 = 0x0000ff --Цвет кнопок
local COLOR3 = 0x333333 --Таблица
local COLOR_SHELL = 0xff00ff --Цвет шелла
-------------------------------------------------

WIGHT, HEIGHT = Bar.Resolution(WIGHT, HEIGHT)
Bar.Ram("Обновляльщик", COLOR1,COLOR2,WIGHT, HEIGHT)

		Bar.Mid(WIGHT,5,"Прочитка старых файлов...")
		if fs.exists("Barapad.lua") then
		Bar.Mid(WIGHT,6,"Barapad обнаружен!")
		end
		os.sleep(2)
		if fs.exists("Programms.lua") then
		Bar.Mid(WIGHT,7,"Список программ обнаружен!")
		end
		os.sleep(2)
		Bar.Mid(WIGHT,9,"Начинаю удалять старые файлы.")
		os.sleep(1)
		shell.execute("rm Barapad.lua")
		shell.execute("rm Programms.lua")
		shell.execute("rm /lib/Bar.lua")
		Bar.Mid(WIGHT,10,"Старый файлы все удадалены!")
		os.sleep(2)
		Bar.Mid(WIGHT,11,"Начинаю закачку новых файлов.")
		os.sleep(1)
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barapad.lua Barapad.lua")
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Programms.lua Programms.lua")
		Bar.Mid(WIGHT,12,"Новые файлы загружены.")
		Bar.Mid(WIGHT,14,"Запускаем БараПад")
		os.sleep(2)
		shell.execute("Barapad.lua")
		
