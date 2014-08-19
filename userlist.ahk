userlist(pre="",space=1){
	static prefix
	prefix:=pre
	if space
		SetTimer,addspace,10
	SetTimer,userlist,100
	return
	userlist:
	SetTimer,userlist,Off
	sock:=socket.current()
	TV_GetText(channel,TV_GetSelection()),userlist:=""
	search:=StrSplit(prefix),list:=[]
	for a,b in sock.channels[channel].users{
		if (prefix){
			for c,d in StrSplit(prefix,","){
				info:=StrSplit(d)
				if ((InStr(b.pre,info.2)&&info.1=",")||(InStr(b.pre,info.2)=0&&info.1="+"))
					goto nope
			}
			userlist.=a ","
			nope:
		}
		Else
			userlist.=a ","
	}
	if (v.list:=list:=Trim(userlist,","))
		Edit.2100(0,list),userlist:=""
	return list
}