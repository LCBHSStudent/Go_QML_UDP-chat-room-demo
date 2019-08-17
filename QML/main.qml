import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1

import "Component"
import "Logic"
import "Page"

ApplicationWindow {
    id: root
    width: 468
    height: 832
    visible: true
    color: "#000"
    
    property string tintFnt: "Arial,Helvetica,sans-serif"
    property bool   _quit: false
    
    property var userId
    property var userName
    
    StackView {
        id: stack
        anchors.fill: parent
        initialItem: pageLoader
        focus: true
    }
    
    Loader {
        id: pageLoader
        sourceComponent: loginP
    }
    
    Connections{
        target: keyFilter
        onSig_KeyBackPress:{
            if (stack.depth > 1){
                root.backPress()
                stack.pop()
                backend.send_message_test("1007")
            }
            else if(!_quit){
                quitTimer.start()
                _quit = true
                root.showChip("再次点击返回键退出")
            }
            else if(_quit){
                Qt.quit()
                root.close()
            }
        }
    }
    
    Timer {
        id: quitTimer
        interval: 2000
        onTriggered: _quit = false
    }
    
    Rectangle {
        id: mask
        opacity: 0.2
        color: "black"
        anchors.fill: parent
        visible: false
    }
    
    Settings {
        id: storage
        property string userName
        property string id
        property string psw
    }
    
    //-----------------------Propertyes------------------------------
    //property var msgChip
    
    //-----------------------Signals---------------------------------
    signal destroyChip()
    signal backPress()
    //-----------------------Chip Components-------------------------
    Component {id: msghint; MessageChip{}}
    
    //-----------------------Slots-----------------------------------
    //onDestroyChip: msgChip.destroy()
    
    //-----------------------Page Components-------------------------
    Component {id: loginP; LoginPage{}}
    Component {id: mainP;  MainPage{}}
    Component {id: chatP;  ChatPage{}}
    
    
    
    //-----------------------Js Functions----------------------------
    function dp(value) {
        return value * root.width / 100
    }
    
    function showChip(message) {
        var msgChip = msghint.createObject(root, {})
        msgChip.text = message
    }
    
    function pushStack(code) {
        switch(code){
        case 0: stack.push(chatP); break;
        default: break;
        }
    }
    
    function login() {
        pageLoader.sourceComponent = mainP
    }
    
    function showMask(){
        mask.visible = true;
    }
    
    function closeMask(){
        mask.visible = false;
    }
    
    function setUserInfo(id, nickname){
        root.userId = id
        root.userName = nickname
    }
    
    function setVal(id, name, psw){
        storage.setValue("userName", name)
        storage.setValue("id", id)
        storage.setValue("psw", psw)
    }
    
    Connections {
        target: backend
        
        onWelcome: showChip("The server is open")
        
        onLoginS: {
            //showChip("Login Succeed")
            login()
        }
        onLoginF: showChip("Login Failed")
        onSignS: showChip("HOMo登记成功~")
        onSignF: showChip("注册失败,ID可能已被占用")
        
    }
    
    Component.onCompleted: {
        //backend.send_message_test("1000"+"114514")
        //login()
    }
}