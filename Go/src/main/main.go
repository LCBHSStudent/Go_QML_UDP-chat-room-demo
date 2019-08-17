package main

import (
   "../config"
   "../dataHandle"
   "fmt"
   "net"
)

func NewMessage(conn *net.UDPConn, n int, rAddr *net.UDPAddr, buf []byte, err error) {
   if err != nil {
      fmt.Println("conn.ReadFromUDP err:", err)
      return
   }
   config.PrintTime()
   dataHandle.HandleMsg(buf[:n], conn, rAddr)
	//_, _ = conn.WriteToUDP([]byte(string(buf[0:4])+" Message Received!"), rAddr) // 简单回写数据给客户端
}

var Running bool

func main() {
   Running = true
   // 创建 服务器 UDP 地址结构。指定 IP + port
   dataHandle.Connect()
   defer dataHandle.Close()

   syncChan := make(chan struct{}, 1)
   lAddr, err := net.ResolveUDPAddr("udp", "0.0.0.0:8848")
   if err != nil {
      fmt.Println("ResolveUDPAddr err:", err)
      return
   }
   // 监听 客户端连接
   conn, err := net.ListenUDP("udp", lAddr)

   if err != nil {
      fmt.Println("net.ListenUDP err:", err)
      return
   }
   defer conn.Close()

   for {
      buf := make([]byte, 2048)
      n, rAddr, err := conn.ReadFromUDP(buf)
      //fmt.Println(n, buf)
      go NewMessage(conn, n, rAddr, buf, err)
      if !Running {
      	syncChan <- struct{}{}
      	break
      }
   }

	<-syncChan
}