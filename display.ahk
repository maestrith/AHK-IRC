display(info){
	type:="msg",channel:=info.sock.channels[info.chan],nick:=info.nick?"<" info.nick "> ":"",sock:=info.sock
	GuiControl,-Redraw,% sc.sc
	if (channel.sc!=sc.2357){
		msg:=nick info[type]
		if TV_GetParent(channel.tv)
			TV_Modify(channel.tv,"bold")
		if !log:=sock.Log["|" channel.tv]
			log:=sock.Log["|" channel.tv]:=[]
		VarSetCapacity(buffer,length:=StrPut(msg,"cp0")),StrPut(msg,&buffer,"cp0")
		log.Insert({time:"[" A_Hour ":" A_Min ":" A_Sec "]",msg:StrGet(&buffer,"utf-8")})
	}Else{
		start:=sc.2006
		msg:=sc.2006?"`n" nick info[type]:nick info[type]
		sc.2171(0),sc.2003(sc.2006,msg),sc.2171(1)
		if msg contains http:,https:,ftp:,.com,.net,.gov,.org,www
		for a,b in StrSplit(msg," "){
			if b contains http:,https:,ftp:,.com,.net,.gov,.org,www
				sc.2032(start+InStr(msg,b)-1),sc.2033(StrLen(Trim(b,"`t")),1)
		}
		line:=sc.2166(sc.2006)
		sc.2530(line,"[" A_Hour ":" A_Min ":" A_Sec "]")
	}
	if (info.chan!=1&&InStr(info.chan,"#"))
		if !sock.users[info.nick,info.chan]
			sock.user({chan:info.chan,user:info.nick})
	ControlGetFocus,Focus,% hwnd([1])
	if (Focus!="Scintilla1")
		SetTimer,End,100
	Else
		GuiControl,+Redraw,% sc.sc
	return
	end:
	SetTimer,End,Off
	sc.2318()
	GuiControl,+Redraw,% sc.sc
	return
}