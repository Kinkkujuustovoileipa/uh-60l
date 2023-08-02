dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
dofile(LockOn_Options.script_path.."devices.lua")

package.cpath = package.cpath..";"..LockOn_Options.script_path.."..\\..\\bin\\?.dll"
require('avSimplestRadio')

local dev = GetSelf()
local xmitRadio = 0

function post_initialize()
	avSimplestRadio.SetupRadios(
		devices.ELECTRIC_SYSTEM,
		devices.INTERCOM,
		7,
		devices.FM1_RADIO,
		devices.UHF_RADIO,
		devices.VHF_RADIO,
		devices.FM2_RADIO,
		devices.HF_RADIO,
		devices.VORILS_RADIO,
		devices.ADF_RADIO
	)
end

dev:listen_command(Keys.radioPTT)
dev:listen_command(Keys.pilotICPXmitSelectorInc)
dev:listen_command(Keys.pilotICPXmitSelectorDec)
dev:listen_command(device_commands.pilotICPXmitSelector)

function SetCommand(command,value)
	if (command == Keys.radioPTT) then
		if xmitRadio == 0 then
			--print_message_to_user("ptt int")
			dev:performClickableAction(EFM_commands.intercomPTT, 1, true)
			dispatch_action(nil, EFM_commands.intercomPTT, 1)
		else
			avSimplestRadio.PTT(xmitRadio)
		end
	elseif command == device_commands.pilotICPXmitSelector then
		xmitRadio = round(value * 5)
		--print_message_to_user(xmitRadio)
	elseif (command == Keys.pilotICPXmitSelectorInc) then
		if xmitRadio < 5 then
			dev:performClickableAction(device_commands.pilotICPXmitSelector,xmitRadio / 5 + 0.2,true)
		end
		--print_message_to_user(xmitRadio)
	elseif (command == Keys.pilotICPXmitSelectorDec) then
		if xmitRadio > 0 then
			dev:performClickableAction(device_commands.pilotICPXmitSelector,xmitRadio / 5 - 0.2,true)
		end
		--print_message_to_user(xmitRadio)
	end
end

need_to_be_closed = false
