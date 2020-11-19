import QtQuick 2.0
import "data.js" as Data

Image {
    id: handItem
    property int index
    property int isdn
    property var judgeResult: []
    property int judgeIndex: 0

    function judgeCursor() {
        if(judgeResult[judgeIndex] === 1) {
            //发动效果
            console.log("发动效果....")
            cursorArea.cursorShape = Qt.WaitCursor
        } else if(judgeResult[judgeIndex] === 2) {
            //特殊召唤
            console.log("特殊召唤....")
            cursorArea.cursorShape = Qt.PointingHandCursor
        } else if(judgeResult[judgeIndex] === 3) {
            //召唤
            console.log("召唤....")
            cursorArea.cursorShape = Qt.OpenHandCursor
        } else if(judgeResult[judgeIndex] === 4) {
            //放置
            console.log("放置....")
            cursorArea.cursorShape = Qt.ClosedHandCursor
        } else {
            //无
            cursorArea.cursorShape = Qt.ArrowCursor
        }
    }

    width: 100
    height: 145
    MouseArea {
        id: cursorArea
        anchors.fill: handItem
        hoverEnabled : true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: {
            Data.sendInfoImage(isdn)
            handItem.y = handItem.y - 35;
            judgeResult = Data.judgeHandCard(handItem.index);
            judgeCursor();
        }
        onExited: {
            handItem.y = handItem.y + 35;
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
                if(judgeResult[judgeIndex] === 3 || judgeResult[judgeIndex] === 4) {
                    Data.blueSummonEnable = false;
                }
            }
        }
    }
}
