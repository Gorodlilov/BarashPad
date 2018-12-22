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

if not fs.exists("/lib/Bar.lua") then
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
end
local Bar = require("Bar.lua")

--------------------Настройки--------------------
local WIGHT, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local COLOR1 = 0x30626b --Рамка
local COLOR2 = 0x240935 --Цвет кнопок
local COLOR3 = 0x00382b --Таблица
local COLOR_SHELL = 0xa73853 --Цвет шелла
local mid = (WIGHT-32)/2+32 -- Центральное слово
-------------------------------------------------

WIGHT, HEIGHT = Bar.Resolution(WIGHT, HEIGHT)
Bar.Ram("Обновляльщик", COLOR1,COLOR2,WIGHT, HEIGHT)
		g.setForeground(COLOR1)
		Bar.Word(mid - 24,7, "UPDBAR", 0x000000)

		Bar.Mid(WIGHT,26,"Прочитка старых файлов...")
		if fs.exists("Barapad.lua") then
		Bar.Mid(WIGHT,27,"Barapad обнаружен!")
		else
		Bar.Mid(WIGHT,27,"Barapad не обнаружен!")
		end
		os.sleep(2)
		if fs.exists("Programms.lua") then
		Bar.Mid(WIGHT,28,"Список программ обнаружен!")
		else
		Bar.Mid(WIGHT,28,"Список программ не обнаружен!")
		end
		os.sleep(2)
		Bar.Mid(WIGHT,30,"Начинаю удалять старые файлы.")
		os.sleep(1)
		shell.execute("rm Barapad.lua")
		shell.execute("rm Programms.lua")
		shell.execute("rm /lib/Bar.lua")
		Bar.Mid(WIGHT,31,"Старые файлы все удадалены!")
		os.sleep(2)
		Bar.Mid(WIGHT,33,"Начинаю закачку новых файлов.")
		os.sleep(1)
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barapad.lua Barapad.lua")
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Programms.lua Programms.lua")
		Bar.Mid(WIGHT,35,"Новые файлы загружены.")
		Bar.Mid(WIGHT,36,"Перезагружаем компьютер.")
		os.sleep(2)
		os.execute("reboot")
		
