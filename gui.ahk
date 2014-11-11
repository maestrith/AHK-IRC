gui(){
	Gui,+hwndhwnd +Resize
	Hotkey,IfWinActive,ahk_id%hwnd%
	Hotkey,^k,color,On
	Hotkey,+Escape,grab,On
	Hotkey,f1,bold,On
	Hotkey,^i,italic,On
	Gui,Margin,2,2
	Gui,Add,StatusBar,hwndstatus
	ControlGetPos,,,,h,,ahk_id%status%
	v.statush:=h
	Gui,Add,TreeView,w150 h500 gtv +0x20
	sc:=new s(1,{pos:"x+2 w500 h500"}),edit:=new s(1,{pos:"xm w652 h23 y+2"}),OnMessage(5,"Resize"),edit.2242(1,0)
	edit.2171(0),Edit.2400,Edit.2013
	Edit.2037(65001)
	Edit.2115(1),Edit.2634(1),Edit.2660(2),edit.2110(1)
	sc.2171(0),sc.2181(0,"¯\_(ツ)_/¯"),sc.2171(1) ;Help:`n`tType / and then things happen.
	Edit.2112(0,":") ;¯\_(ツ)_/¯
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
	color:
	Send,% Chr(3)
	return
	grab:
	edit.2054(43,1)
	VarSetCapacity(text,40)
	for a,b in StrSplit("ツ"){ ;(ツ)_/¯
		add:=-1
		length:=VarSetCapacity(t,StrPut(b,"utf-8"))
		StrPut(b,&t,length,"utf-8")
		str:=StrGet(&t,length,"utf-8")
		NumPut(Chr(b),text,(A_Index+add)*2,"ushort")
		NumPut(42,text,(A_Index+add)*2+1,"int")
		size:=(A_Index+add)*2+1
	}
	NumPut(0,text,size+1)
	;NumPut(0,text,size+2)
	edit.2002(size+1,&text)
	;edit.2002(8,&flan)
	sleep,500 ;+1000
	ExitApp
	return
	/*
	*/
	/*
		;this works
	*/
	ControlSend,Scintilla1,^a,ahk_id%hwnd%
	sc.2013
	end:=sc.2008>sc.2009?sc.2008:sc.2009
	start:=sc.2008<sc.2009?sc.2008:sc.2009
	wparam:=end,lparam:=start
	VarSetCapacity(text,(Abs(end-start)*2)+2),VarSetCapacity(textrange,12,0),NumPut(lparam,textrange,0)
	,NumPut(wparam,textrange,4),NumPut(&text,textrange,8)
	info:=sc.2015(0,&textrange)
	/*
		Loop,% end-start
		{
			m(num:=NumGet(&text,A_Index-1,"uptr"),StrGet(num,"utf-8"))
		}
	*/
	while,num:=NumGet(&text,A_Index-1)
		m(num)
	;m(Clipboard:=NumGet(&text,A_Index-1))
	edit.2002(info,&text)
	sleep,2000
	ExitApp
	Return
	bold:
	
	;edit.2032(0),edit.2033(5,42)
	return
	italic:
	stripurl(Chr(2) "hello")
	return
}