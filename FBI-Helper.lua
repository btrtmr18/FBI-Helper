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
  local fpath = os.getenv('TEMP') .. '\\testing_version.json' -- ���� ����� �������� ��� ������ ��� ��������� ������
  downloadUrlToFile('https://raw.githubusercontent.com/btrtmr18/FBI-Helper/master/checkupdate', fpath, function(id, status, p1, p2) -- ������ �� ��� ������ ��� ���� ������� ������� � ��� � ���� ��� ����� ������ ����
    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
    local f = io.open(fpath, 'r') -- ��������� ����
    if f then
      local info = decodeJson(f:read('*a')) -- ������
      updatelink = info.updateurl
      if info and info.latest then
        version = tonumber(info.latest) -- ��������� ������ � �����
        if version > tonumber(thisScript().version) then -- ���� ������ ������ ��� ������ ������������� ��...
          lua_thread.create(goupdate) -- ������
        else -- ���� ������, ��
          update = false -- �� ��� ����������
          sampAddChatMessage(('[Testing]: � ��� � ��� ��������� ������! ���������� ��������'), color)
        end
      end
    end
  end
end)
end
--���������� ���������� ������
function goupdate()
sampAddChatMessage(('[Testing]: ���������� ����������. AutoReload ����� �������������. ����������...'), color)
sampAddChatMessage(('[Testing]: ������� ������: '..thisScript().version..". ����� ������: "..version), color)
wait(300)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23) -- ������ ��� ������ � latest version
  if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
  sampAddChatMessage(('[Testing]: ���������� ���������!'), color)
  thisScript():reload()
end
end)
end

-- �Ѩ!

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
		title = "{ff0000}����� 1: {ffffff}���������� �������� � ���, ��� ��� ����� �������� ���������� ���� ��� ������,\n��� ����� ��������� ��� ������� �� ���� �����. (1 �.�.)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: {ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 2: \t{ffffff}����������� ���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 6 2.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 6 2.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 3: \t{ffffff}����",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}������� �����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 3.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 3.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 4: \t{ffffff}������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}����������� ������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 4.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}������ ������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 4.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 5: \t{ffffff}������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}������� ������ � �������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 5.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}������� ������ ��� ��������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 5.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 3: \t{ffffff}����������� ������� ������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 4 5.3 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 4: \t{ffffff}����������� ������� ������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 4 5.4 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 6: \t{ffffff}������ � ��������� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 6 6.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 7: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}������������, ���� ���������� �������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 6 7.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}�� �������� ������ ��������� � �������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 7.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 8: \t{ffffff}��������� � ���������� ������������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}��������� � ������������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 4 8.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}������ ������ ���",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 8.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 9: \t{ffffff}������������ ��� / ����� �� ������� ������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}������������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 9.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}�����/������������� ������� ������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 9.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 10: \t{ffffff}������������� �� ���������� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 10.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 11: \t{ffffff}������������� �������� / ���",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}�������� ����������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 5 11.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}����������� ������� ����������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 5 11.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������� ����� ��� (��)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 11.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 3: \t{ffffff}����������� ������������ ����������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 11.3 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 3: \t{ffffff}���������� �������� ��� (��)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 11.3 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 12: \t{ffffff}������������� ��������� ���. ��������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}�������� ����������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 12.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}������� ����� ���. ��������� (�� ������ � �����������)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 12.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 13: \t{ffffff}����������� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 13.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 14: \t{ffffff}������ (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 4 14.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 15: \t{ffffff}�����������, ���� ������������� ����� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 15.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 16: \t{ffffff}����� �� �������������� ���������� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 16.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 17: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}����������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 17.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 17.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 3: \t{ffffff}������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 17.3 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 18: \t{ffffff}����������� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 4 18.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 19: \t{ffffff}����� � �������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}�� �������� ��� ������� � ������ ��� ��������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 4 19.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}����������� �����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 6 19.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 20: \t{ffffff}������� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 6 20.1 ��', umniy_rozisk))
		end
	},
	{
	title = "{ff0000}����� 21: \t{ffffff}������������ ������ ������� �������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}�������������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 5 21.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}���������� ��������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 21.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 3: \t{ffffff}�����������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 21.3 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 22: \t{ffffff}���� � �������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}���������� ��������� �������������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 2 22.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}�������� ������ ����� �������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 1 22.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 23: \t{ffffff}���� �����������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}���� ��������������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 23.2 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}����������� �������������� �������� �� ������������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 23.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 24: \t{ffffff}����� ���. ���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}����� �������� � �����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 24.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}������� ���. ���������",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 4 24.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 1: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 1: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 1: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 1: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 1: \t{ffffff}���������",
	submenu = {
		{
		title = "{ff0000}������ 1: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.1 ��', umniy_rozisk))
		end
		},
		{
		title = "{ff0000}������ 2: \t{ffffff}��������� �� ����������� ����",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 3 1.2 ��', umniy_rozisk))
		end
		}
	}
	},
	{
	title = "{ff0000}����� 25: \t{ffffff}��������� (������ 1)",
		onclick = function()
			sampSendChat('/me ������ ��������� ��� � ��� ������ ������')
			sampSendChat(string.format('/su %s 6 69.1 ��', umniy_rozisk))
		end
	}
}
--------------------


function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
        while not isSampAvailable() do wait(100) end
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}������ ������� ������� � ����� � ������. �����������: Timur//.", 0x1284c4)
				sampAddChatMessage("{FFFF00}[FBI-Helper] {FFFFFF}��� ������������ � ����������� � ������������ ������� ������� ������� /fhelper.", 0x1284c4)

				sampRegisterChatCommand("cuf", cmd_cuff) -- /cuff
				sampRegisterChatCommand("udost", cmd_udost) -- /udost


        while true do
        wait(0)

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
											submenus_show2(suspect, '{00ff00}Police Menu | �������� � ������')
										elseif dlglist == 1 then
											if IPC(id) then
												sampSendChat('/me ��������� ������ ���� � �����, ��������� ����� ���������, ����� ���� �������� �� � ����� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ..');
												sampSendChat('/do .. ������� ���������, ��� ����� �������� �� ������, ��������� ���������.'); wait(1500)
												sampSendChat('/cuff '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 2 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(uncuffID), '_', ' ')
												sampSendChat('/me ��������� ���� ������, ����������� ��������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.'); wait(1500)
												sampSendChat('/me ����� ��������� � ��� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ����� �������� �� �� ����.'); wait(1500)
												sampSendChat('/uncuff '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 3 then
											if IPC(id) then
												sampSendChat('/me �������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..', ����� ���� �������� ��� � ������� ����������.'); wait(1500)
												sampSendChat('/me ������� ����� ����������, ����� ���� ������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' ������, ����� ������� �����.'); wait(1500)
												sampSendChat('/putpl '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 4 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me �������� ���� � ������, ������� ���� ��������� ��������, �������� �� �� ����.'); wait(1500)
												sampSendChat('/anim 16'); wait(500)
												sampSendChat('/me �������� ���� ����� �����, ������ ���������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' �� ������� ������ ����.'); wait(1500)
												sampSendChat('/anim 14'); wait(500)
												sampSendChat('/me �����������, ������ ���������� ������ ����� ���� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..'.')
												sampSendChat('/search '..id)
											else
												SCM('����� �� ���������.')
											end
										elseif dlglist == 5 then
											if IPC(id) then
												local thatPlayerRpNick = string.gsub(sampGetPlayerNickname(id), '_', ' ')
												sampSendChat('/me �������� '..string.gsub(sampGetPlayerNickname(id),'_',' ')..' � �������� ��� ����� �����.'); wait(1500)
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
		        sampAddChatMessage("{"..select_color.."}[FBI-Helper] {FFFFFF}����������� �������: /cuf [ID].", script_color)
		    else
					lua_thread.create(function()
		        sampSendChat("/me �������� ������ ���� � �����, ��������� ���� ���������, ����� ���� ����� �� � ����� "..string.gsub(sampGetPlayerNickname(id),'_',' ').." ..."); wait(1500)
		        sampSendChat("/do ... ������ ���������, ��� ����� �������� �� ������, �������� ���������."); wait(500)
						sampSendChat("/cuff "..id); wait(500)
		    end)
			end
		end

		function cmd_udost()
			lua_thread.create(function()
			sampSendChat("/me ������� ������������� �� �������, ����� �������� ���"); sampSendChat("/anim 21")
			wait(1500)
			sampSendChat('/do �������������: ����������� ���� �������������.'); wait(500)
			sampSendChat('/do �������������: ���������: Dana Scully | ���������: Head of Department.'); wait(500)
			sampSendChat('/do �������������: ������ �����: 19-055-75 | ��� ����������: �������.'); wait(500)
		end)
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

	function strobes()
		if (isCharInAnyCar(PLAYER_PED) and enablestr == false) then
			enablestr = true
			SCM('����������� ������������.')
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
			SCM('����������� ��������������.')
			enablestr = false
		end
	end
