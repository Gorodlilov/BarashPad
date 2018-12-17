--|============================|
--|   BaraPad - universal pad  |
--|  Проект: MCSKILL.ru  TMSB  |
--|     Developer: Barawik_    |
--|============================|
local component = require("component")
local computer=require("computer")
local event = require("event")
local term = require("term")
local shell = require("shell")
local fs = require("filesystem")
local unicode=require("unicode")
local serial = require("serialization")
if not fs.exists("/lib/Bar.lua") then
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
end
local Bar = require("Bar")
local g = component.gpu
event.shouldInterrupt = function () return false end
--------------------Настройки--------------------
local WIGHT, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local COLOR1 = 0x00ffff --Рамка
local COLOR2 = 0x0000ff --Цвет кнопок
local COLOR3 = 0x333333 --Таблица
local COLOR_SHELL = 0xff00ff --Цвет шелла
-------------------------------------------------
if not (fs.exists(shell.getWorkingDirectory() .. "/Programms.lua")) then
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Programms.lua Programms.lua")
end

local mid = (WIGHT-32)/2+32
local login, prog, tech = false, false, false
local sel = 0

WIGHT, HEIGHT = Bar.Resolution(WIGHT, HEIGHT)
Bar.Ram("БарашкаПад", COLOR1,COLOR2,WIGHT, HEIGHT)

file = io.open(shell.getWorkingDirectory() .. "/Programms.lua", "r")
local progs = serial.unserialize("{" .. file:read(9999999) .. "}")
file:close()

function Login()
	login = false
	prog = false
	tech = false
	Bar.ClearL(HEIGHT)
	Bar.ClearR(WIGHT,HEIGHT)
	Rules()
	g.setForeground(COLOR1)
	Bar.Word(mid - 12,7, "BARAPAD2.0", 0x222222)
	Bar.MidR(WIGHT,32,"Введите пароль:")
	term.setCursor(mid-2,33)
	local p, nick = Bar.Read({mask = "*", max = 8, accept = "0-9a-f", blink = true, center = true, nick = true})
	if p==Bar.PASS then
		if nick then
			login = true
			Bar.MidR(WIGHT,33,"Приветствую, " .. nick)
			computer.addUser(nick)
			os.sleep(2)
			Bar.ClearL(HEIGHT)
			Bar.ClearR(WIGHT,HEIGHT)
			Rules(nick)
			Table()
		end
	end
	if p==Bar.OFF then
		if nick then
			login = true
			Bar.MidR(WIGHT,33,"Слушаюсь, " .. nick .. "перезагружаюсь.")
			os.sleep(2)
			shell.execute("reboot")
	end
		end
end

function Rules(nick)
	if (login) then
		g.setForeground(COLOR2)
		Bar.MidL(WIGHT,5,"==========================")
		Bar.MidL(WIGHT,11,"==========================")
		Bar.MidL(WIGHT,15,"==========================")
		Bar.MidL(WIGHT,31,"Добро пожаловать")
		g.setForeground(COLOR1)
		Bar.MidL(WIGHT,3, "Общая инфа:")
		Bar.MidL(WIGHT,6, "Монитор в идеале 5х3")
		Bar.MidL(WIGHT,7, "блока, чтоб не париться.")
		Bar.MidL(WIGHT,8, "Но если над другой, то")
		Bar.MidL(WIGHT,9, "в настройках каждой проги")
		Bar.MidL(WIGHT,10, "меняйте параметр WIGHT")
		Bar.MidL(WIGHT,12, "Autorun НЕ ставится свой,")
		Bar.MidL(WIGHT,32,nick)
		Bar.Button(7,34,18,3,COLOR1,COLOR2,"Обновить")
		Bar.Button(7,37,18,3,COLOR1,COLOR2,"Выйти")
	end
end

function TechPanel()
	prog = false
	g.fill(mid - 43, 13, 83, 23, " ")
	Bar.MidR(WIGHT, 20, "&bПриветик, я Барашка, принимаю все")
	Bar.MidR(WIGHT, 21, "&bпожелания: почта - vkd2005@mail.ru")
	tech = true
end

function ProgrammPanel()
	g.fill(mid - 43, 13, 83, 23, " ")
	tech = false
	Bar.MidR(WIGHT,11,"&bСписок программ для OpenComputers&r")
	g.setForeground(COLOR3)
	Bar.MidR(WIGHT,12, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━┓")
	Bar.MidR(WIGHT,13, "┃                       &bНазвание&r                      ┃     &bСтатус&r     ┃  &bРазмер&r  ┃")
	Bar.MidR(WIGHT,14, "┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━╋━━━━━━━━━━┫")
	for i = 1, 9 do 
		Bar.MidR(WIGHT,i+14, "┃                                                     ┃                ┃          ┃")
	end
	DrawProgs(0)
	prog = true
end

function DrawProgs(s)
	sel = s
	for i = 1, #progs do
		g.setForeground(COLOR1)
		g.set(mid-42, i+16, "                                                     ")
		g.set(mid+29, i+16, "          ")
		local name_progs = tostring(progs[i][1][1]) .. tostring(progs[i][1][2])
		if sel ~= i then
			g.set(mid-15-unicode.len(name_progs)/2, i+16, name_progs)		
		else
			g.set(mid-19-unicode.len(name_progs)/2, i+16, ">>> " .. name_progs .. " <<<")		
		end
		if (fs.exists(shell.getWorkingDirectory() .. "/" .. progs[i][1][1] .. ".lua")) then
			Bar.Text(mid + 12, i+16, "&2 Установлено  &r")
			local size = fs.size(shell.getWorkingDirectory() .. "/" .. progs[i][1][1] .. ".lua")
			Bar.Text(mid + 33 - unicode.len(size)/2, i+16, size .. "B")
		else
			Bar.Text(mid + 12, i+16, "&8Не установлено&r")
		end
	end
	g.fill(mid - 42, 27, 84, 10, " ")
	if sel ~= 0 then
		if (fs.exists(shell.getWorkingDirectory() .. "/" .. progs[sel][1][1] .. ".lua")) then
			Bar.Button(mid-21,33,20,3,COLOR1,COLOR2,"Запустить")
			Bar.Button(mid+1,33,20,3,COLOR1,COLOR2," Обновить ")
		else
			Bar.Button(mid-10,33,20,3,COLOR1,COLOR2,"Установить")
		end
		g.setForeground(COLOR1)
		Bar.MidR(WIGHT,28,"Требуемые компоненты:")
		local comp = ""
		for i = 1, #progs[sel][3] do
			comp = comp .. progs[sel][3][i] .. " &0|&r "
		end
		Bar.MidR(WIGHT,29, "&0|&r " .. comp)
	end
end

function Click(w,h)
	g.setForeground(COLOR1)
	if sel ~= 0 then
		if (fs.exists(shell.getWorkingDirectory() .. "/" .. progs[sel][1][1] .. ".lua")) then
			if w>=mid-21 and w<=mid-2 and h>=33 and h<=35 then
				for i = 1, #progs[sel][3] do
					if not (component.isAvailable(progs[sel][3][i])) then
						Bar.MidR(WIGHT,31,"&6Отсутствует компонент: &4" .. progs[sel][3][i])
						os.sleep(3)
						DrawProgs(sel)
						return
					end
				end
				term.clear()
				shell.execute(progs[sel][1][1])
				g.setForeground(COLOR1)
				print("\nКликни на монитор для перезагрузки")
				local e = event.pull("touch")
				print("\nРестарт...")
				os.sleep(2)
				shell.execute("reboot")
			elseif w>=mid+1 and w<=mid+20 and h>=33 and h<=35 then
				fs.remove(shell.getWorkingDirectory() .. "/" .. progs[sel][1][1] .. ".lua")
				Bar.Get(progs[sel][2],progs[sel][1][1] .. ".lua",mid-19,31)
				Bar.MidR(WIGHT,31,"                                        ")
				DrawProgs(sel)
				return
			end
		else
			if w>=mid-10 and w<=mid+9 and h>=33 and h<=35 then
				Bar.Get(progs[sel][2],progs[sel][1][1] .. ".lua",mid-19,31)
				Bar.MidR(WIGHT,31,"                                        ")
				DrawProgs(sel)
				return
			end
		end
	end
	for i = 1, #progs do
		if w>=mid-42 and w<=mid+38 and h == i + 16 then
			DrawProgs(i)
			return
		end
	end
	DrawProgs(0)
end

function Table()
	Bar.DrawImage(mid - 28,7, shell.getWorkingDirectory() .. "/LogoSkill.lua")
	Bar.Button(mid - 32,37,20,3,COLOR1,COLOR2,"Проги")
	Bar.Button(mid - 10,37,20,3,COLOR1,COLOR2,"Войти в шелл")
	Bar.Button(mid + 12,37,20,3,COLOR1,COLOR2,"Тех.панель")
	Bar.Button(WIGHT-11,3,7,4,COLOR1,COLOR2,"")
	Bar.Text(WIGHT-10,4,"&b┌│┐&r")
	Bar.Text(WIGHT-10,5,"&b└─┘&r")
end

function getButtons(w,h)
	if w>=7 and w<= 25 and h>=34 and h<=36 then --Кнопка обновить
		term.clear()
		fs.remove(shell.getWorkingDirectory() .. "/Barapad.lua")	
		fs.remove(shell.getWorkingDirectory() .. "/Programms.lua")
		fs.remove("/lib/Bar.lua")
		g.setForeground(COLOR1)
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barapad.lua Barapad.lua")
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Programms.lua Programms.lua")
		shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
		print("\nРестарт...")
		os.sleep(2)
		shell.execute("reboot")
	elseif w>=7 and w<= 25 and h>=37 and h<=39 then --Кнопка Логин
		Login()
	elseif w>=mid-32 and w<= mid-13 and h>=37 and h<=39 then --Кнопка Проги
		ProgrammPanel()
	elseif w>=mid-10 and w<= mid+9 and h>=37 and h<=39 then --Кнопка Войти в шеллB
		term.clear()
		g.setForeground(COLOR_SHELL)
		shell.execute("sh")
	elseif w>=mid+12 and w<= mid+31 and h>=37 and h<=39 then --Кнопка Тех.Панель
		TechPanel()
	elseif w>=WIGHT-11 and w<= WIGHT-6 and h>=3 and h<=6 then --Кнопка Офф
		computer.shutdown()
	end
end

Login()

while true do
	local e,_,w,h,_,nick = event.pull("touch")
	if (login) then
		getButtons(w,h)
		if (prog) then
			Click(w,h)
		end
	end
end
