import QtQuick 2.12
import QtQuick.Controls 2.12
Page {
    id: mainP
    
    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }
    
    Rectangle {
        id: user
        width: dp(10)
        height: width
        radius: width / 2
        color: "orange"
        anchors {
            top: parent.top
            left: parent.left
            margins: dp(4.5)
        }

        Text {
            text: userName[0]//JSON.stringify(userName)[0]
            anchors.centerIn: parent;
            font {
                family: tintFnt
                pixelSize: dp(6)
                bold: true
            }
            color: "black"
        }
    }
    
    Rectangle {
        id: beChampion
        anchors.left: user.right
        anchors.verticalCenter: user.verticalCenter
        anchors.margins: dp(5)
        height: dp(10)
        width: championTxt.width + dp(4)
        radius: dp(1.5)
        color: "#1C86EE"
        Text {
            id: championTxt
            anchors.centerIn: parent
            text: qsTr("俺事👆✌champion")
            font.pixelSize: parent.height * 0.4
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            onPressed: beChampion.color = "#00BFFF"
            onReleased: beChampion.color = "#1C86EE"
            onClicked: {
                root.showMask()
                setChampion.createObject(root)
            }
        }
    }
    
    Rectangle {
        id: seeChampion
        anchors{
            left: beChampion.right
            right: parent.right
            verticalCenter: beChampion.verticalCenter
            margins: dp(3)
        }
        color: "#EEAEEE"
        height: dp(10)
        width: championView.width + dp(4)
        radius: dp(1.5)
        Text {
            id: championView
            anchors.centerIn: parent
            text: qsTr("昨日👆💦昌平")
            font.pixelSize: parent.height * 0.4
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            onPressed: seeChampion.color = "#EED2EE"
            onReleased: seeChampion.color = "#EEAEEE"
            onClicked: {
                root.showMask()
                championPage.createObject(root)
            }
        }
    }
    
    Rectangle {
        id: listRec
        anchors.centerIn: parent
        color: "#555555"
        opacity: 0
        ParallelAnimation {
            id: create;
            PropertyAnimation {
                target: listRec
                property: "height";
                to: parent.height * 0.8
                duration: 325
                easing.type: Easing.InQuart
            }
            PropertyAnimation {
                target: listRec
                property: "width";
                to: dp(90)
                duration: 325
                easing.type: Easing.OutQuart
            }
            PropertyAnimation {
                target: listRec
                property: "radius"
                to: dp(5)
                duration: 325
            }
            PropertyAnimation {
                target: listRec
                property: "opacity"
                to: 0.7
                duration: 325
                easing.type: Easing.InQuart
            }
        }
        Component.onCompleted: create.start()
        
        ListView {
            id: roomList
            anchors.centerIn: parent
            width: parent.width * 0.9
            height: parent.height * 0.95
            
            model: ListModel{
                id: roomodel
            }
            clip: true
            spacing: dp(3)
            delegate: Rectangle {
                property var roomCod: modelData
                width: parent.width
                height: dp(10)
                color: "white"
                radius: 5
                Text {
                    anchors.centerIn: parent
                    text: "【" + parent.roomCod + "】"
                    font.family: "Agency FB Negreta"
                    font.pixelSize: parent.height * 0.6
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: getIntoRoom(modelData)
                }
            }
            Component.onCompleted: backend.send_message_test("1007")
        }
    }
    
    Image {
        id: flash
        source: "../assets/mdpi/ucrop_ic_rotate.png"
        width: dp(8)
        //height: dp(8)
        fillMode: Image.PreserveAspectFit
        anchors {
            right: listRec.right
            bottom: listRec.bottom
            margins: dp(4)
        }
        PropertyAnimation {
            id: flashAni
            target: flash
            property: "rotation"
            from: 0
            to: 360
            duration: 800
            loops: Animation.Infinite
        }

        MouseArea {
            anchors.centerIn: parent
            width: dp(8)
            height: dp(8)
            onClicked: {
                flashAni.start()
                timeOutT.start()
                backend.send_message_test("1007")
                root.showChip("刷新中哟~")
                roomodel.clear()
            }
        }
    }
    
    Timer {
        id: timeOutT
        interval: 500
        repeat: flashAni.running
        onTriggered: if(flashAni.running) backend.send_message_test("1007")
    }
    
    TextField {
        id: input
        width: dp(50)
        height: dp(8)
        anchors {
            bottom: parent.bottom
            bottomMargin: dp(4)
            left: parent.left
            leftMargin: dp(6)
        }
        background: Rectangle{color:"yellow"; radius: 5}
        font.pixelSize: dp(5)
        font.family: "Microsoft YaHei UI"
        font.bold: false
        color: "black"
        placeholderText: "  请输入房间ID"
        placeholderTextColor: "black"
    }
    
    Rectangle {
        height: dp(8)
        width: dp(25)
        radius: 5
        anchors {
            bottom: parent.bottom
            bottomMargin: dp(4)
            right: parent.right
            rightMargin: dp(6)
        }
        color: "#F95"
        Text {
            text: qsTr("创建/进入")
            font {
                family: "Microsoft YaHei UI"
                bold: false
                pixelSize: dp(5)
            }
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onPressed: parent.color = "#F70"
            onReleased: parent.color = "#F95"
            onClicked: {
                var pd = false
                for(var dat in roomList.model) {
                    if(input.text === roomList.model[dat]){
                        pd = true
                        break
                    }
                }
                if(pd) {
                    input.focus = false
                    backend.send_message_test("1005" + input.text + "/" + userId)
                    root.pushStack(0)
                    stack.currentItem.roomCode = input.text
                    input.text = ""
                }
                else {
                    input.focus = false
                    backend.send_message_test("1003" + input.text + "/" + userId)
                    root.pushStack(0)
                    stack.currentItem.roomCode = input.text
                    input.text = ""
                }
            }
        }
    }
    
    Component {
        id: championPage
        MouseArea {
            id: th_is
            anchors.fill: parent
            onClicked: dest.start()
            property alias source: img.source
            property var userName
            property var userId
            property var saying
            property var time
            
            Image {
                id: img
                source: "../assets/champion.jpg"
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                opacity: 0
                Rectangle {
                    anchors {
                        right: parent.right
                        top: parent.top
                        topMargin: dp(10)
                        rightMargin: dp(20)
                    }
                    opacity: 0.8
                    width: dp(20)
                    radius: width / 2
                    height: width
                    Text {
                        id: txt
                        text: qsTr("🐸")
                        anchors.centerIn: parent
                        font.pixelSize: parent.height * 0.5
                    }
                    Image {
                        x: -dp(7)
                        y: -dp(5)
                        width: parent.width * 0.8
                        fillMode: Image.PreserveAspectFit
                        source: "../assets/ic_tg.png"
                        rotation: -45
                    }
                }
                Rectangle {
                    color: "#DDA0DD"
                    width: parent.width * 0.6
                    height: parent.width * 0.35
                    radius: dp(3)
                    opacity: 0.65
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                        bottomMargin: dp(5)
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: dp(10)
                        spacing: dp(1.5)
                        Repeater {
                            model: ListModel{id: mod}
                            delegate: Text {
                                text: str
                                anchors.left: parent.left
                                font{
                                    pixelSize: dp(3.5)
                                    bold: true
                                    family: "微软雅黑"
                                }
                            }
                        }
                    }
                }
            }
            ParallelAnimation {
                id: create;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(100)
                    duration: 325
                    easing.type: Easing.OutQuart
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 1
                    duration: 325
                    //easing.type: Easing.InQuart
                }
            }
            ParallelAnimation {
                id: dest;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(200)
                    duration: 325
                    easing.type: Easing.InQuad
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 0
                    duration: 325
                    //easing.type: Easing.OutQuad
                }
                onFinished: {
                    root.closeMask()
                    th_is.destroy()
                }
            }
            Connections { 
                target: backend
                onGetShowYearChampion: {
                    mod.append({str: "鸿蒙艾迪：\n" + id})
                    mod.append({str: "守夜之时：\n" + time})
                    mod.append({str: "鸿蒙寄语：\n" + sygj})
                    txt.text = name[0]
                }
            }
            
            Component.onCompleted: {
                create.start()
                backend.send_message_test("1009")
            }
        }
    }
    
    Component {
        id: setChampion
        MouseArea {
            id: th_is
            anchors.fill: parent
            onClicked: {
                dest.start()
                root.showChip("手液成功")
                if(inp.text != "")
                    backend.send_message_test("1008"+userId+"/"+inp.text)
                else
                    backend.send_message_test("1008"+userId+"/"+"是一个匆忙授业の先辈")
            }
            Image {
                id: img
                source: "../assets/beChampion.jpg"
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                opacity: 0
                
                Rectangle {
                    color: "white"; radius: dp(3); opacity: 0.7
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: dp(5)
                    width: img.width * 0.6
                    height: width * 0.18
                    TextInput {
                        id: inp
                        clip: true
                        anchors.fill: parent
                        font {
                            family: "微软雅黑"
                            pixelSize: height * 0.6
                        }
                        maximumLength: 15
                    }    
                }
                
            }
            ParallelAnimation {
                id: create;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(100)
                    duration: 325
                    easing.type: Easing.OutQuart
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 1
                    duration: 325
                }
            }
            ParallelAnimation {
                id: dest;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(200)
                    duration: 325
                    easing.type: Easing.InQuad
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 0
                    duration: 325
                }
                onFinished: {
                    root.closeMask()
                    th_is.destroy()
                }
            }
            Component.onCompleted: create.start()
        }
    }
    
    Connections {
        target: backend
        onGetNewRoom: {
            roomodel.append({modelData: id})
        }
        onGetRoomFinish: {
            flashAni.stop()
            flash.rotation = 0;
            root.showChip("更新成功!")
        }
    }
    
    Connections {
        target: root
        onBackPress: {
            roomodel.clear()
        }
    }
    
    function getIntoRoom(data) {
        flashAni.stop()
        flash.rotation = 0
        input.focus = false
        root.pushStack(0)
        
        stack.currentItem.roomCode = data
        backend.send_message_test("1005" + data + "/" + userId)
    }
}