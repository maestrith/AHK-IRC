class s{
	static ctrl:=[],lc:="",main:=[]
	__New(window,info){
		static int
		if !init
			DllCall("LoadLibrary","str","scilexer.dll"),init:=1
		win:=window?window:1
		static count=1
		pos:=info.pos?info.pos:"x0 y0"
		if info.hide
			pos.=" Hide"
		notify:=info.label?info.label:"notify"
		Gui,%win%:Add,custom,classScintilla hwndss w500 h400 %pos% +1387331584 g%notify%
		this.sc:=ss,s.ctrl[ss]:=this,t:=[]
		for a,b in {fn:2184,ptr:2185}
			this[a]:=DllCall("SendMessageA","UInt",ss,"int",b,int,0,int,0)
		this.2171(1),this.2268(3),width:=this.2276(32,"[00:00:00]")
		this.2242(1,width),this.2240(1,4),this.2056(32,"Consolas"),this.2050,this.2037(65001)
		this.2077(0,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ|_+`0123456789")
		this.2106(44),this.2118(0),this.2110(0)
		this.2053(42,1)
		loop,16
			b:=A_Index-1,this.2080(b,8),this.2082(b,v.dcolors[A_Index-1]),this.2523(b,255),this.2510(b,1),this.2558(b,255)
		return this
	}
	delete(x*){
		if s.main.MaxIndex()=1
			return m("Can not delete the last control")
		this:=x.1
		for a,b in s.main{
			if (b.sc=this.sc)
				s.main.remove(a)
		}
		DllCall("DestroyWindow",uptr,this.sc)
	}
	__Delete(x*){
		m("should not happen")
	}
	__Get(x*){
		return DllCall(this.fn,"Ptr",this.ptr,"UInt",x.1,int,0,int,0,"Cdecl")
	}
	__Call(code,lparam=0,wparam=0){
		if (code="getseltext"){
			VarSetCapacity(text,this.2161),length:=this.2161(0,&text)
			return StrGet(&text,length,"cp0")
		}
		if (code="textrange"){
			VarSetCapacity(text,abs(lparam-wparam)),VarSetCapacity(textrange,12,0),NumPut(lparam,textrange,0),NumPut(wparam,textrange,4),NumPut(&text,textrange,8)
			this.2162(0,&textrange)
			return strget(&text,"","cp0")
		}
		if (code="getline"){
			length:=this.2350(lparam)
			cap:=VarSetCapacity(text,length,0),this.2153(lparam,&text)
			return StrGet(&text,length,"cp0")
		}
		if (code="gettext"){
			cap:=VarSetCapacity(text,vv:=this.2182),this.2182(vv,&text),t:=strget(&text,vv,"cp0")
			return t
		}
		if (code="getuni"){
			cap:=VarSetCapacity(text,vv:=this.2182),this.2182(vv,&text),t:=StrGet(&text,vv,"utf-8")
			return t
		}
		if wparam is number
			info:=DllCall(this.fn,"Ptr",this.ptr,"UInt",code,"int",lparam,int,wparam,"Cdecl")
		Else{
			VarSetCapacity(buffer,length:=StrPut(wparam,"utf-8")),StrPut(wparam,&buffer,"utf-8")
			info:=DllCall(this.fn,"Ptr",this.ptr,"UInt",code,"int",lparam,uptr,&buffer,"Cdecl")
		}
		return info
	}
	show(){
		GuiControl,+Show,% this.sc
	}	
}