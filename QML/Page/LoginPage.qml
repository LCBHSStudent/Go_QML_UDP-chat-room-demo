import QtQuick 2.12
import QtQuick.Controls 2.12
import "../Component"

Page {
    id: loginPage
    Rectangle {anchors.fill: parent; color: "#000"}
    
    Rectangle {
        id: head
        width: dp(70);
        height: width * 0.4
        anchors {
            top: parent.top
            topMargin: dp(10)
            horizontalCenter: parent.horizontalCenter
        }
        color: "transparent"
        
        Row {
            anchors.centerIn: parent
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "鸿蒙"
                color: "#FFF"
                font{
                    bold: true
                    family: "微软雅黑"
                    pixelSize: dp(10)
                }
            }
            Rectangle {
                width: inner.width + dp(5)
                height: inner.height + dp(5)
                color: "#F90"
                radius: dp(2)
                Text {
                    id: inner
                    text: "Space"
                    color: "#000"
                    anchors.centerIn: parent
                    font {
                        bold: true
                        family: tintFnt
                        pixelSize: dp(10)
                    }
                }
            }
        }
    }
    Column {
        id: col;
        width: parent.width * 0.95;
        height: width;
        anchors{
            top: head.bottom;
            topMargin: dp(20);
            horizontalCenter: parent.horizontalCenter;
        }
        spacing: dp(3.8);
        EditText {
            id: userCode;
            width: parent.width;
            height: dp(9);
            icon: "../assets/mdpi/ic_login_code.png";
            placeholderText: " HOMo ID";
            validator: RegExpValidator {regExp: /^[0-9]*$/}
        }
        EditText {
            id: userId;
            width: parent.width;
            height: dp(9);
            icon: "../assets/mdpi/ic_login_user.png";
            placeholderText: " HOMo Nickname";
            validator: RegExpValidator {regExp: /^\w*$/}
        }
        EditText {
            id: userPsw;
            width: parent.width;
            height: dp(9);
            icon: "../assets/mdpi/ic_login_psw.png";
            placeholderText: " Password";
            validator: RegExpValidator {regExp: /^\w*$/}  //限制输入类型的正则式
            echoMode: TextInput.Password; //设定输入模式为密码
        }
    }
    
    Row {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: dp(18)
        }
        spacing: dp(10)
        
        Rectangle {
            width: dp(30)
            height: width * 0.4
            color: "#F90"
            radius: dp(3)
            Text {
                anchors.centerIn: parent
                text: qsTr("Sign in")
                font {
                    family: tintFnt
                    pixelSize: dp(6)
                    bold: true
                }
                color: "#66CDAA"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    handleLogin()
                }
                onPressed: parent.color = "#f4d17f"
                onReleased: parent.color = "#F90"
            }
        }
        Rectangle {
            width: dp(30)
            height: width * 0.4
            color: "#F90"
            radius: dp(3)
            Text {
                anchors.centerIn: parent
                text: qsTr("Sign up")
                font {
                    family: tintFnt
                    pixelSize: dp(6)
                    bold: true
                }
                color: "grey"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    handleSignIn();
                }
                onPressed: parent.color = "#f4d17f"
                onReleased: parent.color = "#F90"
            }
        }
    }
    
    function handleLogin() {
        if(userCode.text != "" && userId.text != "" && userPsw.text != ""){
            var logData = userCode.text + "/" + userId.text + "/" + userPsw.text;
            backend.send_message_test("1001" + logData)
            root.setUserInfo(userCode.text, userId.text)
            root.setVal(userCode.text, userId.text, userPsw.text)
        }
        //////
        else {
            showChip("请填好信息Ao~")
        }
    }
    
    function handleSignIn() {
        if(userCode.text != "" && userId.text != "" && userPsw.text != ""){
            var logData = userCode.text + "/" + userId.text + "/" + userPsw.text;
            backend.send_message_test("1002" + logData)
        }
        else root.showChip("请填好信息Ao~")
    }
    
    Component.onCompleted: {
        userCode.text = storage.id
        userId.text = storage.userName
        userPsw.text = storage.psw
    }
}