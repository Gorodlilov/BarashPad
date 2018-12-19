--|======================|
--|   Объявления OpenBC  |
--|    Author: Shyvana   |
--|  Developer: Barawik_ |
--|    For Barapad 2.0   |
--|======================|

-- Обновлениям не подлежит.

local component = require("component")
local computer = require("computer")
local term = require("term")
local event = require("event")
local serialization = require("serialization")
local unicode = require("unicode")
local gpu = component.gpu


event.shouldInterrupt = function() return false end

local masters = {
	Shyvana = 1,
	Astro = 1,
}
function startup()
	local setf = gpu.setForeground
	term.clear()
	io.write("проверка мониторов")
	for i = 1,3 do
		os.sleep(0.2)
		io.write(" .")
	end
	
	local w,h = component.screen.getAspectRatio()
	if w == 7 and h == 3 then
		setf(0x00ff00)
		io.write(" ok\n")
		setf(0xffffff)
		os.sleep(1)
	else
		setf(0xff0000)
		io.write(" failed\n")
		setf(0xffffff)
		io.write("нужен экран 7 блоков в ширину и 3 в высоту,\n")
		io.write("а у тебя " .. w .. " в ширину и " .. h .. " в высоту\n\n")
		os.sleep(5)
		os.exit()
	end
	io.write("проверка чатбокса ")
	for i = 1,3 do
		os.sleep(0.2)
		io.write(" .")
	end

	if component.isAvailable("chat_box") == true then
		setf(0x00ff00)
		io.write(" ok\n")
		setf(0xffffff)
		os.sleep(2)
	else
		setf(0xff0000)
		io.write(" failed\n")
		setf(0xffffff)
		io.write("подключи творческий чатбокс")
		os.sleep(5)
		os.exit()
	end
end
--startup()
local chat = component.chat_box
--gpu.setResolution(140,28)
gpu.setResolution(160,28)
local timers = {}
function ioLoad()
	local f,err = io.open("/home/_timers","r")
	if err then
		local t = {}
		ff,errr = io.open("/home/_timers","w")
		if errr then
			error("kappa")
		end
		ff:write(serialization.serialize(t))
		ff:close()
	else
		local a = f:read()
		f:close()
		timers = serialization.unserialize(a)
	end
end
ioLoad()
local buttons = {}
chat.setName("§4Bs§7]")
local name2
--local name2 = "§8[§bBarapad§8]§f : "

function loadName2()
	local f,err = io.open("/home/_name2","r")
	if err then
		local name2 = "§8[§bBarapad§8]§a Бараш§f: "
		ff,errr = io.open("/home/_name2","w")
		if errr then
			error("kappa5")
		end
		ff:write(name2)
		ff:close()
		loadName2()
	else
		local a = f:read()
		f:close()
		name2 = a
	end
end
loadName2()
function saveName2()
	local f,err = io.open("/home/_name2","w")
	if err then
		error("ошибка saveName2()")
	end
	f:write(name2)
	f:close()

end
local lastOperator = ""
local c = {
	buttonOutlineDef = 0x00ff00,
	buttonFgDef = 0xFFFFFF,
	buttonBgDef = 0x222222,
	delayColorDef = 0xFFFFFF,
	delayColorInf = 0xff9900,
	listenColor = 0xffffff,
	idColor = 0xbababa,
	disabledColor = 0xbababa,
	broadcastColorDef = 0xffffff,
	removeColor = 0xFF0000,
	delayButtonString = "delay: ",
	removeButtonString = "remove",
	buttonOutlineDefStart = "[",
	buttonOutlineDefEnd = "]",
	offset_delete = 1,
	offset_broadcast = 10,
	offset_listen = 22,
	offset_paused = 31,
	offset_repeatDelay = 49,
	offset_id = 40,
	offset_text = 76,
	offset_edit1 = 64,
	maxwidth_repeatDelay = 14,
	maxwidth_id = 9,
	maxwidth_edit1 = 15,
	maxwidth_text = 100,
	pausedText = "paused",
	unpausedText = "active",
	pausedColor = 0xff9900,
	unpausedColor = 0x00ff00,
	unpausedInactiveColor = 0xa76805,
	readingFromChatMsgBackground = 0x6e6e6e,
	textFieldMaxLength = 50,
	helpWidth = 112,
}

buttonOutlineDefStartLength = unicode.len(c.buttonOutlineDefStart)
buttonOutlineDefEndLength = unicode.len(c.buttonOutlineDefEnd)
screenWidth, screenHeight = gpu.getResolution()
maxTimersAllowed = screenHeight-3


local helpStrings = {
	"       |ff0000[remove]|ffffff - удалить объявление",
	"    |00ff00[|ffffffbroadcast|00ff00]|ffffff - пустить объявление 1 раз в общий чат вне очереди",
	"       |00ff00[|fffffflisten|00ff00]|ffffff - пустить объявление 1 раз в локальный чат",
	"|00ff00[active|ffffff/|ff9900paused]|ffffff - поставить объявление на паузу и обратно:",
	"                  |00ff00[active]|ffffff - объявление активно",
	"                  |ff9900[paused]|ffffff - объявление на паузе. не даст снять с паузы если не заполнен текст или задержка",
	"          |bababa[id:]|ffffff - id таймера для отладки",
	"       |00ff00[|ffffffdelay:|00ff00]|ffffff - задержка между сообщениями в секундах (чем больше тем реже будут появляться сообщения)",
	"                  |ff9900delay: inf|ffffff значит что задержка не указана (сообщение не будет выводиться)",
	"                  если что, 5 минут = 300 секунд",
	"    |00ff00[|ffffffchat edit|00ff00]|ffffff - редактировать объявление, используя чат (текст объявления нужно будет ввести в чат игры)",
	"                  введи |17d4fdcancel|ffffff для отмены",
	"         |00ff00[|fffffftext|00ff00]|ffffff - последнее поле - сам текст объявления. можно редактировать, нажав на него мышкой.",
	"                  вставлять скопированный текст клавишей |17d4fdinsert|ffffff. вызвать предыдущий текст - |17d4fdстрелка вверх",
	"                  |17d4fdenter|ffffff для сохранения изменений. оставить поле пустым для отмены. |ff9900n/a|ffffff - текст отсутствует",
	"                  можно вводить форматирование и цвета символом |17d4fd&|ffffff  ",
	"",
	"выходить из проги только кнопкой |00ff00[|ffffffreboot|00ff00]|ffffff, или ручной перезагрузкой компа",
	"после повторного включения все объявления станут на паузу",
}
c.helpHeight = #helpStrings
function say(msg)
	component.chat_box.say("§bbroadcaster§7: " .. tostring(msg),20)
end
function listen(msg)
	if msg ~= "" then
		msg = msg:gsub("&","§")
		component.chat_box.say("[local] " .. name2 .. tostring(msg),20)
	end
end
function broadcast(msg)
	if msg ~= "" then
		msg = msg:gsub("&","§")
		component.chat_box.say(name2 .. tostring(msg)) -- убрать 20 для глобала
	end
end
function log(msg,color)
	local oldFg = gpu.getForeground()
	if color then
		gpu.setForeground(color)
	end
	io.write(msg .. "\n")
	if color then
		gpu.setForeground(oldFg)
	end
end
function ioSave()
	local f,err = io.open("/home/_timers","w")
	if err then
		error("ошибка ioSave()")
	end
	f:write(serialization.serialize(timers))
	f:close()
end
function addBroadcast(timer,msg,isPaused)
	checkArg(1,timer,"number")
	checkArg(2,msg,"string")
	checkArg(3,isPaused,"boolean","nil")
	local id = event.timer(timer,function() broadcast(msg) end, math.huge)
	table.insert(timers,{id = id, repeatDelay = timer, paused = isPaused or false, msg = msg})
end
function removeBroadcast(index,x,y)
	checkArg(1,index,"number")
	local oldbg = gpu.getBackground()
	local oldfg = gpu.getForeground()
	gpu.setBackground(0xFFFFFF)
	gpu.setForeground(0x000000)
	gpu.set(x,y,"[remove]")
	gpu.setForeground(oldfg)
	gpu.setBackground(oldbg)
	local evt,_,X,Y,_,NAME = event.pull("touch")
		if X >= x and X <= x+unicode.len(c.removeButtonString)+buttonOutlineDefStartLength+buttonOutlineDefEndLength and Y == y and NAME == lastOperator then

			if timers[index].paused == false then
				if event.cancel(timers[index].id) then
				else
					say("wrong timer id")
					error("kappa2")
				end
			end
			table.remove(timers,index)
	
	end
end
function switchPauseStatus(index)
	checkArg(1,index,"number")
	if timers[index].paused == false then
		if event.cancel(timers[index].id) then
			timers[index].paused = true
			timers[index].id = 0
		else
			error("kappa3")
		end
	elseif timers[index].paused == true then
		if timers[index].repeatDelay ~= math.huge and timers[index].msg ~= "" then
			local newid = event.timer(timers[index].repeatDelay,function() broadcast(timers[index].msg) end, math.huge)
			timers[index].id = newid
			timers[index].paused = false
		end
	end
end
function addButton(x,y,text,fg,bg,outline,maxWidth,functi,...)
	buttons[#buttons+1] = {
		x = x,
		y = y,
		text = text,
		textLen = unicode.len(text),
		fg = fg or c.buttonFgDef,
		bg = bg or c.buttonBgDef,
		outline = outline or c.buttonOutlineDef,
		maxWidth = maxWidth or nil,
		func = functi,
		args = {...}
	}
end
function addButton2(x,y,text,fg,bg,outline,maxWidth,functi,...)
	buttons2[#buttons+1] = {
		x = x,
		y = y,
		text = text,
		textLen = unicode.len(text),
		fg = fg or c.buttonFgDef,
		bg = bg or c.buttonBgDef,
		outline = outline or c.buttonOutlineDef,
		maxWidth = maxWidth or nil,
		func = functi,
		args = {...}
	}
end
function getTimersCount()
	local count = 0
	for k,v in pairs(timers) do
		count = count + 1
	end
	return count
end
function draw(table)
	local oldfg = gpu.getForeground()
	local oldbg = gpu.getBackground()
	local timersCount = getTimersCount()
	if table == buttons or table == nil then
		for k,this in pairs(buttons) do
			gpu.setForeground(this.outline)
			gpu.setBackground(this.bg)
			gpu.set(this.x,this.y,c.buttonOutlineDefStart)
			gpu.set(this.x+unicode.len(this.text)+buttonOutlineDefStartLength,this.y,c.buttonOutlineDefEnd)
			gpu.setForeground(this.fg)
			gpu.set(this.x+buttonOutlineDefStartLength,this.y,this.text)
			if this.maxWidth then
				local diff = this.maxWidth - (unicode.len(this.text)+buttonOutlineDefStartLength+buttonOutlineDefEndLength)
				if diff > 0 then
					gpu.setBackground(oldbg)
					gpu.set(this.x+unicode.len(this.text)+buttonOutlineDefStartLength+buttonOutlineDefEndLength,this.y,string.rep(" ",diff))
				end
			end
		end
		gpu.setForeground(oldfg)
		gpu.setBackground(oldbg)
		if timersCount < maxTimersAllowed then
			gpu.fill(1,timersCount+1,screenWidth,maxTimersAllowed-timersCount," ")
		end
	end
	gpu.setForeground(oldfg)
	gpu.setBackground(oldbg)
end
function getEvent()
	local evt,_,X,Y,_,name = event.pull("touch")
	--if masters[name] then
		for k,this in pairs(buttons) do
			if X >= this.x and X <= this.x+this.textLen+buttonOutlineDefStartLength+buttonOutlineDefEndLength and Y == this.y then
				if this.func then
					lastOperator = name
					this.func(table.unpack(this.args))
				end
			end
		end
	--end
end
function editDelay(x,y,index)
	gpu.set(x+1,y,string.rep(" ",c.maxwidth_repeatDelay-buttonOutlineDefStartLength-buttonOutlineDefEndLength))
	term.setCursor(x+1,y)
	local newValue = io.read()
	newValue = tonumber(newValue)
	if newValue == nil then
		return
	else
		newValue = math.floor(newValue)
	end
	if newValue > 99999 or newValue <= 0 then
		newValue = math.huge
	end
	switchPauseStatus(index)
	timers[index].repeatDelay = newValue
	switchPauseStatus(index)
end
function editMsg(x,y,index)
	gpu.fill(x+1,y,unicode.len(getButtonLabel(index)),1," ")
	term.setCursor(x+1,y)
	local param = {[1] = timers[index].msg, nowrap = true}
	local newValue = term.read(param)
	if string.sub(newValue,0,-2) == "" then
		return true
	else
		switchPauseStatus(index)
		newValue = string.sub(newValue,0,-2)
		timers[index].msg = newValue
		switchPauseStatus(index)
	end
end
function editMsgThroughChat(x,y,index)
	function getNextPlayerMessage(player)
		while true do
			local evt,_,name,msg = event.pull("chat_message")
			if name == player and string.find(msg,"!") ~= 1 and msg ~= "cancel" then
				return msg
			elseif msg == "cancel" then
			--and masters[name] then
				return nil
			end
		end
	end

	gpu.fill(x+1,y,unicode.len(getButtonLabel(index)),1," ")
	local oldbg = gpu.getBackground()
	gpu.setBackground(c.readingFromChatMsgBackground)
	gpu.set(x+1,y,"reading from chat (type \"cancel\" to cancel) ... ")
	gpu.setBackground(oldbg)
	local res = getNextPlayerMessage(lastOperator)
	if res then
		switchPauseStatus(index)
		timers[index].msg = res
		switchPauseStatus(index)
	else
		say("отмена")
	end
end
function getButtonLabel(index)
	local label
	if unicode.len(timers[index].msg) > c.textFieldMaxLength then
		label = unicode.sub(timers[index].msg,0,(unicode.len(timers[index].msg)-c.textFieldMaxLength-3)*-1) .. "..."
	else
		label = timers[index].msg
	end
	return label
end
function buttonAddBroadcast()
	--addBroadcast(math.huge,"",true)
	if getTimersCount() < maxTimersAllowed then
		table.insert(timers,{id = 0, repeatDelay = math.huge, paused = true, msg = ""})
	end
end
function buttonBroadcast(index)
	broadcast(timers[index].msg)
end
function buttonReboot()
	computer.shutdown(1)
end

function drawWindow(x,y,w,h)
	gpu.fill(x,y,w,h," ")
	gpu.set(x,y,string.rep("⠒",w))
	gpu.set(x,y+h,string.rep("⠤",w))
	gpu.set(x,y,string.rep("⡇",h),true)
	gpu.set(x+w,y,string.rep("⢸",h),true)
	
	gpu.set(x,y,"⡖")
	gpu.set(x+w,y,"⢲")
	gpu.set(x,y+h,"⠧")
	gpu.set(x+w,y+h,"⠼")
end
function drawText(x,y,array)
	function printLine(string)
		if string ~= "" then
			local a,b = string.find(string,"|........")
			if a == nil then
				io.write(string)
				gpu.setForeground(0xffffff)
			elseif a > 1 then
				io.write(string:sub(0,a-1))
				printLine(string:sub(a))
			elseif a == 1 then
				gpu.setForeground(tonumber("0x" .. string:sub(2,7)))
				string = string:sub(7+1)
				printLine(string)
			end
		else
			gpu.setForeground(0xffffff)
			return true
		end
	end

	local i = 0
	for k,v in pairs(array) do
		term.setCursor(x,y+i)
		printLine(v)
		i = i+1
	end
end
function showHelp()
	local x = math.floor((screenWidth-c.helpWidth)/2)
	local y = 3
	
	drawWindow(x,y,c.helpWidth,c.helpHeight+1)
	drawText(x+2,y+1,helpStrings)

	while true do
		local evt,_,X,Y,_,NAME = event.pull("touch")
		--if masters[NAME] then
			gpu.fill(x,y,c.helpWidth+1,c.helpHeight-y+2," ")
			break
		--end
	end
end

function placeButtons()
	local i = 1
	for index,this in pairs(timers) do
		local pausedStatus = ""
		local pausedColor
		local delaySubstitute
		local delayColor = c.delayColorDef
		local msgColor = c.buttonFgDef
		local broadcastAndListenColor = c.buttonFgDef
		local broadcastAndListenOutline = c.buttonOutlineDef
		if this.paused == true then
			pausedStatus = c.pausedText
			pausedColor = c.pausedColor
		else
			if this.msg == "" or this.repeatDelay == math.huge then
				pausedStatus = c.unpausedText
				pausedColor = c.unpausedInactiveColor
			else
				pausedStatus = c.unpausedText
				pausedColor = c.unpausedColor
			end
		end
		if this.repeatDelay == math.huge then
			delaySubstitute = "INF"
			delayColor = c.delayColorInf
		else
			delaySubstitute = tostring(this.repeatDelay)
		end
		if this.msg == "" then
			broadcastAndListenColor = c.disabledColor
			broadcastAndListenOutline = c.disabledColor
		end
	
		

		local delayString = c.delayButtonString .. string.rep(" ",math.floor((unicode.len(c.delayButtonString)/2)-(unicode.len(delaySubstitute)/2))-1) .. delaySubstitute
		delayString = delayString .. string.rep(" ",c.maxwidth_repeatDelay-unicode.len(delayString)-buttonOutlineDefStartLength-buttonOutlineDefEndLength)

		local idString = "id: "

		if string.len(tostring(this.id)) == 1 then
			idString = idString .. " " .. tostring(this.id)
		else
			idString = idString .. tostring(this.id)
		end

		addButton(c.offset_delete,i,c.removeButtonString,c.removeColor,nil,0xFF0000,nil,removeBroadcast,index,c.offset_delete,i)
		addButton(c.offset_listen,i,"listen",broadcastAndListenColor,nil,broadcastAndListenOutline,nil,listen,this.msg)
		addButton(c.offset_paused,i,pausedStatus,pausedColor,nil,pausedColor,nil,switchPauseStatus,index)
		addButton(c.offset_id,i,idString,c.idColor,nil,c.idColor,c.maxwidth_id)
		addButton(c.offset_repeatDelay,i,delayString,delayColor,nil,nil,c.maxwidth_repeatDelay,editDelay,c.offset_repeatDelay,i,index) -- "delay: " .. tostring(this.repeatDelay) also used before to count len
		addButton(c.offset_edit1,i,"chat edit",nil,nil,nil,c.maxwidth_edit1,editMsgThroughChat,c.offset_edit1,i,index)
		addButton(c.offset_broadcast,i,"broadcast",broadcastAndListenColor,nil,broadcastAndListenOutline,nil,buttonBroadcast,index)
		local label = getButtonLabel(index)
		if label == "" then
			msgColor = c.pausedColor
			label = "n/a"
		end
		addButton(c.offset_text,i,label,msgColor,nil,c.buttonOutlineDef,c.maxwidth_text,editMsg,c.offset_text,i,index)
		i = i+1
	end

	addButton(1,screenHeight,"+ new broadcast",nil,nil,nil,nil,buttonAddBroadcast)
	addButton(19,screenHeight,"show help",nil,nil,nil,nil,showHelp)
	addButton(31,screenHeight,"reboot",nil,nil,nil,nil,buttonReboot)
	addButton(40,screenHeight,"change name",nil,nil,nil,nil,buttonChangeName,40,screenHeight)
end
function clearButtons()
	buttons = {}
end
function buttonChangeName(x,y)
	gpu.set(x+1,y,string.rep(" ",11))
	term.setCursor(x+1,y)
	local param = {dobreak = false}
	local newName = term.read(param)
	if newName ~= nil and newName ~= "" then
		newName = newName:sub(0,-2)
		newName = newName:gsub("&","§")

		if newName:find("§") == nil then
			newName = "§7" .. newName
		end
		name2 = "§8[§bBarapad§8]§a " .. newName .. "§f: "
		saveName2()
	end
end


function pauseAllOnStart()
	for index,this in pairs(timers) do
		if this.paused == false then
			timers[index].paused = true
			timers[index].id = 0
		end
	end
end

term.clear()
pauseAllOnStart()
draw(buttons)
while true do
	placeButtons()
	draw()
	getEvent()
	ioSave()
	clearButtons()
end
