showservers(){
	showservers:
	SetTimer,showservers,Off
	list:=settings.sn("//networks/*"),servers:=""
	while,ll:=List.item[A_Index-1]
		servers.=ssn(ll,"@name").text ","
	Edit.2004
	if Edit.2008=0
		Edit.2100(0,Trim(servers,","))
	return
}