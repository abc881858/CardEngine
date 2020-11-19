import QtQuick 2.0
import "data.js" as Data

Item {
    id: frontItem
    property int index
    property int isdn

    property int currentAtk
    property int currentDef

    property alias source: pic.source
    property alias text: label.text
    property alias swordVisiable: sword.visible

    property var judgeResult: []
    property int judgeIndex: 0

    function judgeCursor() {
        if(judgeResult[judgeIndex] === 1) {
            //发动效果
            console.log("发动效果....")
            cursorArea.cursorShape = Qt.WaitCursor
        } else if(judgeResult[judgeIndex] === 5) {
            //攻击表示
            console.log("攻击表示....")
            cursorArea.cursorShape = Qt.SizeVerCursor
        } else if(judgeResult[judgeIndex] === 6) {
            //防御表示
            console.log("防御表示....")
            cursorArea.cursorShape = Qt.SizeHorCursor
        } else if(judgeResult[judgeIndex] === 7) {
            //攻击
            console.log("攻击....")
            cursorArea.cursorShape = Qt.SizeAllCursor
        } else {
            //无
            cursorArea.cursorShape = Qt.ArrowCursor
        }
    }

    Image {
        id: pic
        anchors.left: frontItem.left
        anchors.top: frontItem.top
        width:50
        height:72

        MouseArea {
            id: cursorArea
            anchors.fill: pic
            hoverEnabled: true
            onEntered: {
                Data.sendInfoImage(isdn);
                judgeResult = Data.judgeFrontCard(frontItem.index);
                judgeCursor();
            }
            onExited: {
                cursorArea.cursorShape = Qt.ArrowCursor;
                judgeIndex = 0;
                judgeResult = [];
            }
            onClicked: {
                if(mouse.button === Qt.RightButton) {
                    var size = judgeResult.length;
                    if(size!==0) {
                        judgeIndex = (judgeIndex+1)%size;
                        judgeCursor();
                    }
                } else {
                    if(judgeResult[judgeIndex]===1) {
                        //
                    }
                }
            }
        }

        Image {
            id: sword
            anchors.centerIn: parent
            source: "qrc:/image/sword.png"
            visible: false
        }
    }

    TextInput {
        id: label
        anchors.horizontalCenter: pic.horizontalCenter
        anchors.top: pic.bottom
        anchors.topMargin: 5
        width: 65
        height: 17
        color: "#ffffff"
        font.pixelSize: 12
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
