class Socket{ ;socket
	static EventMsg:=0x9987,msg:=[],sockets:=[],pos:=[],TreeView:=[]
	__New(info){
		static init
		if (!init){
			DllCall("LoadLibrary","str","ws2_32","ptr"),VarSetCapacity(wsadata,394+A_PtrSize)
			DllCall("ws2_32\WSAStartup","ushort",0x0000,"ptr",&wsadata),DllCall("ws2_32\WSAStartup","ushort",NumGet(wsadata,2,"ushort"),"ptr",&wsadata)
			OnMessage(Socket.EventMsg,"SocketEvent"),init:=1
		}
		this.socket:=-1,this.users:=[]
		for a,b in info
			this[a]:=b
		this.port:=info.port?info.port:6667
		this.connect()
		Sleep,200
		if this.Password
			this.Send("PASS " this.password)
		this.Send("NICK " this.username),this.Send("USER " this.username " 0 * :" this.username)
		socket.TreeView["|" this.tv:=TV_Add(this.host,0,"Focus Select Vis")]:=this,this.sc:=sc.2375,sc.2358(0,this.sc),socket.sockets.Insert(this),sc.2051(1,0xff0000),sc.2409(1,1)
		for a,b in {modes:"",log:"",channels:"",autojoin:"",nicklist:""}{
			this[b]:=[]
			for c,d in b
				this[b,d]:=[]
		}
		this.channels[1,"tv"]:=this.tv,this.channels[1,"sc"]:=this.sc
	}
	current(){
		tv:=ei:=TV_GetSelection()
		if !sock:=socket.TreeView["|" ei]
			while,tv:=TV_GetParent(tv)
				if sock:=socket.TreeView["|" tv]
					break
		return sock
	}
	nick(old,new){
		for a,b in this.users[old]{
			this.channels[a].users[new]:=this.channels[a].users[old],this.channels[a].users.Remove(old)
			TV_Modify(b.tv,"",b.pre new),this.users[new,a]:={tv:b.tv,pre:b.pre},TV_Modify(TV_GetParent(b.tv),"Sort")
		}
		this.users.Remove(old)
		if (old=this.username)
			TV_Modify(this.tv,"",this.host " - " new),this.username:=new
	}
	quit(nick){
		if (nick=this.username)
			this.disconnect()
		Else{
			for a,b in this.users[nick]{
				this.Count(TV_GetParent(b.tv),a),TV_Delete(b.tv),this.channels[a].users.Remove(nick)
				display({msg:nick " has quit the server",chan:a,sock:this})
			}
			this.users.Remove(nick)
		}
	}
	part(info){
		part:=this.users[info.nick,info.chan]
		if (info.nick=this.username&&part.tv)
			TV_Delete(TV_GetParent(part.tv)),sc.2377(0,this.channels[info.chan].sc),this.channels.Remove(info.chan)
		Else if(part.tv)
			TV_Delete(part.tv),this.channels[info.chan].users.Remove(info.nick)
	}
	user(info){
		if (info.chan&&info.user){
			info.user:=RegExReplace(info.user,"A):"),obj:=this.channel({chan:info.chan})
			pre:=this.modes[SubStr(info.user,1,1)]?SubStr(info.user,1,1):"",name:=pre?SubStr(info.user,2):info.user
			user:=obj.users[name]:=[],tv:=TV_Add(pre name,obj.tv,"Sort")
			nick:=this.users[name,info.chan]:=[]
			nick.tv:=tv,nick.pre:=pre
			user.tv:=tv,user.pre:=pre
			GuiControl,+Redraw,SysTreeView321
		}
	}
	channel(info){
		if !obj:=this.channels[info.chan]{
			obj:=this.channels[info.chan]:=[],obj.topic:=[]
			obj.tv:=TV_Add(info.chan,this.tv,"Vis Sort"),obj.sc:=sc.2375
			if InStr(info.chan,"#")
				TV_Modify(obj.tv,"Select Vis Focus")
		}
		return obj
	}
	connect(){
		next:=this.addrinfo(this.host,this.port)
		sockaddrlen:=NumGet(next+0,16,"uint"),sockaddr:=NumGet(next+0,16+(2*A_PtrSize),"ptr")
		if !(sockaddrlen||sockaddr)
			return m("Something happened")
		this.socket:=DllCall("ws2_32\socket","int",NumGet(next+0,4,"int"),"int",1,"int",6,"ptr")
		if((r:=DllCall("ws2_32\WSAConnect","ptr",this.socket,uptr,sockaddr,int,sockaddrlen,"ptr",0,"ptr",0,"ptr",0,"ptr",0,"int"))=0){
			DllCall("ws2_32\freeaddrinfo",uptr,next)
			return Socket.Register(this,0x21)
		}
		this.disconnect()
	}
	AddrInfo(host,port){
		VarSetCapacity(hints,8*A_PtrSize,0)
		for a,b in {6:8,1:12}
			NumPut(a,hints,b)
		DllCall("ws2_32\getaddrinfo",astr,host,astr,port,"uptr",hints,"ptr*",results)
		return results
	}
	send(msg){
		msg.="`r`n"
		VarSetCapacity(buffer,length:=StrPut(msg,"utf-8")),StrPut(msg,&buffer,"utf-8")
		return:=DllCall("ws2_32\send","ptr",this.socket,"ptr",&buffer,"int",length-1,"int",0,"int")
	}
	Register(obj,msg){
		a:=SocketEvent([1]),a["|" obj.socket]:=obj
		return (DllCall("ws2_32\WSAAsyncSelect","ptr",obj.socket,"ptr",A_ScriptHwnd,"uint",Socket.EventMsg,"uint",msg)=0)?1:0
	}
	__Delete(){
		this.disconnect()
	}
	recv(){
		Critical
		VarSetCapacity(buffer,1)
		while,(ret:=DllCall("ws2_32\recv",ptr,this.socket,ptr,&buffer,int,1,int,0)>0)
			msg.=StrGet(&buffer,1,"cp0")
		VarSetCapacity(buffer,length:=StrPut(msg,"cp0")),StrPut(msg,&buffer,"cp0")
		if (msg:=StrGet(&buffer,"utf-8")){
			socket.msg.Insert({sock:this,msg:msg})
			SetTimer,Process,10
		}
	}
	disconnect(msg="I have to go"){
		this.Send("QUIT :" msg),TV_Delete(this.tv)a:=SocketEvent([1]),a.remove("|" this.socket),this:=""
		DllCall("ws2_32\WSAAsyncSelect","ptr",this.socket,"ptr",A_ScriptHwnd,"uint",0,"uint",0)=0
		DllCall("ws2_32\closesocket","ptr",this.socket,"int")
		this.socket:=-1
		return 1
	}
} ;Class Socket