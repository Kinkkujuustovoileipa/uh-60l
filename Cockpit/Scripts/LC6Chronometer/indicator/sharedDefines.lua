dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

SetScale(METERS)
bgColor = {0,0,0,50}--{10,13,12,100}
fontColor = {139, 104, 31, 255}--{139, 104, 31, 10}--{68,71,38,100}
font = MakeFont({used_DXUnicodeFontData = "h60_font_7seg"}, fontColor)
font2 = MakeFont({used_DXUnicodeFontData = "T45fontMFD"}, fontColor)


rotation = {0, 0, dashRotation} -- main panel rotation roughly 22deg

verts = {}
dx=.025
dy=.008
verts [1]= {-dx,-dy}
verts [2]= {-dx,dy}
verts [3]= {dx,dy}
verts [4]= {dx,-dy}

textSizeModLarge = 0.32
stringdefsLarge = {dx * textSizeModLarge, 0.65 * (dx * textSizeModLarge), 0.002, 0}
textSizeModMid = 0.22
stringdefsMid = {dx * textSizeModMid, 0.65 * (dx * textSizeModMid), 0.002, 0}
textSizeModSmall = 0.1
stringdefsSmall = {dx * textSizeModSmall, 0.65 * (dx * textSizeModSmall), 0, 0}
