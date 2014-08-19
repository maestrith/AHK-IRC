#SingleInstance,Force
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
settings:=new xml("settings")
Gui()
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