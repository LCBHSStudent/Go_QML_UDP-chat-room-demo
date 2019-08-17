package config

import (
	"fmt"
	"regexp"
	"time"
	"os"
)

const (
	START_CODE     = 1000
	LOGIN_CODE     = 1001
	SIGNIN_CODE    = 1002
	CREATE_ROOM    = 1003
	GET_MSG_CODE   = 1004
	GET_INTO_ROM   = 1005
	QUIT_THE_ROOM  = 1006
	REQ_ROOM_INFO  = 1007
	SET_SHOWYEAR   = 1008
	GET_SHOWYEAR   = 1009
)

const(
	LOGIN_SUCCESS  = 8100
	LOGIN_FAILED   = 8101
	SIGNIN_SUCCESS = 8102
	SIGNIN_FAILED  = 8103
)

//利用正则表达式压缩字符串，去除空格或制表符
func CompressStr(str string) string {
	if str == "" {
		return ""
	}
	//匹配一个或多个空白符的正则表达式
	reg := regexp.MustCompile("\\s+")
	reg2:= regexp.MustCompile("\\n+")
	str = reg.ReplaceAllString(str, "")
	return reg2.ReplaceAllString(str, "")
}

func PrintTime()(str string) {
	t  := time.Now()

	str = t.Format("2006-01-02 15:04:05")
	fmt.Println("[" + str +"]")
	return
}

func GetCurTime()(str string) {
	str = time.Now().Format("2006-01-02 15:04:05")
	str = str[11:]
	return
}

func GetCurDate()(str string) {
	str = time.Now().Format("2006-01-02 15:04:05")
	str = str[0:10]
	return
}

func checkErr(err error){
	if err != nil {
		fmt.Println(err)
		time.Sleep(time.Second)
		os.Exit(1)
	}
}

