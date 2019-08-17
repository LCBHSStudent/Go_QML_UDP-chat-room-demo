package chain

import (
	"fmt"
)

type Elem interface {}

type LinkNode struct {
	Data interface{}
	Next *LinkNode
}
//生成头节点
func New() *LinkNode {
	return &LinkNode{0, nil}
}

func (head *LinkNode) Add(elem *LinkNode) bool {
	if head.Next != nil {
		elem.Next = head.Next
	}
	head.Next = elem
	return true
}

//在位置i前插入一个元素 o(n)
func (head *LinkNode) Insert(i int, e Elem) bool {
	p := head
	j := 1
	for nil != p && j < i {
		p = p.Next
		j++
	}
	if nil ==p || j > 1 {
		fmt.Println("plz check i:", i)
		return false
	}
	s := &LinkNode{Data: e}
	s.Next = p.Next
	p.Next = s
	return true
}

func (head *LinkNode) Traverse() {
	point := head.Next
	for nil != point {
		fmt.Println(point.Data)
		point = point.Next
	}
	fmt.Println("---------------done--------------")
}

//删除第I个节点
func (head *LinkNode) Delete(i int) bool {
	point := head
	j     := 1
	for nil != point && j < i {
		 point = point.Next
		 j++
	}
	if nil == point || j > i {
		fmt.Println("Plz check i:", i)
		return false
	}
	//temp := point.Next.Next --go自动垃圾回收？
	point.Next = point.Next.Next
	return true
}

func (head * LinkNode) Get(i int) Elem {
	p := head.Next
	for j:=1; j<i; j++ {
		if nil == p {
			return -100001
		}
		p = p.Next
	}
	return p.Data
}
