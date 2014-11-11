tv(){
	tv:
	if (A_GuiEvent!="s")
		return
	tv:=TV_GetSelection(),ei:=A_EventInfo,TV_GetText(channel,ei),TV_Modify(ei,"-bold")
	sock:=socket.current()
	GuiControl,-Redraw,% sc.sc
	channel:=TV_GetParent(ei)?channel:1
	channel:=sock.channels[channel]
	if (channel.sc){
		sc.2358(0,channel.sc)
		Sleep,100
		sc.2051(1,0xff0000),sc.2409(1,1)
		while,(b:=sock.Log["|" ei].1){
			disp(b.nick,b.time,b.info)
			sock.Log["|" ei].Remove(1)
		}
	}
	if !sc.2137
		sc.2037(65001)
	SetTimer,end,-10
	Edit.2400(),TV_GetText(channel,ei),topic:=sock.channels[channel].topic
	if (InStr(channel,"#")&&TV_GetParent(ei)){
		topic:=Trim(topic)?" : " topic:""
		WinSetTitle,% hwnd([1]),,% "IRC - " channel topic
	}
	Else if InStr(channel,"#")
		WinSetTitle,% hwnd([1]),,IRC - %channel%
	Else
		WinSetTitle,% hwnd([1]),,% "IRC - " sock.host
	return
}