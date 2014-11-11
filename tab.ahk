tab(){
	tab:
	name:=Edit.textrange(start:=Edit.2266(Edit.2008,0),end:=Edit.2267(Edit.2008,0))
	name:=end!=Edit.2008?SubStr(name,1,Edit.2008):name
	TV_GetText(chan,TV_GetSelection())
	sock:=socket.current(),list:=""
	for a in sock.channels[chan].users{
		if RegExMatch(a,"Ai)" name)||name=""
			list.=a ","
	}
	if list
		Edit.2100(Edit.2008-start,Trim(list,","))
	return
}