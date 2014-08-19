SocketEvent(info*){
	Critical
	static a:=[]
	if info.1.1
		return a
	if (info.3=socket.EventMsg){
		if (info.2&0xFFFF=1){
			a["|" info.1].recv()
			/*
				if msg:=a["|" info.1].recv(){
					a[info.1].msg.Insert(msg)
					SetTimer,process,10
				}
			*/
			return
		}
		if (info.2&0xFFFF=32)
			return a["|" info.1].disconnect()
	}
}