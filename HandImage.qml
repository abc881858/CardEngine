import QtQuick 2.0
import QtGraphicalEffects 1.12
import "data.js" as Data

Flipable {
    id: handItem
    property int index
    property int isdn
    property var judgeResult: []
    property int judgeIndex: 0
    state: "origin"
    property alias source: frontItem.source
    width: 100
    height: 145

    front: Image { id: frontItem; source: "qrc:/image/hand/null.png"; anchors.centerIn: handItem }
    back: Image { source: "qrc:/image/hand/null.png"; anchors.centerIn: handItem }
    transform: [
        Rotation {
            id: rotation;
            origin.x: handItem.width / 2;
            origin.y: handItem.height / 2
            axis { x: 0; y: 1; z: 0 }
        },
        Rotation {
            id: rotation2;
            origin.x: handItem.width / 2;
            origin.y: handItem.height / 2
            axis { x: 0; y: 0; z: 1 }
        }
    ]

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

    MouseArea {
        id: cursorArea

        anchors.fill: handItem
        hoverEnabled : true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onEntered: {
            if(handItem.state === "origin") {
                handItem.state = "highlight"
            }
            Data.sendInfoImage(isdn)
            judgeResult = Data.judgeHandCard(handItem.index);
            judgeCursor();
        }
        onExited: {
            if(handItem.state === "highlight") {
                handItem.state = "origin"
            }
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
                    handItem.state = "outside";
                    Data.blueSummonEnable = false;
                }
            }
        }
    }
    states: [
        State {
            name: "origin"
        },
        State {
            name: "highlight"
        },
        State {
            name: "outside"
        }
    ]

    transitions: [
        Transition {
            from: "origin"
            to: "highlight"
            NumberAnimation { target: handItem; properties: "y"; from: 529; to: 494; duration: 200 }
        },
        Transition {
            from: "highlight"
            to: "origin"
            NumberAnimation { target: handItem; properties: "y"; from: 494; to: 529; duration: 200 }
        },
        Transition {
            to: "outside"
            ParallelAnimation {
                NumberAnimation { target: handItem; properties: "x"; from: 250; to: 321; duration: 500 }
                NumberAnimation { target: handItem; properties: "y"; from: 529; to: 287; duration: 500 }
                NumberAnimation { target: handItem; properties: "z"; to: 2; duration: 500 }
                NumberAnimation { target: handItem; properties: "scale"; from: 1.0; to: 0.5; duration: 500 }
                NumberAnimation { target: rotation; to: 180; property: "angle"; duration: 500 }
                NumberAnimation { target: rotation2; to: 90; property: "angle"; duration: 500 }
            }
        }
    ]
}
