local c = require('component')
local u = require('unicode')
local t = require('term')
local e = require('event')
local shell = require('shell')
local g = c.gpu
local color = g.setForeground
component.chat_box.getDistance(100)
local cb = component.chat_box
local BOT_NAME = " §8Оликсандр §f>> " --Преффикс и имя бота
 
local w,h = 72,11 -- разрешение экрана
local outer = 1 -- отступ от строк
 
local frases = { -- таблица с фразами и цветовой разметкой
    '&c ОвечкаШОП',
	'&fСовершенно новый, обновленный Магазин!',
	'',
	'&cВ нашем магазине вы можете найти очень разные товары,',
  '&bОт ванильной земельки, до предметов из мода IC2!',
  ''
	'&eМы очень рады каждому покупателю, и будем рады еще больше',
	'&eЕсли вы будете посещать нас очень часто, и закупаться у нас!',
  '',
  '&cАдминистрация варпа: &5Muronuch, &aBarawik_, &7TuskT',
	}
 
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
 
function printFormatText(x,y,text)
    local crit = '&'
    local corr = 0
    for i = 1, u.len(text) do
        local letter = u.sub(text,i,i)
        if letter == crit then
            pcall(colorsTable[u.sub(text,i,i+1):lower()])
            corr = corr + 2
            skip = true
        else
            if not skip then
                g.set(x+i-corr,y,letter)
            end
            skip = false
        end
    end
end
 
function getX(frase)
    local len = u.len(frase:gsub('&.',''))
    local x = w/2 - len/2
    return math.floor(x)
end

t.clear()
g.setResolution(w,h)

for i = 1, #frases do
    local frase = frases[i]
    printFormatText(getX(frase),outer*i,frase)
end


function func()
 cb.say(BOT_NAME..COLOR8.."§c/warp magaz§7 - тот варп, который является первым ТРЦ сервера. Спасибо что вы остаетесь со мной. ")
end
 
local t = e.timer(1,func,math.huge)

function reclama( )
    cb.say(BOT_NAME..COLOR5.."§c>| §bПроплаченная реклама §c|<")
    cb.say(BOT_NAME..COLOR8.."§d^_^ §6/warp magaz§7 - трц, ценится огромезной и продуманностью продажи товаров по минимальным ценам. §fВозможность совершения заказов, есть стрельба на 2 этаже. Прочувствуйте всю любовь барашков §d❤:3")
end

local t = e.timer(5, reclama, math.huge) 

t.clear()
