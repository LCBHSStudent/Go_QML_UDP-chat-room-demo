import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: editLine
    color: "transparent"
    property alias icon: editIco.source
    property alias text: editField.text
    property alias validator: editField.validator
    property alias placeholderText: editField.placeholderText
    property alias echoMode: editField.echoMode
    property bool isPsw: placeholderText === " Password" //判断是否为密码输入框
    Image {
        id: editIco
        source: ""
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: dp(5)
        }
        height: parent.height
        width: height
        fillMode: Image.PreserveAspectFit
    }
    TextField {
        clip: false
        id: editField
        anchors {
            verticalCenter: parent.verticalCenter
            left: editIco.right
            leftMargin: dp(5)
            right: showPsw.left
            rightMargin: dp(1)
        }
        color: isPsw? "#000": "transparent"
        width: parent.width - editIco.width
        height: parent.height
        implicitWidth: width - showPsw.width
        font {
            pixelSize: (isPsw && text !== "" && !showPsw.showpsw)? parent.height * 0.3: parent.height * 0.6;
            //若是密码框且输入内容不为空
            family: "Microsoft YaHei UI"
            
        }
        Text {
            visible: !isPsw
            text: parent.text
            font: parent.font
            color: "black";
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: dp(2)
        }
        background: Rectangle{color: "#eeeeee"; radius: dp(2)}
        //color: "#000"
    }
    Image {
        id: showPsw
        scale: 0.75
        property bool showpsw: false
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: dp(5)
            verticalCenterOffset : -1
        }
        source: isPsw? "../../assets/mdpi/ic_eye_off1.png": ""
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(!parent.showpsw){
                    parent.showpsw = !parent.showpsw
                    parent.source = "../../assets/mdpi/ic_eye_on.png"
                    parent.anchors.verticalCenterOffset = 0
                    echoMode = TextInput.Normal
                }
                else{
                    parent.showpsw = !parent.showpsw
                    parent.source = "../../assets/mdpi/ic_eye_off1.png"
                    parent.anchors.verticalCenterOffset = -1
                    echoMode = TextInput.Password
                }
            }
        }
    }
}