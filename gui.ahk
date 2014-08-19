gui(){
	Gui,+hwndhwnd +Resize
	Gui,Margin,2,2
	Gui,Add,TreeView,w150 h500 gtv +0x20
	sc:=new s(1,{pos:"x+2 w500 h500"}),edit:=new s(1,{pos:"xm w652 h23 y+2"}),OnMessage(5,"Resize"),edit.2242(1,0)
	edit.2171(0),Edit.2400,Edit.2013
	Edit.2037(65001)
	Edit.2115(1),Edit.2634(1),Edit.2660(2),edit.2110(1)
	sc.2171(0),sc.2181(0,"Help:`n`tType / and then things happen."),sc.2171(1)
	Edit.2112(0,":")
	Hotkey,IfWinActive,% hwnd(1,hwnd)
	for a,b in ["Escape","Enter","Tab","Alt"]
		Hotkey,%b%,%b%,On
	ControlGetPos,,,,h,,ahk_id%status%
	OnExit,GuiClose
	Gui,Show,% settings.ssn("//gui").text,IRC
	GuiControl,+Redraw,edit.sc
	Resize()
	return
	Escape:
	if Edit.2102
		return Edit.2101
	tv:=0,found:=0
	while,tv:=TV_GetNext(tv,"F")
	if TV_Get(tv,"bold"){
		TV_Modify(tv,"Select Vis Focus"),found:=1
		Break
	}
	if !(found){
		Loop,2
		{
			tv:=A_Index=1?TV_GetSelection():0
			while,tv:=TV_GetNext(tv,"F")
			if (TV_GetParent(tv)!=0&&TV_GetParent(TV_GetParent(tv))=0){
				TV_Modify(tv,"Select Vis Focus")
				Break 2
			}
		}
	}
	return
	GuiEscape:
	GuiClose:
	for a,b in socket.sockets
		b.sendtext("QUIT :Gotta Go")
	Resize("Save")
	settings.save(1)
	ExitApp
	return
	Alt:
	return
}