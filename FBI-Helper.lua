script_name('FBI-Helper')
script_author('Timur//')
script_version('1.2')

require 'lib.moonloader'
require 'lib.sampfuncs'
local lsg, sf = pcall(require, 'sampfuncs')
local lkey, key = pcall(require, 'vkeys')
local imgui = require 'imgui'
local inicfg = require "inicfg"
encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
lsampev, sampev = pcall(require, 'lib.samp.events')
local dlstatus = require("moonloader").download_status

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

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
		title = "{ff0000}Часть 1: \t{ffffff}Устрашение человека в том, что ему будет причинен физ.вред или смерть (1 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 1 1.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Устрашение человека в том, что его близким будет причинен физ.вред или смерть (1 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 1 1.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 2: \t{ffffff}Физический вред",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Попытка или нанесение физ.вред человеку без спец.средств (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 2.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Попытка или нанесение физ.вреда другому человеку со спец.средствами (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 2.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 3: \t{ffffff}Попытка или нанесение физ.вреда сотруднику Мин.Юста (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 2.3 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 3: \t{ffffff}Покушение на убийство",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Сознательная или преднамеренная попытка убить человека или причинить тяжкий вред (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 3.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 4: \t{ffffff}Убийство",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Умышленное причинение смерти человеку (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 4.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Соучастие в умышленном причинении смерти человеку (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 4.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 5: \t{ffffff}Похищение и удержание в заложниках",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Умышленное лишение человека свободы против его воли с корыстной целью или без (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 5.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Умышленное удержание человека в заложниках с корыстной целью или без (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 5.2 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 6: \t{ffffff}Пытка",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Причинение боли и страдания человеку с целью мести, вымогательства, убеждения и т.п. (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 6.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 7: \t{ffffff}Оставление в опасности или не оказание помощи нуждающемуся",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Намеренный отказ оказать мед.помощь нуждающемуся/помочь нуждающемуся (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 7.1 УК', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}Статья 8: \t{ffffff}Поджог",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Умышленное и злонамеренное совершение/попытка совершения поджога частного имущества (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 8.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Умышленное и злонамеренное совершение/попытка совершения поджога гос. или мун-го имущества (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 8.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 9: \t{ffffff}Проникновение",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Проникновение в чужую частную собственность, пока она закрыта или не работает без разрешения на это (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 9.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Проникновение в чужую частную собственность, если владелец запрещает (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 9.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 10: \t{ffffff}Проникновение на государственную собственность",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Проникновение без спец.разрешения на территорию любой гос. собственности (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 10.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Проникновение без спец.разрешения на территорию любой гос. собственности, с целью кражи имущества (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 10.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 3: \t{ffffff}Проникновение на территорию гос. учреждений и нахождения там с личным оружием (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 10.3 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 11: \t{ffffff}Кража со взломом",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Проникновение на частную собственность не имея на то разрешения от владельца, с целью совершения кражи (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 11.1 УК', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}Статья 12: \t{ffffff}Ограбление",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Завладение чужим имуществом без воли владельца, путем запугивания или применения насилия (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 12.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Завладение чужим имуществом без воли владельца, путём запугивания или применения спец.средств (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 12.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 13: \t{ffffff}Угон транспортного средства",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Незаконное проникновение или попытка незаконного проникновения в транспортное средство (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 13.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Угон или попытка угона любого транспортного средства (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 13.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 3: \t{ffffff}Незаконное проникновение или попытка незаконного проникновения в гос. транспортное средство (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 13.3 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 14: \t{ffffff}Кража огнестрельного оружия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Совершение кражи любого огнестрельного оружия, боеприпасов, или частей к нему (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 14.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 15: \t{ffffff}Получение краденного имущества",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Осознанная покупка или любое получение краденного имущества, полученного путем кражи или же грабежа (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 15.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 16: \t{ffffff}Вымогательство",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Запугивание или влияние на человека с целью получения частного имущества или же услуг (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 16.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Запугивание или влияние на человека путем использования служебного полномочия с целью получения выгоды (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 16.2 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 17: \t{ffffff}Фальсификация",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Умышленное создание/использование поддельного документа с целью обмануть/ввести в заблуждение человека или орг. (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 17.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Подделка/уничтожение номера т/с в целях экспл./сбыта т/с, использование поддельного/измененного номера (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 17.2 УК', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}Статья 18: \t{ffffff}Вандализм",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Уродование, повреждение/уничтожение имущества, принадлежащего другому лицу (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 18.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Намеренное причинение какого либо вреда гос. или мун. имуществу (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 18.2 УК', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}Статья 19: \t{ffffff}Фиктивное предпринимательство",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Манипуляции с имуществом, финансами, с целью придания правомерного владению, пользованию указанным средствам (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 19.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Создание незаконного/фиктивного предпринимательства с целью сокрытия незаконной деятельности (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 19.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 20: \t{ffffff}Контрабанда",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Незаконный ввоз/вывоз в штат любых объектов, оборот которых ограничен/находится под монополией государства (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 20.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 21: \t{ffffff}Непристойное или развратное поведение в общественных местах",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Подстрекательство/участие в действиях неадекватного или секс. характера в любом общественном месте (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 21.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Домогательство до другого человека в общественном месте (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 21.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 3: \t{ffffff}Демонстрация голого тела и гениталий как в общественном месте, так и в остальных (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 21.3 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 22: \t{ffffff}Проституция и сутенерство",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Занятие проституцией/предложение принять участие в половом акте в обмен на плату/вещи/другие услуги (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 22.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Реклама/помощь занятию проституцией, слежка за лицами, занимающимися проституцией (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 22.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Создание/содержание мест с целью распространения интимных услуг (3 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 3 22.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 23: \t{ffffff}Изнасилование",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Использование угроз о причинении физ. вреда с целью вступления в половой акт с жертвой (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 23.2 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Совершение полового акта с лицом против его воли (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 23.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 24: \t{ffffff}Взяточничество",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Предложение/передача оказания каких-либо услуг по отношению к гос. лицам с целью повлиять на их решения (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 24.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Получение чего-либо со стороны гос. лица с целью предоставить какие-либо услуги (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 24.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 25: \t{ffffff}Отказ от оплаты штрафа",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Неправомерный отказ от выплаты штрафа (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 25.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 26: \t{ffffff}Судебные нарушения",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Сознательное и циничное неповиновение устному/письменному решению суда, нарушение суд. процесса (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 26.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Влияние в какой-либо форме на судью с целью неправомерного решения, или же лоббирования интересов (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 26.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 27: \t{ffffff}Нарушение правил вызова в суд",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Игнорирование или нарушение вызова в суд (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 27.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Игнорирование или нарушение официального документа, изданного судом (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 27.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 28: \t{ffffff}Дача ложной информации государственному служащему",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Дача заведомо ложной информации сотруднику Мин.Юста в ходе расследования в любом виде (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 28.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Дача заведомо ложной информации, находясь в статусе свидетеля/потерпевшего на суде (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 28.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 29: \t{ffffff}Отказ идентифицировать себя сотруднику Мин.Юста",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Отказ идентифицировать себя сотруднику Мин.Юста в любой форме (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 29.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 30: \t{ffffff}Выдача себя за государственного служащего",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Выдача себя гос. служащим в корыстных целях, что преследуют собой уголовно наказуемые результаты (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 30.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Ношение значка/формы гос.служающего не имея на то документов (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 30.2 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 31: \t{ffffff}Неподчинение гос. служащему, нарушение режима содержания",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Явная попытку помешать государственному служащему выполнять свои обязанности (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 31.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Не выполнение человеком законных распоряжений сотрудника Мин.Юста или же помеха его работе (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 31.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Избегание задержания, сопротивление аресту, побег из под стражи, побег из тюрьмы (4 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 4 31.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 32: \t{ffffff}Неправильное использование экстренной горячей линии",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Использование гос. экстренной горячей линии для корыстных целей (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 32.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 33: \t{ffffff}Фальсификация доказательств",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Уничтожение/попытка уничтожить, изменить/скрыть какие-либо доказательства (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 33.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 34: \t{ffffff}Избирательное мошенничество",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Незаконное влияние на официальные результаты голосования (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 34.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 35: \t{ffffff}Разглашение конфиденциальной информации",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Разглашение конфиденциальной информации о работе гос. органов, которая не доступна не гос. служащим (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 35.1 УК', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}Статья 36: \t{ffffff}Халатность",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Неисполнение должностных обязанностей, повлекшее причинение вреда интересам граждан, группе лиц/гос-ву (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 36.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Злоупотребление должностными полномочиями лицом, уполномоченным на выполнение функций государства (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 36.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Привлечение невиновного к ответственности/задержание без причины, незаконное освобождение от ответственности (5 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 5 36.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 37: \t{ffffff}Военные преступления",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Продажа/перевозка не на военном объекте, солдатом оружия/патронов, полученных в результате службы (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 37.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Умышленное нанесение вреда военнослужащим военному имуществу (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 37.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Самовольное оставление части без уважительных причин (2 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 2 37.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 38: \t{ffffff}Нарушение спокойствия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Создание опасной/угрожающей ситуации в общественном месте/общественной территории, частной собственности (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 38.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Использование ненормативной лексики, шума, оскорбление граждан (1 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 1 38.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Оскорбление сотрудников правоохранительных органов при исполнении (3 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 3 38.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 39: \t{ffffff}Антиконституционные действия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Отказ человека/группы лиц покинуть общественное место после требования сотрудника Мин.Юста (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 39.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Намеренное подстрекательство толпы к действиям незаконного характера (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 39.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Организация/помощь в организации незаконных собраний, шествий/митингов (3 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 3 39.3 УК', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}Часть 4: \t{ffffff}Участие в незаконных собраниях, шествиях/митингах (3 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 3 39.4 УК', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}Часть 5: \t{ffffff}Срыв согласованных собраний, шествий/митингов (3 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 3 39.5 УК', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}Часть 6: \t{ffffff}Действия, направленные на свержение действующей власти/призыв к таким действиям (6 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 6 39.6 УК', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}Часть 7: \t{ffffff}Распространение в СМИ материалов, содержащих публичные призывы к терроризму/оправдывающие её (6 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 6 39.7 УК', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}Часть 8: \t{ffffff}Распространение в СМИ сведений методах разработки/приобретения любого оружия (4 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 4 39.8 УК', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}Часть 9: \t{ffffff}Распространение в СМИ сведений методах разработки/приобретения наркоты (4 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 4 39.9 УК', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}Часть 10: \t{ffffff}Распространение в СМИ сведений о спец. средствах/тактике проведения контртеррористической операции (5 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 5 39.10 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 40: \t{ffffff}Терроризм",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Действия, причинившие вред жизни и здоровью граждан/имуществу или попытка совершения (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 40.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Совершение действий, направленных на помощь исполнение терракта (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 40.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Заведомо ложное сообщение о терракте (6 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 6 40.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 41: \t{ffffff}Преступная организация",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Создание преступной организации, с целью совершения преступления/серии преступлений (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 41.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Участие в преступной организации, совершение преступных деяний в соучастии (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 41.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Содействие преступной организации в совершении уголовных деяний (4 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 4 41.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 42: \t{ffffff}Создание военизированного формирования без лицензии президента.",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Создание военизированного формирования либо же иные действия, способствующие развитию этого (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 42.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 43: \t{ffffff}Незаконная реализация табачной и алкогольной продукции",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Продажа алкогольной и/или табачной продукции, без наличия на то специальной лицензии (2 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 2 43.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Незаконное изготовление алкогольной и/или табачной продукции без наличия на то специальной лицензии (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 43.2 УК', umniy_rozisk))
		end
	}
	}
	},
	{
	title = "{ff0000}Статья 44: \t{ffffff}Незаконное предоставление «»взрослых развлечений»",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Содержание развлекательного заведения, наличие услуг «взрослых развлечений» без наличия лицензии (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 44.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 45: \t{ffffff}Незаконное ношение маски во время совершения преступления",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Ношение маски, капюшона с целью сокрытия своего лица/отказ снять его (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 45.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 46: \t{ffffff}Преступления , связанные с использованием электронных машин",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Незаконное использование/приобретение/изготовление тех. устройств, создающих помехи средств связи/приборов (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 46.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Кибертерраризм с использованием гос.имущества (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 46.2 УК', umniy_rozisk))
		end
	}
	}
	},
	{
	title = "{ff0000}Статья 47: \t{ffffff}Незаконное владение наркотическим веществом",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Незаконное хранение/перевозка/использование наркотиков (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 47.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 48: \t{ffffff}Незаконный оборот наркотических веществ",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Незаконная продажа/попытка продажи наркотиков (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 48.1 УК', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Незаконная покупка/попытка покупки наркотиков (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 48.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Незаконный импорт на территорию штата наркотиков (5 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 5 48.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 49: \t{ffffff}Незаконное производство наркотических средств",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Производство/готовка наркотиков химическим/другими способами (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 49.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 50: \t{ffffff}Намеренное нарушение ПДД",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Умышленное нарушение ПДД с намерением нанести ущерб участникам движения (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 50.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 51: \t{ffffff}Нарушение ПДД, которое повлекло тяжкие последствия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Нарушение ПДД, в результате которого был нанесен тяжкий вред/смерть (6 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 6 51.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 52: \t{ffffff}Блокирование магистралей",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Незаконное блокирование автомобильных дорог/железнодорожных путей (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 52.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 54: \t{ffffff}Нелегальное хранение ножа",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Обладание при себе ножом/заточкой, использован в качестве орудия для порезов (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 54.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 55: \t{ffffff}Хранение нелегального огнестрельного оружия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Хранение любого огнестрельного оружия, которое было получено нелегальным путём (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 55.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 57: \t{ffffff}Нелицензированная продажа огнестрельного оружия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Нелегальная продажа любого вида огнестрел.оружия, не имея на то разрешения/лицензии (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 57.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 58: \t{ffffff}Оборот взрывоопасных веществ",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Хранение взрывоопасных/легковоспламеняющихся жидкостей/материалов, приспособленных для взрыва (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 58.1 УК', umniy_rozisk))
		end
	},
		{
		title = "{ff0000}Часть 2: \t{ffffff}Изготовление взрывоопасных/легковоспламеняющихся жидкостей/материалов, приспособленных для взрыва (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 58.2 УК', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}Часть 3: \t{ffffff}Сбыт взрывоопасных/легковоспламеняющихся жидкостей/материалов, приспособленных для взрыва (5 у.р)",
	onclick = function()
		sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
		sampSendChat(string.format('/su %s 5 58.3 УК', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}Статья 59: \t{ffffff}Хранение оружия с целью сбыта",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Хранение 4 и более целых/разобранных компонентов оружия в любой их комбинации/количестве для продажи (5 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 5 59.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 60: \t{ffffff}Демонстрирование огнестрельного оружия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Открытое ношение, прицеливание огнестрельного/пневматического оружия с целью вызывать страх и истерию (3 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 3 60.1 УК', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}Статья 61: \t{ffffff}Необоснованная стрельба из огнестрельного оружия",
	submenu = {
		{
		title = "{ff0000}Часть 1: \t{ffffff}Выстрелы из огнестрельного оружия без очевидной надобности (4 у.р)",
		onclick = function()
			sampSendChat('/me достал мобильный КПК, затем ввел нужные данные.')
			sampSendChat(string.format('/su %s 4 61.1 УК', umniy_rozisk))
		end
		}
	}
	},

}
--------------------

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
        while not isSampAvailable() do wait(100) end
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}Скрипт успешно запущен и готов к работе. Разработчик: Timur//.", 0x1284c4)
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}Для ознакомления с информацией и функционалом скрипта введите команду /fhelper.", 0x1284c4)

				autoupdate("https://raw.githubusercontent.com/btrtmr18/FBI-Helper/master/update", '['..string.upper(thisScript().name)..']: ', "тут ссылка на ваш сайт/url вашего скрипта на форуме (если нет, оставьте как в json)")

				sampRegisterChatCommand("cuf", cmd_cuff) -- /cuff
				sampRegisterChatCommand("uncuf", cmd_uncuff) -- /uncuff
				sampRegisterChatCommand("jail", cmd_arrest) -- /arrest
				sampRegisterChatCommand("udost", cmd_udost) -- /udost
				sampRegisterChatCommand("rn", function(text) if text ~= "" then sampSendChat("/r (( "..text.." ))") else sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}Правильное использование команды - /rn [текст]", 0x1284c4) end end)
				sampRegisterChatCommand("fn", function(text) if text ~= "" then sampSendChat("/f (( "..text.." ))") else sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}Правильное использование команды - /fn [текст]", 0x1284c4) end end)
				sampRegisterChatCommand("histid", cmd_histid) -- история ников по ID
				sampRegisterChatCommand("inc", cmd_putpl) -- /putpl
				sampRegisterChatCommand("usus", cmd_usus) -- Умный розыск su
				sampRegisterChatCommand("sus", cmd_suspect) -- /su
				sampRegisterChatCommand("issue", cmd_skip) -- /skip
				sampRegisterChatCommand('cc', function() ClearChat() end)
				sampRegisterChatCommand("fhelper", cmd_fhelper)
				sampRegisterChatCommand("driver", cmd_takelic)
				sampRegisterChatCommand("clear", cmd_clear)
				sampRegisterChatCommand("pul", cmd_pull)
				sampRegisterChatCommand("prava", cmd_prava)


        while true do
        wait(0)

				if  not sampIsChatInputActive() and not sampIsDialogActive() then
							if isKeyJustPressed(key.VK_END) then
								sampSendChat("/me достал пульт управления шлагбаумом, нажал на одну из кнопок.")
								sampSendChat("/open")
							end
				end

				if main_window_state.v == false then
        imgui.Process = false
        end

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
											submenus_show2(suspect, '{FFFF00}FBI Menu | Умный розыск')
										elseif dlglist == 1 then
											if IPC(id) then
												sampSendChat('/me протянул правую руку к поясу, аккуратно снял наручники, после чего поднес их к рукам '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ..');
												sampSendChat('/do .. стянул наручники, тем самым схлопнув их вместе, закрепил наручники.'); wait(1500)
												sampSendChat('/cuff '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 2 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(uncuffID), '_', ' ')
												sampSendChat('/me протянул руку вперед, расстегнул наручники '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.'); wait(1500)
												sampSendChat('/me снял наручники с рук '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', затем повесил их на пояс.'); wait(1500)
												sampSendChat('/uncuff '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 3 then
											if IPC(id) then
												sampSendChat('/me схватил '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', после чего потащил его в сторону автомобиля.'); wait(1500)
												sampSendChat('/me открыл дверь автомобиля, после чего усадил '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' внутрь, затем закрыл дверь.'); wait(1500)
												sampSendChat('/putpl '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 4 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me засунул руки в карман, достал пару резиновых перчаток, натянул их на руки.'); wait(1500)
												sampSendChat('/anim 16'); wait(500)
												sampSendChat('/me вытянул руку перед собой, начал обшлёпывать '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' по верхним частям тела.'); wait(1500)
												sampSendChat('/anim 14'); wait(500)
												sampSendChat('/me наклонился, начал обыскивать нижние части тела '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.')
												sampSendChat('/search '..id)
											else
												SCM('Игрок не подключен.')
											end
										elseif dlglist == 5 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me схватил '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' и потащил его перед собой.'); wait(1500)
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
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /cuf [id].", script_color)
		    else
					lua_thread.create(function()
		        sampSendChat("/me протянул правую руку к поясу, аккуратно снял наручники, после чего поднёс их к рукам "..string.gsub(sampGetPlayerNickname(id),'_',' ').." ..."); wait(1500)
		        sampSendChat("/do ... стянул наручники, тем самым схлопнув их вместе, закрепил наручники."); wait(500)
						sampSendChat("/cuff "..id); wait(500)
		    end)
			end
		end

		function cmd_uncuff(param)
		    id = string.match(param, "(.+)")
		    if id ==nil or id == "" then
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /uncuf [id].", script_color)
		    else
			lua_thread.create(function()
		        sampSendChat("/me протянул руку вперед, расстегнул наручники "..string.gsub(sampGetPlayerNickname(id),'_',' ').."."); wait(1500)
				sampSendChat("/me снял наручники с рук "..string.gsub(sampGetPlayerNickname(id),'_',' ').." , затем повесил их на пояс."); wait(500)
				sampSendChat("/uncuff "..id); wait(500)
		    end)
			end
		end

		function cmd_takelic(param)
		    id, pricina = string.match(param, "(.+) (.+)")
		    if id ==nil or id == "" then
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /driver [id] [причина].", script_color)
		    else
					lua_thread.create(function()
		        sampSendChat("/do Встроенная камера в очках «Overseer» зафиксировала нарушение."); wait(500)
						sampSendChat("/me достав КПК из кармана, разблокировал его и вошёл в систему."); wait(500)
						sampSendChat("/me выполнив несколько операций, анулировал права у "..string.gsub(sampGetPlayerNickname(id),'_',' ').."."); wait(500)
		        sampSendChat("/takelic "..id.." "..pricina); wait(500)
						sampSendChat("/do Права аннулированы и отсутствуют в базе данных."); wait(500)
		    end)
			end
		end

		function cmd_arrest(param)
			id = string.match(param, "(.+)")
			if id ==nil or id == "" then
				sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /jail [id].", script_color)
			else
			lua_thread.create(function()
				sampSendChat("/do На панели автомобиля установлен небольшой бортовой компьютер."); wait(1500)
				sampSendChat("/me провел пальцем по экрану, тем самым активировал работу бортового компьютера."); wait(1500)
				sampSendChat("/do В системе бортового компьютера сохранено большое множество информации."); wait(1500)
				sampSendChat("/me оформил дело [№"..id.." | "..string.gsub(sampGetPlayerNickname(id),'_',' ').."] и сохранил результат в облачном хранилище."); wait(500)
				sampSendChat("/arrest "..id); wait(500)
			end)
			end
		end

		function cmd_udost()
			lua_thread.create(function()
			sampSendChat("/me достал удостоверение из кармана, после показал его."); sampSendChat("/anim 21")
			wait(1500)
			sampSendChat('/do Удостоверение: Федеральное Бюро Расследований.'); wait(500)
			sampSendChat('/do Удостоверение: Сотрудник: Scott Ward | Должность: Head of Department.'); wait(500)
			sampSendChat('/do Удостоверение: Личный номер: 19-055-75 | Пол сотрудника: Мужской.'); wait(500)
		end)
	end

	function cmd_histid(params) -- история ников по ID
		if params:match("^%d+") then
			params = tonumber(params:match("^(%d+)"))
			if sampIsPlayerConnected(params) or myID == tonumber(params) then
				local histnick = sampGetPlayerNickname(params)
				sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Произведен поиск истории имен игрока "..string.gsub(sampGetPlayerNickname(params),'_',' ').." по ID.", script_color)
				sampSendChat("/history "..histnick)
			else
				sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Игрок с данным ID не подключен к серверу.", script_color)
			end
		else
			sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /hist [id].", script_color)
		end
	end

	function cmd_putpl(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /inc [id].", script_color)
	    else
				lua_thread.create(function()
					sampSendChat("/me схватил "..string.gsub(sampGetPlayerNickname(id),'_',' ')..", после чего потащил его в сторону автомобиля."); wait(1500)
					sampSendChat("/me открыл дверь автомобиля, после чего усадил "..string.gsub(sampGetPlayerNickname(id),'_',' ').." внутрь, затем закрыл дверь."); wait(500)
					sampSendChat("/putpl "..id); wait(500)
	    end)
		end
	end

	function cmd_usus(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /usus [id].", script_color)
	    else
				lua_thread.create(function()
					umniy_rozisk = id
					submenus_show2(suspect, '{FFFF00}FBI Menu | Умный розыск')
	    end)
		end
	end

	function cmd_suspect(param)
	    id, zvezd, pricina = string.match(param, "([0-9]+) ([0-9]+) (.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /sus [id] [кол-во звезд] [причина].", script_color)
	    else
	      lua_thread.create(function()
	        sampSendChat("/me засунул правую руку в карман, достал КПК, после включил его и ввел данные."); wait(900)
	        sampSendChat("/su "..id.." "..zvezd.." "..pricina); wait(900)
					sampSendChat("/do "..string.gsub(sampGetPlayerNickname(id),'_',' ').." объявлен в розыск по статье «"..pricina.."».")
	        end)
	    end
	end

	function cmd_skip(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /issue [id].", script_color)
	    else
				lua_thread.create(function()
	        sampSendChat("/me достав КПК из кармана, разблокировал его и вошёл в систему."); wait(1500)
	        sampSendChat("/me введя нужные данные, заблокировал КПК и убрал его в карман."); wait(500)
					sampSendChat("/skip "..id); wait(500)
	    end)
		end
	end

	function cmd_prava()
		lua_thread.create(function()
				sampSendChat("Вы арестованы и имеете право хранить молчание."); wait(2000)
				sampSendChat("Всё, что вы скажете, может ужесточить наказание."); wait(2000)
				sampSendChat("Кроме этого, вы имеете право воспользоваться услугами адвоката."); wait(2000)
				sampSendChat("Если Вы не местный, то у Вас есть право на присутствие представителя Вашей страны."); wait(2000)
				sampSendChat("Вы имеете право на совершение одного телефонного звонка.")
	end)
	end

	function cmd_pull(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /pul [id].", script_color)
	    else
				lua_thread.create(function()
					sampSendChat("/me уперевшись одной ногой на твердой поверхности, второй ногой проломил стекло автомобиля."); wait(500)
	        sampSendChat("/me силой вытащил подозреваемого "..string.gsub(sampGetPlayerNickname(id),'_',' ').." через проломленное окно."); wait(500)
					sampSendChat("/pull "..id); wait(500)
	    end)
		end
	end

	function cmd_clear(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}Правильное использование команды - /clear [id].", script_color)
	    else
				lua_thread.create(function()
	        sampSendChat("/me достав КПК из кармана, разблокировал его и вошёл в систему."); wait(1500)
					sampSendChat("/me перешел в раздел закрытия дел, попытался закрыть дело."); wait(1500)
					sampSendChat("/do Мобильная база данных запросила подтверждение на совершение операции."); wait(500)
					sampShowDialog(53, "Подтверждение снятия розыска", "{FFFFFF}Вы действительно хотите снять розыск с {FFA500}"..string.gsub(sampGetPlayerNickname(id),'_',' ').."{FFFFFF}?\n\n{ff0000}Примечание: снимать розыск преступникам разрешено только лидерам!", "Да", "Нет", 0)
			while sampIsDialogActive(53) do wait(100) end
			local result, button, _, input = sampHasDialogRespond(53)
			if button == 1 then
					sampSendChat("/me нажал на кнопку подтверждения операции, выключил мобильную базу и убрал её в карман."); wait(1500)
					sampSendChat('/clear '..id); wait(500)
					end
					if button == 0 then
					sampSendChat("/me нажал на кнопку отмены операции, выключил мобильную базу и убрал её в карман."); wait(500)
					end
		end)
		end
	end

	function cmd_fhelper(arg)
	    main_window_state.v = not main_window_state.v
	    imgui.Process = main_window_state.v
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

	function imgui.OnDrawFrame()
		local sw, sh = getScreenResolution()
		        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	  imgui.SetNextWindowSize(imgui.ImVec2(650, 378))
	  imgui.Begin('FBI-Helper', main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.ShowBorders)
	  imgui.BeginChild('left', imgui.ImVec2(190, 0), true)
	  if not selected then selected = 1 end
	  if imgui.Selectable(u8'Основные команды скрипта', false) then selected = 1 end
	  if imgui.Selectable(u8'Горячие клавиши скрипта', false) then selected = 2 end
		imgui.NewLine()
		imgui.NewLine()
		imgui.NewLine()
		imgui.NewLine()
		imgui.NewLine()
		imgui.Separator()--------------------------------------------------------------------------------------------------------------
		if imgui.Selectable(u8"-           О скрипте           -", false) then selected = 3 end
		imgui.Separator()--------------------------------------------------------------------------------------------------------------
	  imgui.EndChild()
	  imgui.SameLine()
	  imgui.BeginChild('right', imgui.ImVec2(0, 0), true)
	  if selected == 1 then
			imgui.Text(u8"ОСНОВНЫЕ КОМАНДЫ СКРИПТА:")
			imgui.Separator()
			imgui.Text(u8"Команды скрипта для задержания:")
			imgui.Spacing()
			imgui.Text(u8"/cuf [id] - надеть наручники на человека") -- простой текст внутри этого окна
			imgui.Text(u8"/uncuf [id] - снять наручники с человека") -- простой текст внутри этого окна
			imgui.Text(u8"/jail [id] - посадить человека в КПЗ") -- простой текст внутри этого окна
			imgui.Text(u8"/inc [id] - усадить человека в машину") -- простой текст внутри этого окна
			imgui.Text(u8"/usus [id] - умный розыск") -- простой текст внутри этого окна
			imgui.Text(u8"/sus [id] [кол-во звезд] [причина] - объявить человека в розыск") -- простой текст внутри этого окна
			imgui.Text(u8"/pul [id] - вытащить человека из машины") -- простой текст внутри этого окна
			imgui.Separator()
			imgui.Text(u8"Команды для чата:")
			imgui.Spacing()
			imgui.Text(u8"/rn [текст] - нонРП рация /r") -- простой текст внутри этого окна
			imgui.Text(u8"/fn [текст] - нонРП рация /f") -- простой текст внутри этого окна
			imgui.Separator()
			imgui.Text(u8"Прочее:")
			imgui.Spacing()
			imgui.Text(u8"/udost - предъявить удостоверение") -- простой текст внутри этого окна
			imgui.Text(u8"/histid [id] - проверить историю имен по ID") -- простой текст внутри этого окна
			imgui.Text(u8"/issue [id] - выдать пропуск в здание Мин.Внут.Дел") -- простой текст внутри этого окна
			imgui.Text(u8"/driver [id] [причина] - лишить человека прав") -- простой текст внутри этого окна
			imgui.Text(u8"/clear [id] - снять розыск") -- простой текст внутри этого окна
			imgui.Text(u8"/prava - зачитать права при задержании") -- простой текст внутри этого окна
			imgui.Text(u8"/cc - очистить чат") -- простой текст внутри этого окна
			imgui.Separator()
	  end
	  if selected == 2 then
			imgui.Text(u8"ГОРЯЧИЕ КЛАВИШИ СКРИПТА:")
			imgui.Spacing()
			imgui.Text(u8"END - управление шлагбаумом") -- простой текст внутри этого окна
			imgui.Text(u8"Home - кричалка при задержании [на улице | в машине]") -- простой текст внутри этого окна
			imgui.Separator()
	  end
		if selected == 3 then
			if imgui.Button(u8"Связь с автором скрипта") then
        os.execute("start https://vk.com/id124779478")
    	end
			imgui.Text(u8"Разработчик скрипта: Timur//.")
			imgui.Text(u8"На данный момент Вы используете версию "..thisScript().version..".")
			imgui.Text(u8"Скрипт разработан персонально для ... .")
	  end
	  imgui.EndChild()
	  imgui.End()
	end

	function apply_custom_style()
   imgui.SwitchContext()
   local style = imgui.GetStyle()
   local colors = style.Colors
   local clr = imgui.Col
   local ImVec4 = imgui.ImVec4
   local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 15.0
    style.FramePadding = ImVec2(5, 5)
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 15.0
    style.GrabMinSize = 15.0
    style.GrabRounding = 7.0
    style.ChildWindowRounding = 8.0
    style.FrameRounding = 6.0


      colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
      colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
      colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
      colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
      colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
      colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
      colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
      colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
      colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
      colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
      colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
      colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
      colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
      colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
      colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
      colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
      colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
      colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
      colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
      colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
      colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
      colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
      colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
      colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
      colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
      colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
      colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
      colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
      colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
      colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
      colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
      colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
      colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
apply_custom_style()

function ClearChat()
    local memory = require "memory"
    memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
    memory.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
    memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
end

--     _   _   _ _____ ___  _   _ ____  ____    _  _____ _____   ______   __   ___  ____  _     _  __
--    / \ | | | |_   _/ _ \| | | |  _ \|  _ \  / \|_   _| ____| | __ ) \ / /  / _ \|  _ \| |   | |/ /
--   / _ \| | | | | || | | | | | | |_) | | | |/ _ \ | | |  _|   |  _ \\ V /  | | | | |_) | |   | ' /
--  / ___ \ |_| | | || |_| | |_| |  __/| |_| / ___ \| | | |___  | |_) || |   | |_| |  _ <| |___| . \
-- /_/   \_\___/  |_| \___/ \___/|_|   |____/_/   \_\_| |_____| |____/ |_|    \__\_\_| \_\_____|_|\_\
--
-- Author: http://qrlk.me/samp
--
function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = 0x0080FF
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
