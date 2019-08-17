package chatRoom

import (
	"../chain"
	"time"
)

type Chat interface {
	Start(id string)
	Destroy()
	Join()
	Quit()
}

type ChatRoom struct {
	headNode *chain.LinkNode
	roomId string
	memberCnt uint
	ticker *time.Ticker
}

func (c *ChatRoom) Start(id string) {
	c.headNode = chain.New()
	c.memberCnt = 0
	c.roomId = id
	c.ticker = time.NewTicker(time.Minute * 5)

}
