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
notify(){
	static lastword,lastnick,lasttv,lastlines,modelist:={op:"-@",msg:"",voice:"-@,-+"},users
	notify:
	if !IsObject(fn)
		fn:=[]
	for a,b in {0:"Obj",2:"Code",3:"position",4:"ch",5:"mod",6:"modType",7:"text",8:"length",9:"linesadded",10:"msg",11:"wparam",12:"lparam",13:"line",14:"fold",22:"updated"}
		fn[b]:=NumGet(A_EventInfo+(A_PtrSize*a))
	if(fn.code=2027){
		start:=end:=sc.2008
		while,sc.2010(start)=1
			start--
		while,sc.2010(end)=1
			end++
		url:=sc.textrange(start+1,end)
		Run,% url
	}
	if(fn.code=2004)
		Edit.2400
	if(fn.code=2001){
		info:=Edit.gettext(),start:=edit.2266(edit.2008,0)
		lastword:=Trim(SubStr(info,start+1,Edit.2008))
	}
	if(fn.code=2022){
		text:=StrGet(fn.text,"utf-8"),net:=settings.ssn("//networks/network[@name='" text "']").text
		TV_GetText(channel,TV_GetSelection())
		if(net)
			edit.2101(),Edit.2181(0,net),Send()
		Else if InStr(v.list,text){
			v.list:=""
			SetTimer,addspace,10
		}
		Else if text in bow,count
			edit.2101(),edit.2181(0,"/" text),Send()
		Else if(text="help")
			edit.2101(),Edit.2004(),m("Coming....eventually")
		Else if(text="server")
			SetTimer,showservers,1
		Else if(text="edit server list")
			edit.2004(),editserver()
		Else if(text="exit")
			SetTimer,GuiClose,1
		Else if(modelist.haskey(text))
			userlist(modelist[text])
		Else if(socket.current().channels[channel].users[text].tv){
			tt:=edit.gettext(),info:=StrSplit(tt," ").1
			if info in /op,/deop,/voice,/devoice
				SetTimer,send,10
		}
		Else
			SetTimer,addspace,10
	}
	if(fn.code=2025){
		if(edit.2103=edit.2008){
			text:=Trim(SubStr(edit.gettext(),2))
			if(modelist.haskey(text))
				userlist(modelist[text],0)
		}
		return
	}
	if(fn.code=2008){
		lines:=Edit.2154,total:=0
		Loop,%Lines%
			total+=Edit.2235(A_Index-1)
		if(total!=lastlines)
			Resize()
		lastlines:=total,text:=edit.gettext()
		if(SubStr(text,1,7)="/server"&&Edit.2008=1)
			SetTimer,showservers,1
	}
	if(fn.code=2001){
		text:=edit.gettext(),count:=""
		if(edit.2007(edit.2008-1)=46&&edit.2007(edit.2008-2)=47){
			Gui,2:Destroy
			Gui,2:Default
			Gui,Add,ListView,w200 r5,Insert
			Gui,Add,Button,ginsrt Default,Insert
			for a,b in StrSplit(FileOpen("silly.ini",0).Read(),"`n")
				if b
					LV_Add("",Trim(b,"`r"))
			LV_Modify(1,"Select Vis Focus")
			Gui,Show
		}
		if(SubStr(text,1,1)!="/"||InStr(text," ")!=0)
			return
		tt:=StrSplit(text,"/").2
		cmds:="Server,afk,me,msg,Join,Op,Voice,DeOp,DeVoice,Topic,Nick,Help,Edit Server List,Exit,bow,Count"
		for a,b in StrSplit(cmds,",")
			if(SubStr(b,1,StrLen(tt))=tt)
				count.=b ","
		if !Count
			return
		if Edit.2102=0
			Edit.2181(0,"/"),Edit.2025(1),Edit.2100(0,cmds)
		RegExReplace(count,",","",cc)
		if(cc=1){
			edit.2108(0,Trim(count,","))
			if net:=settings.ssn("//network[@name='" Trim(count,",") "']").text
				Edit.2181(0,net),Send()
			edit.2104
		}
	}
	return
	addspace:
	SetTimer,addspace,Off
	Edit.2003(edit.2006," ")
	edit.2025(edit.2006)
	return
	insrt:
	LV_GetText(insert,LV_GetNext()),Edit.2645(edit.2008-2,2),Edit.2003(edit.2008,Insert),edit.2318
	Gui,2:Destroy
	return
}