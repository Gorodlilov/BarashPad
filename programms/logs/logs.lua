local a=require('component')
local b=require('computer')
local c=require('event')
local d=require('term')
local e=require('unicode')
local f=a.gpu;
local g=a.isAvailable;
local h='\n'
local k={}
local l,m=f.getResolution()
local n={general=0x00ff45,text=0xCCCCCC,white=0xFFFFFF,red=0xFF0000,black=0x000000}
io.write('Введите дату для поиска (Пример: 01-08): ')
local date=io.read()
local j='https://logs.s8.mcskill.ru/Islandcraft/'..date..'-2019.txt'
function input()
f.setForeground(n.general)

if string.find(date, "-01") then
	data = date:gsub('-01', "января")
elseif string.find(date, "-02") then
	data = date:gsub('-02', "февраля")
elseif string.find(date, "-03") then
	data = date:gsub('-03', "марта")
elseif string.find(date, "-04") then
	data = date:gsub('-04', "апреля")
elseif string.find(date, "-05") then
	data = date:gsub('-05', "мая")
elseif string.find(date, "-06") then
	data = date:gsub('-06', "июня")
elseif string.find(date, "-07") then
	data = date:gsub('-07', "июля")
elseif string.find(date, "-08") then
	data = date:gsub('-08', "августа")
elseif string.find(date, "-09") then
	data = date:gsub('-09', "сентября")
elseif string.find(date, "-10") then
	data = date:gsub('-10', "октября")
elseif string.find(date, "-11") then
	data = date:gsub('-11', "ноября")
elseif string.find(date, "-12") then
	data = date:gsub('-12', "декабря")
else
	io.write('Неправильно введен месяц!')
	os.exit()
end

io.write('> Поиск в логах сервера ТМСБ за '..data..'. Команды: info, exit: ')
local y=io.read()
return tostring(y):gsub('[[%]]+',''):gsub('%%','')
end;
function check(o)
findCounter=0;
breakSearch=false;
for p in i.request(j) do 
local q=1;
local p=h..p..h;
for r in p:gmatch(o) do 
	local s,t=p:find(o,q)
	local u=p:find(h,s)
	local v=p:sub(1,u-1)
	local w=v:reverse()
	local x=w:find(h)
	local y=w:sub(1,x-1):reverse():gsub('%d+m',''):gsub('%d+;',''):gsub('',''):gsub('[[%]]+',''):gsub(o,'§a'..o..'§7'):gsub('m$','')
	q=t;
	findCounter=findCounter+1;
	chat.say(y)
	end;
	if breakSearch then 
	break 
end end end;
function setText(z,A)
f.setForeground(A)
print(z)
f.setForeground(n.general)
end;
function keysController(r,r,r,B)
	if B==16 then 
	breakSearch=true 
	end 
end;
function run()
	if g('chat') then 
		chat=a.chat 
	else 
		chat=a.chat_box 
	end;
i=require('internet')
chat.setName('§r§aServerLogs§7§o')
c.listen('key_down',keysController)
d.clear()
while true do 
	local C=input()
	if C=='exit' then 
	break 
	elseif C=='info' or C=='INFO' then 
		setText('\nINFO: Для удобства все найденные серверные логи отправляются в локал чат через чатбокс в отдельный канал "ServerLogs". Если у вас автоматически не появляется данный канал, зайдите в настройки TabbyChat (шифт + лкм на канале [*]) и во вкладке "Сервер" поставьте галочку на пункте "Авто поиск новых каналов". Также во вкладке "Дополнительно" увеличте историю чата до 999...\n',n.text)
	elseif e.len(C)<=3 then 
		setText('Запрос должен быть больше 3 символов!\n',n.red)
	else 
		setText('Ищу "'..C..'" в логах сервера и вывожу в локал чат... Нажать "Q" для отмены',n.text)
		chat.say('Поиск "§a'..C..'§7" в логах сервера...')
		check(C)
		chat.say('Найдено §a'..findCounter..'§7 совпадений.')
		setText('Найдено '..findCounter..' совпадений. Отправлены в локал чат!\n',n.text)
	end
end;
exit()
end;
function start()
	if f.getDepth()==1 then 
		print('Ошибка! Монитор и видеокарта 1 тира не поддерживаются.')
	elseif not g('internet') then 
		print('Ошибка! Интернет карта не найдена.')
	elseif not(g('chat_box') or g('chat')) 
		then print('Ошибка! Чатбокс не найден.')
	else 
		run()
	end 
end;
function exit() 
	c.ignore('key_down',keysController)
	f.setForeground(n.white)
	d.clear()
end;
function c.shouldInterrupt()
	return false 
end;
start()
