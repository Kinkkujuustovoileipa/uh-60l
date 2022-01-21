
dofile(LockOn_Options.script_path..'../../NetConfig.lua')

local paramNetMyPort = get_param_handle("NET_OWN_PORT")

local paramNetName1 = get_param_handle("NET_NAME_1")
local paramNetAddress1 = get_param_handle("NET_ADDRESS_1")
local paramNetPort1 = get_param_handle("NET_PORT_1")

local paramNetName2 = get_param_handle("NET_NAME_2")
local paramNetAddress2 = get_param_handle("NET_ADDRESS_2")
local paramNetPort2 = get_param_handle("NET_PORT_2")

local paramNetName3 = get_param_handle("NET_NAME_3")
local paramNetAddress3 = get_param_handle("NET_ADDRESS_3")
local paramNetPort3 = get_param_handle("NET_PORT_3")

local paramNetName4 = get_param_handle("NET_NAME_4")
local paramNetAddress4 = get_param_handle("NET_ADDRESS_4")
local paramNetPort4 = get_param_handle("NET_PORT_4")

paramNetMyPort:set(myPort)
paramNetName1:set("1) "..name1)
paramNetName2:set("2) "..name2)
paramNetName3:set("3) "..name3)
paramNetName4:set("4) "..name4)
paramNetAddress1:set(address1)
paramNetAddress2:set(address2)
paramNetAddress3:set(address3)
paramNetAddress4:set(address4)
paramNetPort1:set(port1)
paramNetPort2:set(port2)
paramNetPort3:set(port3)
paramNetPort4:set(port4)
