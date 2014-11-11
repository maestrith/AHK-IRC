SocketEvent(info*){
	Critical
	static a:=[]
	if info.1.1
		return a
	if (info.3=socket.EventMsg){
		if (info.2&0xFFFF=1)
			return a["|" info.1].recv()
		if (info.2&0xFFFF=32)
			return a["|" info.1].disconnect()
	}
}