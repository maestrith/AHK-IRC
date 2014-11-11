stripurl(text){
	static flip:={29:1,2:2,31:4,15:0}
	sss:=40,style:=0,pos:=0
	ss:=strsplit(text,[Chr(29),Chr(2),Chr(31),Chr(15),Chr(3)])
	for a,b in ss{
		pos+=StrPut(b,"utf-8")
		if (code=3){
			RegExMatch(b,"^(\d*),?(\d*)?",color)
			if (color1=""){
				color2:=""
				end:=addtext(b,style+40),sss:=style+40
			}else{
				b:=SubStr(b,StrLen(color)+1)
				startstyle:=color1*8+48
				if (sc.2484(startstyle+1)=0)
					addstyles(color1),addstyles(color1)
				addstyles(color1),addstyles(color1)
				end:=addtext(b,color1*8+48+style,color2),sss:=color1*8+48+style
			}
		}else{
			ss:=flip[code]
			if !ss
				style:=0
			else
				style:=style&ss?style-ss:style|=ss
			sss:=mod(sss,8)>style?sss-mod(sss,8)+style:sss|=style
			end:=addtext(b,sss,color2)
		}
		code:=Asc(SubStr(text,pos,1))
		if (sc.sc!=input.sc){
			url:=strsplit(b," "),add:=0
			for c,tt in url{
				if (tt~="(http|ftp|.com|.net|.gov|.org|mailto|.co.uk|.biz)"){
					RegExMatch(tt,"i)(http.*)",url),actualurl:=url1,more:=InStr(tt,actualurl)
					sc.2032(end+add+more-1,255),sc.2033(StrLen(actualurl),1)
				}
				add+=StrPut(tt,"utf-8")
			}
		}
	}
}
addtext(text,style,indic=""){
	sc.2171(0),end:=sc.2006,sc.2282(StrPut(text,"utf-8")-1,text)
	sc.2032(end,255),sc.2033(StrPut(text,"utf-8")-1,style)
	if indic between -1 and 16
		sc.2500(indic),sc.2504(end,StrPut(text,"utf-8")-1)
	if (sc.sc!=input.sc)
		sc.2171(1)
	return end
}
addstyles(color){
	if !IsObject(v.addedstyles)
		v.addedstyles:=[]
	if color=""
		return
	cc:=v.dcolors[color],offset:=(color*8)+48 ;ea:=settings.ea("//style[@style='0']")
	ea:={font:"Consolas",background:0xffffff,size:12}
	for a,b in [sc,edit]{
		b.2051(offset,cc),b.2056(offset,ea.font),b.2052(offset,ea.background),b.2055(offset,ea.size)
		Loop,7
		{
			total:=A_Index
			b.2051(offset+total,cc),b.2056(offset+total,ea.font),b.2052(offset+total,ea.background),b.2055(offset+total,ea.size)
			for c,d in {1:2054,2:2053,4:2059}
				if (total&c)
					b[d](offset+total,1),v.addedstyles.Insert(offset+total)
		}
	}
}
disp(a,b,c){
	if (end:=sc.2006){
		sc.2171(0)
		sc.2003(end,"`n")
		sc.2171(1)
	}
	stripurl(a c.msg)
	sc.2530(sc.2166(sc.2006),b)
}