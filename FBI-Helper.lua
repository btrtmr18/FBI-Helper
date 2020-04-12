require 'lib.moonloader'
require 'lib.sampfuncs'
local lsg, sf = pcall(require, 'sampfuncs')
local lkey, key = pcall(require, 'vkeys')
local imgui = require 'imgui'
encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
lsampev, sampev = pcall(require, 'lib.samp.events')
local dlstatus = require('moonloader').download_status

script_version("1.1")

function update()
  local fpath = os.getenv('TEMP') .. '\\testing_version.json' -- куда будет качаться наш файлик для сравнения версии
  downloadUrlToFile('https://raw.githubusercontent.com/btrtmr18/FBI-Helper/master/checkupdate', fpath, function(id, status, p1, p2) -- ссылку на ваш гитхаб где есть строчки которые я ввёл в теме или любой другой сайт
    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
    local f = io.open(fpath, 'r') -- открывает файл
    if f then
      local info = decodeJson(f:read('*a')) -- читает
      updatelink = info.updateurl
      if info and info.latest then
        version = tonumber(info.latest) -- переводит версию в число
        if version > tonumber(thisScript().version) then -- если версия больше чем версия установленная то...
          lua_thread.create(goupdate) -- апдейт
        else -- если меньше, то
          update = false -- не даём обновиться
          sampAddChatMessage(('[Testing]: У вас и так последняя версия! Обновление отменено'), color)
        end
      end
    end
  end
end)
end
--скачивание актуальной версии
function goupdate()
sampAddChatMessage(('[Testing]: Обнаружено обновление. AutoReload может конфликтовать. Обновляюсь...'), color)
sampAddChatMessage(('[Testing]: Текущая версия: '..thisScript().version..". Новая версия: "..version), color)
wait(300)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23) -- качает ваш файлик с latest version
  if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
  sampAddChatMessage(('[Testing]: Обновление завершено!'), color)
  thisScript():reload()
end
end)
end

-- ВСЁ!

-------------------- Основные цвета --------------------
local script_color = 0x1284c4
local default_color = 'FFFFFF'
local select_color = 'FFFF00'
--------------------------------------------------------

--умный розыск------
local suspect = {
	{
	title = "{ff0000}Статья 1: \t{ffffff}Запугивание",
	submenu = {
		{
		title = "{ff0000}Часть 1: {ffffff}Устрашение человека в том, что ему будет причинен физический вред или смерть,\nтем самым заставляя его бояться за свою жизнь. (1 у.р.)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: {ffffff}Нападение на должностное лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 2: \t{ffffff}Вооруженное нападение",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Нападение на гражданское лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 6 2.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Нападение на должностное лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 6 2.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 3: \t{ffffff}Угон",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Попытка угона",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 3.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Угон",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 3.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 4: \t{ffffff}Взятка",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Предложение взятки",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 4.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Взятие взятки",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 4.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 5: \t{ffffff}Оружие",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Ношение оружия в открытом виде",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 5.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Ношение оружия без лицензии",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 5.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 3: \t{ffffff}Нелегальная продажа оружия",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 4 5.3 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 4: \t{ffffff}Нелегальная покупка оружия",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 4 5.4 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 6: \t{ffffff}Взятие в заложники (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 6 6.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 7: \t{ffffff}Терроризм",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Планирование, либо исполнение теракта",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 6 7.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}За заведомо ложное сообщение о теракте",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 7.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 8: \t{ffffff}Соучастие в преступной деятельности",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Соучастие в преступлении",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 4 8.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Помеха работе МВД",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 8.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 9: \t{ffffff}Неподчинение МВД / Отказ от выплаты штрафа",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Неподчинение",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 9.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Отказ/невозможность выплаты штрафа",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 9.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 10: \t{ffffff}Проникновение на территорию (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 10.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 11: \t{ffffff}Наркотические средства / ДТП",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Хранение наркотиков",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 5 11.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Нелегальная продажа наркотиков",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 5 11.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Покидание места ДТП (АК)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 11.2 АК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 3: \t{ffffff}Нелегальное употребление наркотиков",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 11.3 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 3: \t{ffffff}Умышленное создание ДТП (АК)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 11.3 АК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 12: \t{ffffff}Использование предметов гос. важности",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Подделка документов",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 12.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Ношение формы гос. служащего (не состоя в организации)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 12.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 13: \t{ffffff}Хулиганство (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 13.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 14: \t{ffffff}Шантаж (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 4 14.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 15: \t{ffffff}Оскорбление, либо использование брани (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 15.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 16: \t{ffffff}Отказ от предоставления документов (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 16.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 17: \t{ffffff}Бандитизм",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Ограбление",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 17.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Вымогательство",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 17.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 3: \t{ffffff}Угрозы",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 17.3 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 18: \t{ffffff}Национализм (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 4 18.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 19: \t{ffffff}Бунты и митинги",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}За создание или участие в бунтах или митингах",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 4 19.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Вооруженный мятеж",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 6 19.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 20: \t{ffffff}Шпионаж (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 6 20.1 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Глава 21: \t{ffffff}Преступление против половой свободы",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Изнасилование",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 5 21.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Развратные действия",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 21.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 3: \t{ffffff}Проституция",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 21.3 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 22: \t{ffffff}Ложь и клевета",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Умышленное обвинение непричастного",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 2 22.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Заведомо ложный вызов полиции",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 1 22.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 23: \t{ffffff}Срыв мероприятия",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Срыв мероприятиятий",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 23.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Агрессивные противоправные действия на мероприятиях",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 23.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 24: \t{ffffff}Кража гос. имущества",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Кража патронов и формы",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 24.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Продажа гос. имущества",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 4 24.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 1: \t{ffffff}Нападение",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Нападение на гражданское лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Нападение на должностное лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 1: \t{ffffff}Нападение",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Нападение на гражданское лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Нападение на должностное лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 1: \t{ffffff}Нападение",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Нападение на гражданское лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Нападение на должностное лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 1: \t{ffffff}Нападение",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Нападение на гражданское лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Нападение на должностное лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 1: \t{ffffff}Нападение",
	submenu = {
		{
		title = "{ff0000}Статья 1: \t{ffffff}Нападение на гражданское лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Статья 2: \t{ffffff}Нападение на должностное лицо",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 3 1.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Глава 25: \t{ffffff}Следствие (статья 1)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК и ввёл нужные данные')
			sampSendChat(string.format('/su %s 6 69.1 УК', umniy_rozisk))
		end
	}
}
--------------------


function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
        while not isSampAvailable() do wait(100) end
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}Скрипт успешно запущен и готов к работе. Разработчик: Timur//.", 0x1284c4)
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}Для ознакомления с информацией и функционалом скрипта введите команду /fhelper.", 0x1284c4)

				sampRegisterChatCommand("cuf", cmd_cuff) -- /cuff
				sampRegisterChatCommand("udost", cmd_udost) -- /udost


        while true do
        wait(0)

				if isKeyDown(VK_RBUTTON) and isKeyJustPressed(VK_T) then
					local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
					if valid and doesCharExist(ped) then
						local result, id = sampGetPlayerIdByCharHandle(ped)
						if result then
						sampShowDialog(543, "{FFFF00}FBI-Helper", "Объявить в розыск\nНадеть наручники\nСнять наручники\nПосадить в машину\nПроизвести обыск\nПотащить перед собой", "Выбрать", "Закрыть", sf.DIALOG_STYLE_LIST)
						if sampIsDialogActive() then
							while sampIsDialogActive() do
								wait(0)
								local dlgresult, dlgbutton, dlglist, dlginput = sampHasDialogRespond(543)
								if dlgresult then
									if dlgbutton == 1 then
										if dlglist == 0 then
											umniy_rozisk = id
											submenus_show2(suspect, '{00ff00}Police Menu | Объявить в розыск')
										elseif dlglist == 1 then
											if IPC(id) then
												sampSendChat('/me протянула правую руку к поясу, аккуратно сняла наручники, после чего поднесла их к рукам '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ..');
												sampSendChat('/do .. стянула наручники, тем самым схлопнув их вместе, закрепила наручники.'); wait(1500)
												sampSendChat('/cuff '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 2 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(uncuffID), '_', ' ')
												sampSendChat('/me протянула руку вперед, расстегнула наручники '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.'); wait(1500)
												sampSendChat('/me сняла наручники с рук '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', затем повесила их на пояс.'); wait(1500)
												sampSendChat('/uncuff '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 3 then
											if IPC(id) then
												sampSendChat('/me схватила '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', после чего потащила его в сторону автомобиля.'); wait(1500)
												sampSendChat('/me открыла дверь автомобиля, после чего усадила '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' внутрь, затем закрыла дверь.'); wait(1500)
												sampSendChat('/putpl '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 4 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me засунула руки в карман, достала пару резиновых перчаток, натянула их на руки.'); wait(1500)
												sampSendChat('/anim 16'); wait(500)
												sampSendChat('/me вытянула руку перед собой, начала обшлёпывать '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' по верхним частям тела.'); wait(1500)
												sampSendChat('/anim 14'); wait(500)
												sampSendChat('/me наклонилась, начала обыскивать нижние части тела '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.')
												sampSendChat('/search '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 5 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me схватила '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' и потащила его перед собой.'); wait(1500)
												sampSendChat('/hold '..id)
											else
												SCM('Игрок не подключен.')
											end
										end
									end
								end
							end
						end
						end
					end
				end

			end
		end

		function cmd_cuff(param)
		    id = string.match(param, "(.+)")
		    if id ==nil or id == "" then
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Используйте команду: /cuf [ID].", script_color)
		    else
					lua_thread.create(function()
		        sampSendChat("/me протянул правую руку к поясу, аккуратно снял наручники, после чего поднёс их к рукам "..string.gsub(sampGetPlayerNickname(id),'_',' ').." ..."); wait(1500)
		        sampSendChat("/do ... стянул наручники, тем самым схлопнув их вместе, закрепил наручники."); wait(500)
						sampSendChat("/cuff "..id); wait(500)
		    end)
			end
		end

		function cmd_udost()
			lua_thread.create(function()
			sampSendChat("/me достала удостоверение из кармана, после показала его"); sampSendChat("/anim 21")
			wait(1500)
			sampSendChat('/do Удостоверение: Федеральное Бюро Расследований.'); wait(500)
			sampSendChat('/do Удостоверение: Сотрудник: Dana Scully | Должность: Head of Department.'); wait(500)
			sampSendChat('/do Удостоверение: Личный номер: 19-055-75 | Пол сотрудника: Женский.'); wait(500)
		end)
	end

	-- ======================================================================

	function IPC(id) -- аналог sampIsPlayerConnected()
		local getptest, getpid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		if getptest then
		if sampIsPlayerConnected(id) or tonumber(id) == tonumber(getpid) then
			return true
		else
			return false
		end
		else
			return false
		end
	end

	function SCM(text)
		sampAddChatMessage(message_script .. text, script_color)
	end

	function submenus_show(menu, caption, select_button, close_button, back_button) -- menus
	    select_button, close_button, back_button = select_button or 'Выбрать', close_button or 'Закрыть', back_button or 'Назад'
	    prev_menus = {}
	    function display(menu, id, caption)
	        local string_list = {}
	        for i, v in ipairs(menu) do
	            table.insert(string_list, type(v.submenu) == 'table' and v.title or v.title)
	        end
	        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
	        repeat
	            wait(0)
	            local result, button, list = sampHasDialogRespond(id)
	            if result then
	                if button == 1 and list ~= -1 then
	                    local item = menu[list + 1]
	                    if type(item.submenu) == 'table' then
	                        table.insert(prev_menus, {menu = menu, caption = caption})
	                        if type(item.onclick) == 'function' then
	                            item.onclick(menu, list + 1, item.submenu)
	                        end
	                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
	                    elseif type(item.onclick) == 'function' then
	                        local result = item.onclick(menu, list + 1)
	                        if not result then return result end
	                        return display(menu, id, caption)
	                    end
	                else
	                    if #prev_menus > 0 then
	                        local prev_menu = prev_menus[#prev_menus]
	                        prev_menus[#prev_menus] = nil
	                        return display(prev_menu.menu, id - 1, prev_menu.caption)
	                    end
	                    return false
	                end
	            end
	        until result
	    end
	    return display(menu, 31337, caption or menu.title)
	end

	function submenus_show2(menu, caption, select_button, close_button, back_button) -- menus
	    select_button, close_button, back_button = select_button or 'Выбрать', close_button or 'Закрыть', back_button or 'Назад'
	    prev_menus = {}
	    function display(menu, id, caption)
	        local string_list = {}
	        for i, v in ipairs(menu) do
	            table.insert(string_list, type(v.submenu) == 'table' and v.title or v.title)
	        end
	        sampShowDialog(id, caption, 'Нумерация\tНазвание\n' .. table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_TABLIST_HEADERS)
	        repeat
	            wait(0)
	            local result, button, list = sampHasDialogRespond(id)
	            if result then
	                if button == 1 and list ~= -1 then
	                    local item = menu[list + 1]
	                    if type(item.submenu) == 'table' then
	                        table.insert(prev_menus, {menu = menu, caption = caption})
	                        if type(item.onclick) == 'function' then
	                            item.onclick(menu, list + 1, item.submenu)
	                        end
	                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
	                    elseif type(item.onclick) == 'function' then
	                        local result = item.onclick(menu, list + 1)
	                        if not result then return result end
	                        return display(menu, id, caption)
	                    end
	                else
	                    if #prev_menus > 0 then
	                        local prev_menu = prev_menus[#prev_menus]
	                        prev_menus[#prev_menus] = nil
	                        return display(prev_menu.menu, id - 1, prev_menu.caption)
	                    end
	                    return false
	                end
	            end
	        until result
	    end
	    return display(menu, 31337, caption or menu.title)
	end

	function strobes()
		if (isCharInAnyCar(PLAYER_PED) and enablestr == false) then
			enablestr = true
			SCM('Стробоскопы активированы.')
			lua_thread.create(function()
				vehptr = getCarPointer(storeCarCharIsInNoSave(PLAYER_PED)) + 1440
				while enablestr do
						callMethod(7086336, vehptr, 2, 0, 0, 0)
						callMethod(7086336, vehptr, 2, 0, 1, 1)
						callMethod(7086336, vehptr, 2, 0, 3, 0)
						wait(200)
						callMethod(7086336, vehptr, 2, 0, 0, 1)
						callMethod(7086336, vehptr, 2, 0, 1, 0)
						callMethod(7086336, vehptr, 2, 0, 3, 1)
						wait(200)
				end
				callMethod(7086336, vehptr, 2, 0, 0, 0)
				callMethod(7086336, vehptr, 2, 0, 1, 0)
				callMethod(7086336, vehptr, 2, 0, 3, 0)
			end)
		else
			SCM('Стробоскопы деактивированы.')
			enablestr = false
		end
	end
