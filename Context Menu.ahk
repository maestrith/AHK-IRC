Context_Menu(){
	GuiContextMenu:
	MouseGetPos,,,,Control
	if (Control="SysTreeView321"){
		TV_GetText(channel,TV_GetSelection())
		sock:=socket.current()
		chan:=sock.channels[channel]
		if (chan.sc&&TV_GetParent(TV_GetSelection())){
			if InStr(channel,"#")
				sock.Send("PART " channel)
			else
				TV_Delete(TV_GetSelection())
			sock.channels.Remove(channel)
		}
	}
	return
}