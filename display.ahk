display(info){ 
	type:="msg",channel:=info.sock.channels[info.chan],nick:=info.nick?"<" info.nick "> ":"",sock:=info.sock
	time:="[" A_Hour ":" A_Min ":" A_Sec "]"
	GuiControl,-Redraw,% sc.sc
	if (channel.sc!=sc.2357){
		msg:=nick info[type]
		if TV_GetParent(channel.tv)
			TV_Modify(channel.tv,"bold")
		if !log:=sock.Log["|" channel.tv]
			log:=sock.Log["|" channel.tv]:=[]
		VarSetCapacity(buffer,length:=StrPut(msg,"cp0")),StrPut(msg,&buffer,"cp0")
		log.Insert({time:time,info:info,nick:nick})
	}Else{
		GuiControl,-Redraw,% sc.sc
		disp(nick,time,info)
		GuiControl,+Redraw,% sc.sc
	}
	if (info.chan!=1&&InStr(info.chan,"#"))
		if !sock.users[info.nick,info.chan]
			sock.user({chan:info.chan,user:info.nick})
	ControlGetFocus,Focus,% hwnd([1])
	if (Focus!="Scintilla1")
		SetTimer,End,-100
	Else
		GuiControl,+Redraw,% sc.sc
	return
	end:
	sc.2318()
	GuiControl,+Redraw,% sc.sc
	return
}