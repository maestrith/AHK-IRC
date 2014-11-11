send(){
	Enter:
	ControlGetFocus,Focus,% hwnd([1])
	if (Focus="Scintilla2"){
		if !Edit.2102
			Goto Send
		Else
			Edit.2104
	}
	Return
	static rainbow:=[4,7,8,3,2,13]
	send:
	SetTimer,Send,Off
	text:=Edit.gettext(),tv:=TV_GetSelection(),Resize(),TV_GetText(channel,TV_GetSelection()),info:=StrSplit(text," "),uni:=edit.getuni()
	edit.2004
	if !text
		return
	if (info.1="/s"){
		info:=StrSplit(text," ")
		username:=info.3&&InStr(host1.1,"#")=0?info.3:"Guest"
		password:=info.4&&InStr(host1.1,"#")=0?info.4:""
		host1:=StrSplit(info.2,":")
		host:=host1.1&&InStr(host1.1,"#")=0?host1.1:"localhost",port:=host.2&&InStr(host1.1,"#")=0?host.2:6667
		sn:=settings.ssn("//*[text()='" text "']/@name").text
		servername:=sn?sn:host
		sock:=new socket({host:host,password:password,username:username,port:port,servername:servername})
		sock.autojoin:=[]
		for a,b in info
			if (SubStr(b,1,1)="#")
				sock.autojoin.Insert(b)
		Return
	}
	tv:=ei:=TV_GetSelection()
	if !sock:=socket.TreeView["|" ei]
		while,tv:=TV_GetParent(tv)
			if sock:=socket.TreeView["|" tv]
				break
	if ((chan:=sock.channels[channel])&&SubStr(text,1,1)!="/"){
		display({nick:sock.username,chan:channel,sock:sock,msg:uni})
		return sock.send("PRIVMSG " channel " :" uni	)
	}else if(info.1="/r"){
		msg:=message(info,1),count:=0,out:=""
		for a,b in StrSplit(msg){
			if(b){
				count:=++count>rainbow.MaxIndex()?1:count
				out.=Chr(3) rainbow[count] b
			}else
			out.=b
		}
		sock.Send("PRIVMSG " channel " :" out)
		display({nick:sock.username,chan:channel,sock:sock,msg:out})
	}Else if (info.1="/op"){
		return sock.Send("MODE " channel " +o " info.2)
	}Else if (info.1="/voice"){
		return sock.Send("MODE " channel " +v " info.2)
	}Else if(info.1="/bow"){
		display({nick:sock.username,chan:channel,sock:sock,msg:"***" sock.username " bows"})
		pre:="PRIVMSG " channel " :"
		text:=chr(1) "ACTION bows" chr(1)
		sock.send(pre text)
	}Else if(info.1="/me"){
		display({nick:sock.username,chan:channel,sock:sock,msg:uni})
		pre:="PRIVMSG " channel " :"
		text:=chr(1) "ACTION " message(info,1) chr(1)
		sock.send(pre text)
	}Else if (info.1="/afk"){
		for a,sock in socket.sockets{
			if pos:=InStr(sock.username,"_",0,0){
				nick:=SubStr(sock.username,1,pos-1)
				new:=info.2?"_" info.2:""
				sock.send("NICK " nick new)
			}else{
				new:=info.2?"_" info.2:"_afk"
				sock.send("NICK " sock.username new)
			}
		}
		return
	}Else if (info.1="/msg"){
		sock.channel({chan:info.2})
		display({nick:sock.username,chan:info.2,sock:sock,msg:message(info)})
		return sock.send("PRIVMSG " info.2 " :" message(info))
	}else if(info.1="/joinauto"){
		for a,b in sock.autojoin
			sock.send("JOIN " b)
	}Else if (info.1="/topic"){
		sock.send("TOPIC " channel " :" message(info,1))
	}Else if (TV_GetParent(TV_GetSelection())=0&&SubStr(text,1,1)!="/"){
		display({sock:sock,msg:text})
		return sock.send(text)
	}Else if (text="/p"){
		return sock.send("PART " channel)
	}Else if (SubStr(text,1,1)="/"){
		if (info.1="/count"){
			count:=1,tv:=TV_GetChild(TV_GetSelection())
			while,tv:=TV_GetNext(tv)
				count++
			m("There are currently " count " users in the channel")
		}
		if (info.1="/nick")
			return sock.send("NICK " info.2)
		if ((info.1="/Join"||info.1="/j")){
			for a,b in info
				if (A_Index>1&&b!="")
					sock.send("JOIN " _:=InStr(b,"#")?b:"#" b)
			return
		}Else
		return sock.Send(SubStr(uni,2))
	}
	return
}
message(info,count=2){
	for a,b in info
		if (A_Index>count&&b)
			msg.=b " "
	return msg
}