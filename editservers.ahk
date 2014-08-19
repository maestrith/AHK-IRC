editserver(){
	Gui,2:Default
	Gui,Margin,2,2
	Gui,+Owner1
	Gui,Font,,Consolas
	Gui,Add,ListView,w510 r8 Grid ReadOnly,Server Name|Address (/s irc.freenode.net [username password #channel1 #channel2])
	Gui,Add,Button,gadd Default,Add
	Gui,Add,Button,x+10 gedit Default,Edit
	Gui,Add,Button,x+10 gdelete,Delete
	gosub,populate
	Gui,Show,,Server List
	return
	populate:
	serv:=settings.sn("//networks/*"),LV_Delete()
	Gui,2:Default
	while,ss:=serv.item[A_Index-1]
		LV_Add("",ssn(ss,"@name").text,ss.text)
	Loop,2
		LV_ModifyCol(A_Index,"AutoHDR")
	LV_Modify(1,"Select Vis Focus")
	return
	add:
	InputBox,server,Server Nickname,Input a name to associate with this server,,275,150
	if (ErrorLevel||server="")
		return
	InputBox,string,Server String,eg. /s irc.freenode.net [username password #channel1 #channel2...],,450,150
	if (ErrorLevel||server="")
		return
	settings.add({path:"networks/network",att:{name:server},text:string,dup:1})
	goto,populate
	return
	2GuiEscape:
	2GuiClose:
	settings.save(1)
	Gui,2:Destroy
	return
	edit:
	LV_GetText(value,LV_GetNext(),2),LV_GetText(server,LV_GetNext())
	InputBox,newval,Edit The Server Value,New Value,,600,100,,,,,%value%
	if (ErrorLevel||server="")
		return
	settings.ssn("//network[@name='" server "']").text:=newval
	goto populate
	return
	Delete:
	MsgBox,308,Are you sure?,Can not be undone!
	IfMsgBox,No
		return
	while,next:=LV_GetNext()
		LV_GetText(rem,next),rem:=settings.ssn("//network[@name='" rem "']"),rem.ParentNode.RemoveChild(rem),LV_Delete(next)
	return
}