Process(){
	static monitor:=[]
	process:
	info:=socket.msg.1,sock:=info.sock,channel:=1
	for a,b in StrSplit(info.msg,"`r`n"){
		if !b
			Continue
		message:=SubStr(b,InStr(b," :")+2),info:=StrSplit(b," "),RegExMatch(b,"OU):(.*)!",nick)
		if (info.2="005"){
			if InStr(b,"prefix"){
				RegExMatch(b,"OU)PREFIX=\((.*) ",prefix),vv:=StrSplit(prefix.value(1),")"),value:=StrSplit(vv.2)
				for a,c in StrSplit(vv.1)
					sock.modes[c]:=value[A_Index],sock.modes[value[A_Index]]:=c
				order:=sock.modes.order:=[]
				for a,c in StrSplit(vv.1)
					order[c]:=StrSplit(vv.2)[A_Index]
			}
		}
		if (info.2="mode"){
			;mode=4 chan=3 user=5 nick.1=who gave it.
			for a,b in StrSplit(info.4){
				if b in +,-
					operation:=b
				Else{
					user:=sock.channels[info.3].users[info.5]
					if (operation="+")
						user.pre.=sock.modes[b]
					Else
						user.pre:=RegExReplace(user.pre,"i)" sock.modes[b])
					sock.users[info.5,info.3].pre:=sock.modes[b]
				}
			}
			pre:=user.pre
			if (StrLen(pre)>1){
				for a,b in sock.modes.order
				if InStr(pre,b){
					pre:=b
					break
				}
			}
			TV_Modify(user.tv,"",pre info.5),TV_Modify(TV_GetParent(user.tv),"Sort")
		}
		if (info.2=433)
			sock.send("NICK " sock.username A_MSec)
		if (info.2=1)
			TV_Modify(sock.tv,"",sock.host " - " sock.username:=info.3)
		if (info.2="nick"){
			info.3:=RegExReplace(info.3,"A):")
			if check is not number
				sock.nick(nick.1,info.3)
		}
		if (info.2="part")
			sock.part({nick:nick.1,chan:info.3}),display({msg:nick.1 " has left the channel",chan:info.3,sock:sock})
		if (info.2="kick")
			sock.part({nick:info.4,chan:info.3}),display({msg:info.4 " was kicked from the channel",chan:info.3,sock:sock})
		if (info.2=353)
			for a,user in StrSplit(message," ")
				if user
					sock.user({chan:info.5,user:user})
		if (info.2="quit")
			sock.quit(nick.1,message)
		if (info.2="join"){
			if (nick.1!=sock.username){
				sock.user({chan:chan:=RegExReplace(info.3,"A):"),user:nick.1})
				display({msg:nick.1 " has joined the channel",chan:chan,sock:sock})
			}
		}
		if (info.2="topic"){
			topic:=sock.channels[info.3].topic:=message
			TV_GetText(cc,TV_GetSelection())
			if (cc=info.3)
				WinSetTitle,% hwnd([1]),,% "IRC - " cc " : " topic
			display({msg:"New Topic: " topic,chan:cc,sock:sock,nick:nick.1})
		}
		if (info.2=332)
			obj:=sock.channel({chan:info.4}).topic:=message
		if (info.2="730"){
			uz:=""
			for c,d in StrSplit(message,",")
				monitor[StrSplit(d,"!").1]:=1
			for c in monitor
				uz.=c ","
			SB_SetText(Trim(uz,","))
		}else if(info.2="731"),uz:=""{
			for c,d in StrSplit(message,",")
				monitor.Remove(d)
			for c in monitor
				uz.=c ","
			SB_SetText(Trim(uz,","))
		}
		if (info.2~="376|422"){
			for a,b in sock.autojoin
				sock.send("JOIN " b)
			if userlist:=settings.ssn("//monitor").text
				sock.Send("MONITOR + " userlist)
		}
		if (info.1="ping")
			sock.Send("PONG :" message)
		if (info.2="privmsg"){
			channel:=info.3,TV_GetText(ch,TV_GetSelection())
			if (InStr(message,sock.username)||(channel=sock.username)){
				if (ch!=channel||WinActive(hwnd([1]))=0)
					SetTimer,flash,1000
				FileAppend,% A_Now "-" message "`r`n",messages.txt
			}
			if !InStr(channel,"#")
				sock.channel({chan:channel:=nick.1})
		}
		FileAppend,%b%`r`n,log.txt
		display({msg:message,chan:channel,sock:sock,nick:nick.1})
	}
	socket.msg.Remove(1)
	if !(socket.msg.1.msg)
		SetTimer,Process,Off
	return
}
flash:
ControlGetFocus,Focus,% hwnd([1])
Gui,Flash
if (Focus="Scintilla2")
	SetTimer,flash,Off
return