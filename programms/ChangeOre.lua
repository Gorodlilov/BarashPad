--===========================
-- Powered by serfaim7
-- Redisigned by Gorodlilov
--===========================

local items = { -- множитель, название руды, забираем руду, dmg, отдаём слиток, dmg, название слитка, ore_dictionary
  {"3","Дракониевая руда","DraconicEvolution:draconiumOre","0","DraconicEvolution:draconiumDust","0","Дракониевая пыль","dustDraconium"},
  {"2","Алмазная руда","minecraft:diamond_ore","0","minecraft:diamond","0","Алмаз","gemDiamond"},
  {"2","Изумрудная руда","minecraft:emerald_ore","0","minecraft:emerald","0","Изумруд","gemEmerald"},
  {"2","Золотая руда","minecraft:gold_ore","0","minecraft:gold_ingot","0","Золотой слиток","ingotGold"},
  {"2","Железная руда","minecraft:iron_ore","0","minecraft:iron_ingot","0","Железный слиток","ingotIron"},
  {"2","IC2 Медная руда","IC2:blockOreCopper","0","IC2:itemIngot","0","Медный слиток","ingotCopper"},
  {"2","IC2 Оловянная руда","IC2:blockOreTin","0","IC2:itemIngot","1","Оловяный слиток","ingotTin"},
  {"2","IC2 Свинцовая руда","IC2:blockOreLead","0","IC2:itemIngot","5","Свинцовый слиток","ingotLead"},
  {"2","TE Медная руда","ThermalFoundation:Ore","0","ThermalFoundation:material","64","Медный слиток","ingotCopper"},
  {"2","TE Оловянная руда","ThermalFoundation:Ore","1","ThermalFoundation:material","65","Оловяный слиток","ingotTin"},
  {"2","TE Никелевая руда","ThermalFoundation:Ore","4","ThermalFoundation:material","68","Никелевый слиток","ingotNickel"},
  {"2","TE Серебряная руда","ThermalFoundation:Ore","2","ThermalFoundation:material","66","Серебряный слиток","ingotSilver"},
  {"2","TE Платиновая руда","ThermalFoundation:Ore","5","ThermalFoundation:material","69","Платиновый слиток","ingotPlatinum"},
  {"2","Руда истинного кварца","appliedenergistics2:tile.OreQuartz","0","appliedenergistics2:item.ItemMultiMaterial","0","Истинный кварц","crystalCertusQuartz"},
  {"3","Кварцевая руда","minecraft:quartz_ore","0","minecraft:quartz","0","Кварц","gemQuartz"},
  {"8","Лазуритовая руда","minecraft:lapis_ore","0","minecraft:dye","4","Лазурит","dye"},
  {"8","Красная руда","minecraft:redstone_ore","0","minecraft:redstone","0","Красная пыль","dustRedstone"},
  {"2","Угольная руда","minecraft:coal_ore","0","minecraft:coal","0","Уголь","coal"}
}
 
local unicode = require("unicode")
local com = require("component")
local shell = require("shell")
local fs = require("filesystem")
if not fs.exists("/lib/Bar.lua") then
	shell.execute("wget https://raw.githubusercontent.com/BarawikS/BarashPad/master/Barlib.lua /lib/Bar.lua")
end
local Bar = require("Bar")
local interface = com.isAvailable("me_interface") and com.me_interface or error("нет ме интерфейса")
local db = com.isAvailable("database") and com.database or error("нет базы данных")
local chest = com.isAvailable("chest") and com.chest or error("нет сундука")
local size = chest.getInventorySize()
local gpu = com.gpu
local w, h = gpu.getResolution()
local net_count,line_count = 0,0
 
local function declension(number)
  local dec = ""
  local rest = number % 10
  local str = string.sub(number,string.len(number)-1)
  if str == "11" or str == "12" or str == "13" or str == "14" then
    dec = " слитков"
  elseif rest == 1 then
    dec = " слиток"
  elseif rest == 2 or rest == 3 or rest == 4 then
    dec = " слитка"
  else
    dec = " слитков"
  end
  return number..dec
end
 
local function center(coord,text,color)
  gpu.setForeground(color)
  gpu.set(math.floor(w/2-unicode.len(text)/2),coord,text)
end
 
local function color_text(w,line,text,color)
  gpu.setForeground(color)
  gpu.set(w,line,text)
end
 
local function print_items()
  local line,size,fill = 3,0,true
  local network = interface.getItemsInNetwork()
  for ind = 1,#items do
    for net = 1,#network do
      if network[net].name == items[ind][5] then
        if network[net].damage == tonumber(items[ind][6]) then
          if network[net].size >= tonumber(items[ind][1]) then
            if #network ~= net_count then
              if fill then
                gpu.fill(1,1,w,h," ")
                fill = not fill
              end
              color_text(5,line,items[ind][2],0x00FF00)
              color_text(28,line,"1",0xFF00FF)
              color_text(30,line,"-->",0xFFFF00)
              color_text(34,line,"X "..items[ind][1],0xFF00FF)
              color_text(42,line,items[ind][7],0x00FF00)
              color_text(63,line,"доступно",0xFFFF00)
              color_text(73,line,tostring(network[net].size),0xFF00FF)
              color_text(3,line+1,string.rep("─",76),0xFFFFFF)
              size = size + network[net].size
            else
              size = size + network[net].size
              color_text(73,line,tostring(network[net].size.."   "),0xFF00FF)
            end
            line = line + 2
          end
        end
      end
    end
  end
  net_count = #network
  if line == 3 or line ~= line_count then
    net_count = 0
  end
  line_count = line
  gpu.fill(1,1,w,1," ")
  if size > 0 then
    center(1,"обмен руды, всего доступно "..declension(size),0xFFFF00)
  else
    gpu.fill(1,1,w,h," ")
    center(h/2,"обменник руды пустой",0xFF0000)
  end
end
 
local function pushItem(name,count,label)
  db.clear(1)
  interface.store(name,db.address,1)
  interface.setInterfaceConfiguration(1,db.address,1,64)
  local drop = 0
  while true do
    if drop == count then
      interface.setInterfaceConfiguration(1,db.address,1,0)
      net_count = 0
      break
    else
      local dropcount = interface.pushItem("UP",1,count-drop)
      drop = drop + dropcount
      if dropcount == 0 then
        gpu.fill(1,1,w,h," ")
        center(h/2,"освободите место в сундуке",0xFF0000)
        center(h/2+2,"Ожидаю выдать "..label,0xFFFFFF)
        center(h/2+4,"всего "..count-drop,0xFFFFFF)
        os.sleep(1)
      end
    end
  end
end
 
local function exchange_ore_dict()
  local ore_dict,item_count = "",false
  local data = chest.getAllStacks(0)
  for slot = 1,size do
    if data[slot] then 
      for ind = 1,#items do
        if data[slot].id == items[ind][3] then
          if data[slot].dmg == tonumber(items[ind][4]) then
            ore_dict = items[ind][8]
            break
          end
        end
      end
      local network = interface.getItemsInNetwork()
      for ind2 = 1,#items do
        if ore_dict == items[ind2][8] then
          local ore = items[ind2][5]
          local dmg = items[ind2][6]
          local ore_name = items[ind2][2]
          for net = 1,#network do
            if network[net].name == ore then
              if network[net].damage == tonumber(dmg) then
                if network[net].size >= tonumber(items[ind2][1]) then  
                  item_count = chest.pushItem("DOWN",slot,(network[net].size/items[ind2][1]))
                  local drop_count = item_count*items[ind2][1]
                  local ingot_name = items[ind2][7]
                  gpu.fill(1,1,w,1," ")
                  center(1,"Меняю  "..item_count.."  "..ore_name.."  на  "..drop_count.."  "..ingot_name,0xFFFFFF)
                  pushItem({name = ore,damage = tonumber(dmg)},drop_count,ingot_name)
                  break
                end
              end
            end
          end
          if item_count then
            item_count = false
            ore_dict = ""
            break
          end
        end
      end
    end
  end
end
 
gpu.fill(1,1,w,h," ")
gpu.setResolution(80,h)
while true do
  print_items()
  exchange_ore_dict()
  os.sleep(0.5)
end
