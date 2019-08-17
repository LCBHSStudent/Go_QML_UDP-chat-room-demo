import QtQuick 2.12

Rectangle {
    id: chip;
    width: txt.width + dp(8);
    height: txt.height + dp(6);
    anchors.horizontalCenter: parent.horizontalCenter;
    anchors.bottom: parent.bottom;
    anchors.bottomMargin: dp(20);
    color: "#505152";
    radius: width / 5;
    property alias text: txt.text;
    Text {
        id: txt;
        anchors.centerIn: parent;
        text: "测试";
        font.pixelSize: dp(3.5);
        color: "white";
    } //内部文字
    PropertyAnimation {
        id: show;
        target: chip;
        running: false;
        property: "opacity";
        from: 0;
        to: 1;
        duration: 700;
        easing.type: Easing.InQuart;
        onStopped: delay.start();
    }
    PropertyAnimation {
        id: hide;
        target: chip;
        running: false;
        property: "opacity";
        from: 1;
        to: 0;
        duration: 700;
        easing.type: Easing.OutQuart;
        onStopped: {
            //root.destroyChip()
            chip.destroy()
        }
    }
    Timer {
        id: delay;
        interval: 2000;
        running: false;
        repeat: false;
        onTriggered: hide.start();
    }
    //动画顺序
    //show  ---- delay ---  hide
    Component.onCompleted: show.start();
}