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

-------------------- �������� ����� --------------------
local script_color = 0x1284c4
local default_color = 'FFFFFF'
local select_color = 'FFFF00'
--------------------------------------------------------

--����� ������------
local suspect = {
	{
	title = "{ff0000}������ 1: \t{ffffff}�����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� �������� � ���, ��� ��� ����� �������� ���.���� ��� ������ (1 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 1 1.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� �������� � ���, ��� ��� ������� ����� �������� ���.���� ��� ������ (1 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 1 1.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 2: \t{ffffff}���������� ����",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������� ��� ��������� ���.���� �������� ��� ����.������� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 2.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������� ��� ��������� ���.����� ������� �������� �� ����.���������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 2.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 3: \t{ffffff}������� ��� ��������� ���.����� ���������� ���.���� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 2.3 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 3: \t{ffffff}��������� �� ��������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������ ��� �������������� ������� ����� �������� ��� ��������� ������ ���� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 3.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 4: \t{ffffff}��������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ���������� ������ �������� (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 4.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}��������� � ���������� ���������� ������ �������� (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 4.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 5: \t{ffffff}��������� � ��������� � ����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ������� �������� ������� ������ ��� ���� � ��������� ����� ��� ��� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 5.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� ��������� �������� � ���������� � ��������� ����� ��� ��� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 5.2 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 6: \t{ffffff}�����",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ���� � ��������� �������� � ����� �����, ��������������, ��������� � �.�. (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 6.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 7: \t{ffffff}���������� � ��������� ��� �� �������� ������ ������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ����� ������� ���.������ ������������/������ ������������ (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 7.1 ��', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}������ 8: \t{ffffff}������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� � ������������� ����������/������� ���������� ������� �������� ��������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 8.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� � ������������� ����������/������� ���������� ������� ���. ��� ���-�� ��������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 8.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 9: \t{ffffff}�������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������� � ����� ������� �������������, ���� ��� ������� ��� �� �������� ��� ���������� �� ��� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 9.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������������� � ����� ������� �������������, ���� �������� ��������� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 9.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 10: \t{ffffff}������������� �� ��������������� �������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������� ��� ����.���������� �� ���������� ����� ���. ������������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 10.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������������� ��� ����.���������� �� ���������� ����� ���. �������������, � ����� ����� ��������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 10.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 3: \t{ffffff}������������� �� ���������� ���. ���������� � ���������� ��� � ������ ������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 10.3 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 11: \t{ffffff}����� �� �������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������� �� ������� ������������� �� ���� �� �� ���������� �� ���������, � ����� ���������� ����� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 11.1 ��', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}������ 12: \t{ffffff}����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ����� ���������� ��� ���� ���������, ����� ����������� ��� ���������� ������� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 12.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� ����� ���������� ��� ���� ���������, ���� ����������� ��� ���������� ����.������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 12.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 13: \t{ffffff}���� ������������� ��������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ������������� ��� ������� ����������� ������������� � ������������ �������� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 13.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���� ��� ������� ����� ������ ������������� �������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 13.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 3: \t{ffffff}���������� ������������� ��� ������� ����������� ������������� � ���. ������������ �������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 13.3 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 14: \t{ffffff}����� �������������� ������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ����� ������ �������������� ������, �����������, ��� ������ � ���� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 14.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 15: \t{ffffff}��������� ���������� ���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ������� ��� ����� ��������� ���������� ���������, ����������� ����� ����� ��� �� ������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 15.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 16: \t{ffffff}��������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����������� ��� ������� �� �������� � ����� ��������� �������� ��������� ��� �� ����� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 16.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}����������� ��� ������� �� �������� ����� ������������� ���������� ���������� � ����� ��������� ������ (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 16.2 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 17: \t{ffffff}�������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ��������/������������� ����������� ��������� � ����� ��������/������ � ����������� �������� ��� ���. (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 17.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}��������/����������� ������ �/� � ����� �����./����� �/�, ������������� �����������/����������� ������ (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 17.2 ��', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}������ 18: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����������, �����������/����������� ���������, �������������� ������� ���� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 18.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� ���������� ������ ���� ����� ���. ��� ���. ��������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 18.2 ��', umniy_rozisk))
		end
		},
		}
	},
	{
	title = "{ff0000}������ 19: \t{ffffff}��������� �������������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����������� � ����������, ���������, � ����� �������� ������������ ��������, ����������� ��������� ��������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 19.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}�������� �����������/���������� ������������������� � ����� �������� ���������� ������������ (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 19.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 20: \t{ffffff}�����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ����/����� � ���� ����� ��������, ������ ������� ���������/��������� ��� ���������� ����������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 20.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 21: \t{ffffff}������������ ��� ���������� ��������� � ������������ ������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�����������������/������� � ��������� ������������� ��� ����. ��������� � ����� ������������ ����� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 21.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}�������������� �� ������� �������� � ������������ ����� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 21.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 3: \t{ffffff}������������ ������ ���� � ��������� ��� � ������������ �����, ��� � � ��������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 21.3 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 22: \t{ffffff}����������� � �����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������� ������������/����������� ������� ������� � ������� ���� � ����� �� �����/����/������ ������ (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 22.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}�������/������ ������� ������������, ������ �� ������, ������������� ������������ (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 22.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}��������/���������� ���� � ����� ��������������� �������� ����� (3 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 3 22.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 23: \t{ffffff}�������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������� ����� � ���������� ���. ����� � ����� ���������� � ������� ��� � ������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 23.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� �������� ���� � ����� ������ ��� ���� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 23.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 24: \t{ffffff}��������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�����������/�������� �������� �����-���� ����� �� ��������� � ���. ����� � ����� �������� �� �� ������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 24.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}��������� ����-���� �� ������� ���. ���� � ����� ������������ �����-���� ������ (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 24.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 25: \t{ffffff}����� �� ������ ������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������� ����� �� ������� ������ (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 25.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 26: \t{ffffff}�������� ���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������ � �������� ������������� �������/����������� ������� ����, ��������� ���. �������� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 26.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������� � �����-���� ����� �� ����� � ����� �������������� �������, ��� �� ������������ ��������� (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 26.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 27: \t{ffffff}��������� ������ ������ � ���",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������� ��� ��������� ������ � ��� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 27.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������������� ��� ��������� ������������ ���������, ��������� ����� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 27.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 28: \t{ffffff}���� ������ ���������� ���������������� ���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���� �������� ������ ���������� ���������� ���.���� � ���� ������������� � ����� ���� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 28.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���� �������� ������ ����������, �������� � ������� ���������/������������ �� ���� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 28.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 29: \t{ffffff}����� ���������������� ���� ���������� ���.����",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����� ���������������� ���� ���������� ���.���� � ����� ����� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 29.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 30: \t{ffffff}������ ���� �� ���������������� ���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������ ���� ���. �������� � ��������� �����, ��� ���������� ����� �������� ���������� ���������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 30.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������� ������/����� ���.���������� �� ���� �� �� ���������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 30.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 31: \t{ffffff}������������ ���. ���������, ��������� ������ ����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����� ������� �������� ���������������� ��������� ��������� ���� ����������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 31.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}�� ���������� ��������� �������� ������������ ���������� ���.���� ��� �� ������ ��� ������ (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 31.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}��������� ����������, ������������� ������, ����� �� ��� ������, ����� �� ������ (4 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 4 31.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 32: \t{ffffff}������������ ������������� ���������� ������� �����",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������� ���. ���������� ������� ����� ��� ��������� ����� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 32.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 33: \t{ffffff}������������� �������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�����������/������� ����������, ��������/������ �����-���� �������������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 33.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 34: \t{ffffff}������������� �������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ������� �� ����������� ���������� ����������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 34.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 35: \t{ffffff}����������� ���������������� ����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����������� ���������������� ���������� � ������ ���. �������, ������� �� �������� �� ���. �������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 35.1 ��', umniy_rozisk))
		end
		},
	}
	},
	{
	title = "{ff0000}������ 36: \t{ffffff}����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������ ����������� ������������, ��������� ���������� ����� ��������� �������, ������ ���/���-�� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 36.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}��������������� ������������ ������������ �����, �������������� �� ���������� ������� ����������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 36.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}����������� ����������� � ���������������/���������� ��� �������, ���������� ������������ �� ��������������� (5 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 5 36.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 37: \t{ffffff}������� ������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������/��������� �� �� ������� �������, �������� ������/��������, ���������� � ���������� ������ (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 37.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� ��������� ����� �������������� �������� ��������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 37.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}����������� ���������� ����� ��� ������������ ������ (2 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 2 37.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 38: \t{ffffff}��������� �����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� �������/���������� �������� � ������������ �����/������������ ����������, ������� ������������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 38.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������������� ������������� �������, ����, ����������� ������� (1 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 1 38.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}����������� ����������� ������������������ ������� ��� ���������� (3 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 3 38.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 39: \t{ffffff}������������������� ��������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����� ��������/������ ��� �������� ������������ ����� ����� ���������� ���������� ���.���� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 39.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� ����������������� ����� � ��������� ����������� ��������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 39.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}�����������/������ � ����������� ���������� ��������, �������/�������� (3 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 3 39.3 ��', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}����� 4: \t{ffffff}������� � ���������� ���������, ��������/�������� (3 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 3 39.4 ��', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}����� 5: \t{ffffff}���� ������������� ��������, �������/�������� (3 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 3 39.5 ��', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}����� 6: \t{ffffff}��������, ������������ �� ��������� ����������� ������/������ � ����� ��������� (6 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 6 39.6 ��', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}����� 7: \t{ffffff}��������������� � ��� ����������, ���������� ��������� ������� � ����������/������������� � (6 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 6 39.7 ��', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}����� 8: \t{ffffff}��������������� � ��� �������� ������� ����������/������������ ������ ������ (4 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 4 39.8 ��', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}����� 9: \t{ffffff}��������������� � ��� �������� ������� ����������/������������ ������� (4 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 4 39.9 ��', umniy_rozisk))
	end
	},
	{
	title = "{ff0000}����� 10: \t{ffffff}��������������� � ��� �������� � ����. ���������/������� ���������� ��������������������� �������� (5 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 5 39.10 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 40: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}��������, ����������� ���� ����� � �������� �������/��������� ��� ������� ���������� (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 40.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� ��������, ������������ �� ������ ���������� �������� (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 40.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}�������� ������ ��������� � �������� (6 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 6 40.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 41: \t{ffffff}���������� �����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� ���������� �����������, � ����� ���������� ������������/����� ������������ (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 41.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}������� � ���������� �����������, ���������� ���������� ������ � ��������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 41.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}���������� ���������� ����������� � ���������� ��������� ������ (4 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 4 41.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 42: \t{ffffff}�������� ���������������� ������������ ��� �������� ����������.",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� ���������������� ������������ ���� �� ���� ��������, �������������� �������� ����� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 42.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 43: \t{ffffff}���������� ���������� �������� � ����������� ���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������� ����������� �/��� �������� ���������, ��� ������� �� �� ����������� �������� (2 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 2 43.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� ������������ ����������� �/��� �������� ��������� ��� ������� �� �� ����������� �������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 43.2 ��', umniy_rozisk))
		end
	}
	}
	},
	{
	title = "{ff0000}������ 44: \t{ffffff}���������� �������������� ���������� �����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ���������������� ���������, ������� ����� ��������� ����������� ��� ������� �������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 44.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 45: \t{ffffff}���������� ������� ����� �� ����� ���������� ������������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������� �����, �������� � ����� �������� ������ ����/����� ����� ��� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 45.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 46: \t{ffffff}������������ , ��������� � �������������� ����������� �����",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� �������������/������������/������������ ���. ���������, ��������� ������ ������� �����/�������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 46.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}�������������� � �������������� ���.��������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 46.2 ��', umniy_rozisk))
		end
	}
	}
	},
	{
	title = "{ff0000}������ 47: \t{ffffff}���������� �������� ������������� ���������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ��������/���������/������������� ���������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 47.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 48: \t{ffffff}���������� ������ ������������� �������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� �������/������� ������� ���������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 48.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}����� 2: \t{ffffff}���������� �������/������� ������� ���������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 48.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}���������� ������ �� ���������� ����� ���������� (5 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 5 48.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 49: \t{ffffff}���������� ������������ ������������� �������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}������������/������� ���������� ����������/������� ��������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 49.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 50: \t{ffffff}���������� ��������� ���",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ��������� ��� � ���������� ������� ����� ���������� �������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 50.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 51: \t{ffffff}��������� ���, ������� �������� ������ �����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}��������� ���, � ���������� �������� ��� ������� ������ ����/������ (6 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 6 51.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 52: \t{ffffff}������������ �����������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}���������� ������������ ������������� �����/��������������� ����� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 52.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 54: \t{ffffff}����������� �������� ����",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}��������� ��� ���� �����/��������, ����������� � �������� ������ ��� ������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 54.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 55: \t{ffffff}�������� ������������ �������������� ������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� ������ �������������� ������, ������� ���� �������� ����������� ���� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 55.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 57: \t{ffffff}����������������� ������� �������������� ������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}����������� ������� ������ ���� ���������.������, �� ���� �� �� ����������/�������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 57.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 58: \t{ffffff}������ ������������� �������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� �������������/��������������������� ���������/����������, ��������������� ��� ������ (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 58.1 ��', umniy_rozisk))
		end
	},
		{
		title = "{ff0000}����� 2: \t{ffffff}������������ �������������/��������������������� ���������/����������, ��������������� ��� ������ (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 58.2 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}���� �������������/��������������������� ���������/����������, ��������������� ��� ������ (5 �.�)",
	onclick = function()
		sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
		sampSendChat(string.format('/su %s 5 58.3 ��', umniy_rozisk))
	end
	}
	}
	},
	{
	title = "{ff0000}������ 59: \t{ffffff}�������� ������ � ����� �����",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� 4 � ����� �����/����������� ����������� ������ � ����� �� ����������/���������� ��� ������� (5 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 5 59.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 60: \t{ffffff}���������������� �������������� ������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� �������, ������������ ��������������/��������������� ������ � ����� �������� ����� � ������� (3 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 3 60.1 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}������ 61: \t{ffffff}�������������� �������� �� �������������� ������",
	submenu = {
		{
		title = "{ff0000}����� 1: \t{ffffff}�������� �� �������������� ������ ��� ��������� ���������� (4 �.�)",
		onclick = function()
			sampSendChat('/me ������ ��������� ���, ����� ���� ������ ������.')
			sampSendChat(string.format('/su %s 4 61.1 ��', umniy_rozisk))
		end
		}
	}
	},

}
--------------------

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
        while not isSampAvailable() do wait(100) end
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}������ ������� ������� � ����� � ������. �����������: Timur//.", 0x1284c4)
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}��� ������������ � ����������� � ������������ ������� ������� ������� /fhelper.", 0x1284c4)

				autoupdate("https://raw.githubusercontent.com/btrtmr18/FBI-Helper/master/update", '['..string.upper(thisScript().name)..']: ', "��� ������ �� ��� ����/url ������ ������� �� ������ (���� ���, �������� ��� � json)")

				sampRegisterChatCommand("cuf", cmd_cuff) -- /cuff
				sampRegisterChatCommand("uncuf", cmd_uncuff) -- /uncuff
				sampRegisterChatCommand("jail", cmd_arrest) -- /arrest
				sampRegisterChatCommand("udost", cmd_udost) -- /udost
				sampRegisterChatCommand("rn", function(text) if text ~= "" then sampSendChat("/r (( "..text.." ))") else sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /rn [�����]", 0x1284c4) end end)
				sampRegisterChatCommand("fn", function(text) if text ~= "" then sampSendChat("/f (( "..text.." ))") else sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /fn [�����]", 0x1284c4) end end)
				sampRegisterChatCommand("histid", cmd_histid) -- ������� ����� �� ID
				sampRegisterChatCommand("inc", cmd_putpl) -- /putpl
				sampRegisterChatCommand("usus", cmd_usus) -- ����� ������ su
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
								sampSendChat("/me ������ ����� ���������� ����������, ����� �� ���� �� ������.")
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
						sampShowDialog(543, "{FFFF00}FBI-Helper", "�������� � ������\n������ ���������\n����� ���������\n�������� � ������\n���������� �����\n�������� ����� �����", "�������", "�������", sf.DIALOG_STYLE_LIST)
						if sampIsDialogActive() then
							while sampIsDialogActive() do
								wait(0)
								local dlgresult, dlgbutton, dlglist, dlginput = sampHasDialogRespond(543)
								if dlgresult then
									if dlgbutton == 1 then
										if dlglist == 0 then
											umniy_rozisk = id
											submenus_show2(suspect, '{FFFF00}FBI Menu | ����� ������')
										elseif dlglist == 1 then
											if IPC(id) then
												sampSendChat('/me �������� ������ ���� � �����, ��������� ���� ���������, ����� ���� ������ �� � ����� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ..');
												sampSendChat('/do .. ������ ���������, ��� ����� �������� �� ������, �������� ���������.'); wait(1500)
												sampSendChat('/cuff '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 2 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(uncuffID), '_', ' ')
												sampSendChat('/me �������� ���� ������, ���������� ��������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.'); wait(1500)
												sampSendChat('/me ���� ��������� � ��� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ����� ������� �� �� ����.'); wait(1500)
												sampSendChat('/uncuff '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 3 then
											if IPC(id) then
												sampSendChat('/me ������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ����� ���� ������� ��� � ������� ����������.'); wait(1500)
												sampSendChat('/me ������ ����� ����������, ����� ���� ������ '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' ������, ����� ������ �����.'); wait(1500)
												sampSendChat('/putpl '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 4 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me ������� ���� � ������, ������ ���� ��������� ��������, ������� �� �� ����.'); wait(1500)
												sampSendChat('/anim 16'); wait(500)
												sampSendChat('/me ������� ���� ����� �����, ����� ���������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' �� ������� ������ ����.'); wait(1500)
												sampSendChat('/anim 14'); wait(500)
												sampSendChat('/me ����������, ����� ���������� ������ ����� ���� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.')
												sampSendChat('/search '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 5 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me ������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' � ������� ��� ����� �����.'); wait(1500)
												sampSendChat('/hold '..id)
											else
												SCM('����� �� ���������.')
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
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /cuf [id].", script_color)
		    else
					lua_thread.create(function()
		        sampSendChat("/me �������� ������ ���� � �����, ��������� ���� ���������, ����� ���� ����� �� � ����� "..string.gsub(sampGetPlayerNickname(id),'_',' ').." ..."); wait(1500)
		        sampSendChat("/do ... ������ ���������, ��� ����� �������� �� ������, �������� ���������."); wait(500)
						sampSendChat("/cuff "..id); wait(500)
		    end)
			end
		end

		function cmd_uncuff(param)
		    id = string.match(param, "(.+)")
		    if id ==nil or id == "" then
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /uncuf [id].", script_color)
		    else
			lua_thread.create(function()
		        sampSendChat("/me �������� ���� ������, ���������� ��������� "..string.gsub(sampGetPlayerNickname(id),'_',' ').."."); wait(1500)
				sampSendChat("/me ���� ��������� � ��� "..string.gsub(sampGetPlayerNickname(id),'_',' ').." , ����� ������� �� �� ����."); wait(500)
				sampSendChat("/uncuff "..id); wait(500)
		    end)
			end
		end

		function cmd_takelic(param)
		    id, pricina = string.match(param, "(.+) (.+)")
		    if id ==nil or id == "" then
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /driver [id] [�������].", script_color)
		    else
					lua_thread.create(function()
		        sampSendChat("/do ���������� ������ � ����� �Overseer� ������������� ���������."); wait(500)
						sampSendChat("/me ������ ��� �� �������, ������������� ��� � ����� � �������."); wait(500)
						sampSendChat("/me �������� ��������� ��������, ���������� ����� � "..string.gsub(sampGetPlayerNickname(id),'_',' ').."."); wait(500)
		        sampSendChat("/takelic "..id.." "..pricina); wait(500)
						sampSendChat("/do ����� ������������ � ����������� � ���� ������."); wait(500)
		    end)
			end
		end

		function cmd_arrest(param)
			id = string.match(param, "(.+)")
			if id ==nil or id == "" then
				sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /jail [id].", script_color)
			else
			lua_thread.create(function()
				sampSendChat("/do �� ������ ���������� ���������� ��������� �������� ���������."); wait(1500)
				sampSendChat("/me ������ ������� �� ������, ��� ����� ����������� ������ ��������� ����������."); wait(1500)
				sampSendChat("/do � ������� ��������� ���������� ��������� ������� ��������� ����������."); wait(1500)
				sampSendChat("/me ������� ���� [�"..id.." | "..string.gsub(sampGetPlayerNickname(id),'_',' ').."] � �������� ��������� � �������� ���������."); wait(500)
				sampSendChat("/arrest "..id); wait(500)
			end)
			end
		end

		function cmd_udost()
			lua_thread.create(function()
			sampSendChat("/me ������ ������������� �� �������, ����� ������� ���."); sampSendChat("/anim 21")
			wait(1500)
			sampSendChat('/do �������������: ����������� ���� �������������.'); wait(500)
			sampSendChat('/do �������������: ���������: Scott Ward | ���������: Head of Department.'); wait(500)
			sampSendChat('/do �������������: ������ �����: 19-055-75 | ��� ����������: �������.'); wait(500)
		end)
	end

	function cmd_histid(params) -- ������� ����� �� ID
		if params:match("^%d+") then
			params = tonumber(params:match("^(%d+)"))
			if sampIsPlayerConnected(params) or myID == tonumber(params) then
				local histnick = sampGetPlayerNickname(params)
				sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ����� ������� ���� ������ "..string.gsub(sampGetPlayerNickname(params),'_',' ').." �� ID.", script_color)
				sampSendChat("/history "..histnick)
			else
				sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}����� � ������ ID �� ��������� � �������.", script_color)
			end
		else
			sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /hist [id].", script_color)
		end
	end

	function cmd_putpl(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /inc [id].", script_color)
	    else
				lua_thread.create(function()
					sampSendChat("/me ������� "..string.gsub(sampGetPlayerNickname(id),'_',' ')..", ����� ���� ������� ��� � ������� ����������."); wait(1500)
					sampSendChat("/me ������ ����� ����������, ����� ���� ������ "..string.gsub(sampGetPlayerNickname(id),'_',' ').." ������, ����� ������ �����."); wait(500)
					sampSendChat("/putpl "..id); wait(500)
	    end)
		end
	end

	function cmd_usus(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /usus [id].", script_color)
	    else
				lua_thread.create(function()
					umniy_rozisk = id
					submenus_show2(suspect, '{FFFF00}FBI Menu | ����� ������')
	    end)
		end
	end

	function cmd_suspect(param)
	    id, zvezd, pricina = string.match(param, "([0-9]+) ([0-9]+) (.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /sus [id] [���-�� �����] [�������].", script_color)
	    else
	      lua_thread.create(function()
	        sampSendChat("/me ������� ������ ���� � ������, ������ ���, ����� ������� ��� � ���� ������."); wait(900)
	        sampSendChat("/su "..id.." "..zvezd.." "..pricina); wait(900)
					sampSendChat("/do "..string.gsub(sampGetPlayerNickname(id),'_',' ').." �������� � ������ �� ������ �"..pricina.."�.")
	        end)
	    end
	end

	function cmd_skip(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /issue [id].", script_color)
	    else
				lua_thread.create(function()
	        sampSendChat("/me ������ ��� �� �������, ������������� ��� � ����� � �������."); wait(1500)
	        sampSendChat("/me ����� ������ ������, ������������ ��� � ����� ��� � ������."); wait(500)
					sampSendChat("/skip "..id); wait(500)
	    end)
		end
	end

	function cmd_prava()
		lua_thread.create(function()
				sampSendChat("�� ���������� � ������ ����� ������� ��������."); wait(2000)
				sampSendChat("��, ��� �� �������, ����� ���������� ���������."); wait(2000)
				sampSendChat("����� �����, �� ������ ����� ��������������� �������� ��������."); wait(2000)
				sampSendChat("���� �� �� �������, �� � ��� ���� ����� �� ����������� ������������� ����� ������."); wait(2000)
				sampSendChat("�� ������ ����� �� ���������� ������ ����������� ������.")
	end)
	end

	function cmd_pull(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /pul [id].", script_color)
	    else
				lua_thread.create(function()
					sampSendChat("/me ���������� ����� ����� �� ������� �����������, ������ ����� �������� ������ ����������."); wait(500)
	        sampSendChat("/me ����� ������� �������������� "..string.gsub(sampGetPlayerNickname(id),'_',' ').." ����� ������������ ����."); wait(500)
					sampSendChat("/pull "..id); wait(500)
	    end)
		end
	end

	function cmd_clear(param)
	    id = string.match(param, "(.+)")
	    if id ==nil or id == "" then
	        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}���������� ������������� ������� - /clear [id].", script_color)
	    else
				lua_thread.create(function()
	        sampSendChat("/me ������ ��� �� �������, ������������� ��� � ����� � �������."); wait(1500)
					sampSendChat("/me ������� � ������ �������� ���, ��������� ������� ����."); wait(1500)
					sampSendChat("/do ��������� ���� ������ ��������� ������������� �� ���������� ��������."); wait(500)
					sampShowDialog(53, "������������� ������ �������", "{FFFFFF}�� ������������� ������ ����� ������ � {FFA500}"..string.gsub(sampGetPlayerNickname(id),'_',' ').."{FFFFFF}?\n\n{ff0000}����������: ������� ������ ������������ ��������� ������ �������!", "��", "���", 0)
			while sampIsDialogActive(53) do wait(100) end
			local result, button, _, input = sampHasDialogRespond(53)
			if button == 1 then
					sampSendChat("/me ����� �� ������ ������������� ��������, �������� ��������� ���� � ����� � � ������."); wait(1500)
					sampSendChat('/clear '..id); wait(500)
					end
					if button == 0 then
					sampSendChat("/me ����� �� ������ ������ ��������, �������� ��������� ���� � ����� � � ������."); wait(500)
					end
		end)
		end
	end

	function cmd_fhelper(arg)
	    main_window_state.v = not main_window_state.v
	    imgui.Process = main_window_state.v
	end

	-- ======================================================================

	function IPC(id) -- ������ sampIsPlayerConnected()
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
	    select_button, close_button, back_button = select_button or '�������', close_button or '�������', back_button or '�����'
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
	    select_button, close_button, back_button = select_button or '�������', close_button or '�������', back_button or '�����'
	    prev_menus = {}
	    function display(menu, id, caption)
	        local string_list = {}
	        for i, v in ipairs(menu) do
	            table.insert(string_list, type(v.submenu) == 'table' and v.title or v.title)
	        end
	        sampShowDialog(id, caption, '���������\t��������\n' .. table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_TABLIST_HEADERS)
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
	  if imgui.Selectable(u8'�������� ������� �������', false) then selected = 1 end
	  if imgui.Selectable(u8'������� ������� �������', false) then selected = 2 end
		imgui.NewLine()
		imgui.NewLine()
		imgui.NewLine()
		imgui.NewLine()
		imgui.NewLine()
		imgui.Separator()--------------------------------------------------------------------------------------------------------------
		if imgui.Selectable(u8"-           � �������           -", false) then selected = 3 end
		imgui.Separator()--------------------------------------------------------------------------------------------------------------
	  imgui.EndChild()
	  imgui.SameLine()
	  imgui.BeginChild('right', imgui.ImVec2(0, 0), true)
	  if selected == 1 then
			imgui.Text(u8"�������� ������� �������:")
			imgui.Separator()
			imgui.Text(u8"������� ������� ��� ����������:")
			imgui.Spacing()
			imgui.Text(u8"/cuf [id] - ������ ��������� �� ��������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/uncuf [id] - ����� ��������� � ��������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/jail [id] - �������� �������� � ���") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/inc [id] - ������� �������� � ������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/usus [id] - ����� ������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/sus [id] [���-�� �����] [�������] - �������� �������� � ������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/pul [id] - �������� �������� �� ������") -- ������� ����� ������ ����� ����
			imgui.Separator()
			imgui.Text(u8"������� ��� ����:")
			imgui.Spacing()
			imgui.Text(u8"/rn [�����] - ����� ����� /r") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/fn [�����] - ����� ����� /f") -- ������� ����� ������ ����� ����
			imgui.Separator()
			imgui.Text(u8"������:")
			imgui.Spacing()
			imgui.Text(u8"/udost - ���������� �������������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/histid [id] - ��������� ������� ���� �� ID") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/issue [id] - ������ ������� � ������ ���.����.���") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/driver [id] [�������] - ������ �������� ����") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/clear [id] - ����� ������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/prava - �������� ����� ��� ����������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"/cc - �������� ���") -- ������� ����� ������ ����� ����
			imgui.Separator()
	  end
	  if selected == 2 then
			imgui.Text(u8"������� ������� �������:")
			imgui.Spacing()
			imgui.Text(u8"END - ���������� ����������") -- ������� ����� ������ ����� ����
			imgui.Text(u8"Home - �������� ��� ���������� [�� ����� | � ������]") -- ������� ����� ������ ����� ����
			imgui.Separator()
	  end
		if selected == 3 then
			if imgui.Button(u8"����� � ������� �������") then
        os.execute("start https://vk.com/id124779478")
    	end
			imgui.Text(u8"����������� �������: Timur//.")
			imgui.Text(u8"�� ������ ������ �� ����������� ������ "..thisScript().version..".")
			imgui.Text(u8"������ ���������� ����������� ��� ... .")
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
                sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('�������� ���������� ���������.')
                      sampAddChatMessage((prefix..'���������� ���������!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
