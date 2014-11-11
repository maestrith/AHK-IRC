resize(a="",b=""){
	static width,height,sizes:=[]
	if (a="save"){
		WinGetPos,x,y,,,% hwnd([1])
		return settings.Add({path:"gui",text:"x" x " y" y " w" width "h" height})
	}
	if (A_Gui!=1&&a!="")
		return
	if b&0xffff
		width:=b&0xffff,height:=b>>16
	hh:=Edit.2279(32),lines:=Edit.2154,total:=0
	Loop,%Lines%
		total+=Edit.2235(A_Index-1)
	editheight:=hh*total+3,editheight:=height-50<editheight?height-50:editheight
	socket.pos.width:=width,socket.pos.height:=height
	ControlMove,SysTreeView321,,,,% height-Editheight-6-v.statush,% hwnd([1])
	ControlMove,,,,width-156,% height-Editheight-6-v.statush,% "ahk_id" sc.sc
	ControlMove,Scintilla2,,% height-editheight+29-v.statush,width-4,%editheight%,% hwnd([1])
	GuiControl,+Redraw,% sc.sc
}