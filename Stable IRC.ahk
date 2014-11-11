#SingleInstance,Off
if FileExist("MaeRC.ico")
	Menu,Tray,Icon,MaeRC.ico
if (A_PtrSize=8&&A_IsCompiled=""){
	SplitPath,A_AhkPath,,dir
	correct:=dir "\AutoHotkeyU32.exe"
	if !FileExist(correct){
		m("Requires AutoHotkey 1.1 to run")
		ExitApp
	}
	run,"%correct%" "%A_ScriptName%",%A_ScriptDir%
	ExitApp
	return
}
if !FileExist("scilexer.dll")
	URLDownloadToFile,http://files.maestrith.com/alpha/Studio/SciLexer.dll,Scilexer.dll
global edit,sc,settings,v:=[]
v.dcolors:={0:0xFFFFFF,1:0x0,2:0x7F0000,3:0x009300,4:0x0000FF,5:0x00007F,6:0x9C009C,7:0x007FFC,8:0x00FFFF,9:0x00FC00,10:0x939300,11:0xFFFF00,12:0xFC0000,13:0xFF00FF,14:0x7F7F7F,15:0xD2D2D2}
settings:=new xml("settings")
gui()
#Include class scintilla.ahk
#Include class socket.ahk
#Include display.ahk
#Include editservers.ahk
#Include gui.ahk
#Include hwnd.ahk
#Include msgbox.ahk
#Include notify.ahk
#Include onrecv.ahk
#Include resize.ahk
#Include send.ahk
#Include showservers.ahk
#Include socket event.ahk
#Include tv.ahk
#Include userlist.ahk
#Include xml.ahk
#Include disp.ahk
#Include Context Menu.ahk
#Include tab.ahk