import QtQuick 2.3
import "data.js" as Data
import QtQuick.Dialogs 1.2
import QtWebSockets 1.0
import QtQuick.Controls 2.14

Image {
    id: board
    anchors.left: parent.left
    anchors.top: parent.top
    width: 1440
    height: 1080
    source: "qrc:/image/bg.png"

    Component.onCompleted: {
        Data.componentObject = Component;
        Data.boardObject = board;
        Data.boardSocket = socket;
        Data.infoImageObject = infoImage;
        Data.infoTextObject = infoText;
        Data.dialogText = textDialog;
        Data.dialogObject = dialog;
        Data.blueSword = blueSword0;
        Data.redSword = redSword0;
        Data.mouseAreaBoardObject = mouseAreaBoard;
        Data.blueSwordAnimationObject = blueSwordAnimation;
    }

    WebSocket {
        id: socket
        url: "ws://127.0.0.1:7720"
        active: true
        onTextMessageReceived: {
            console.log(message)
            Data.handleMessage(message.split("#")[0], message.split("#")[1]);
        }
    }

    Dialog {
        id: dialog
        visible: false
        width: 720
        height: 180
        contentItem: Rectangle {
            color: "lightskyblue"
            Text {
                id: textDialog
                color: "navy"
                anchors.centerIn: parent
            }
        }
    }

    MouseArea {
        id: mouseAreaM1
        x: 401
        y: 432
        width: 48
        height: 88
        onClicked: Data.go_main1_phase()
    }

    MouseArea {
        id: mouseAreaBP
        x: 401
        y: 565
        width: 48
        height: 88
        onClicked: Data.go_battle_phase()
    }

    MouseArea {
        id: mouseAreaM2
        x: 401
        y: 702
        width: 48
        height: 88
        onClicked: Data.go_main2_phase()
    }

    MouseArea {
        id: mouseAreaEP
        x: 401
        y: 835
        width: 48
        height: 88
        onClicked: Data.go_end_phase()
    }

    Image {
        id: infoImage
        x: 4
        y: 135
        width: 360
        height: 522
        source: "qrc:/image/info/null.png"
        fillMode: Image.PreserveAspectFit
    }

    ScrollView {
        id: infoScroll
        x: 14
        y: 666
        width: 342
        height: 265
        TextArea {
            id: infoText
            readOnly: true
            font.family: "Helvetica"
            font.pointSize: 14
            wrapMode: TextEdit.Wrap
        }
    }

    Image {
        id: blueSword0
        x: 630
        y: 571
        z: 3
        width: 90
        height: 130
        source: "qrc:/image/sword.png"
        fillMode: Image.PreserveAspectFit
        visible: false
        property int indexFrom: 0
        property int indexTo: 0
    }

    SequentialAnimation {
        id: blueSwordAnimation
        ParallelAnimation {
            NumberAnimation {
                target: blueSword0
                properties: "x";
                to: 630+(4-blueSword0.indexTo)*78*1.8
                duration: 200
            }
            NumberAnimation {
                target: blueSword0
                properties: "y";
                from: 317*1.8
                to: 213*1.8
                duration: 200
            }
        }
        ScriptAction {
            script: {
                blueSword0.visible = false;
                blueSword0.x = 350*1.8;
                blueSword0.y = 317*1.8;
                blueSword0.rotation = 0;
                blueSword0.source = "qrc:/image/sword.png"
            }
        }
        PauseAnimation {
            duration: 1000
        }
        ScriptAction {
            script: {
                if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFacedownFront") {
                    Data.redFrontCards[Data.battleToIndex].state = "redHorizontalFaceupFront";
                }
            }
        }
        PauseAnimation {
            duration: 1000
        }
        ScriptAction {
            script: {
                var isdnFrom = Data.blueFrontCards[Data.battleFromIndex].isdn;
                var isdnTo = Data.redFrontCards[Data.battleToIndex].isdn;
                if(Data.redFrontCards[Data.battleToIndex].state === "redVerticalFaceupFront") {
                    if(Number(Data.boardCards[isdnFrom]["atk"]) >= Number(Data.boardCards[isdnTo]["atk"])) {
                        Data.redFrontCards[Data.battleToIndex].state = "redGrave";
                        Data.redGraveCards.push(Data.redFrontCards[Data.battleToIndex]);
                        delete Data.redFrontCards[Data.battleToIndex];
                        Data.redLP -= Data.boardCards[isdnFrom]["atk"] - Data.boardCards[isdnTo]["atk"];
                        console.log("Data.redLP: " + Data.redLP);
                    }
                    if(Number(Data.boardCards[isdnFrom]["atk"]) <= Number(Data.boardCards[isdnTo]["atk"])) {
                        Data.blueFrontCards[Data.battleFromIndex].state = "blueGrave";
                        Data.blueGraveCards.push(Data.blueFrontCards[Data.battleFromIndex]);
                        delete Data.blueFrontCards[Data.battleFromIndex];
                        Data.blueLP -= Data.boardCards[isdnTo]["atk"] - Data.boardCards[isdnFrom]["atk"];
                        console.log("Data.blueLP: " + Data.blueLP);
                    }
                } else if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFaceupFront") {
                    if(Number(Data.boardCards[isdnFrom]["atk"]) > Number(Data.boardCards[isdnTo]["def"])) {
                        Data.redFrontCards[Data.battleToIndex].state = "redGrave";
                        Data.redGraveCards.push(Data.redFrontCards[Data.battleToIndex]);
                        delete Data.redFrontCards[Data.battleToIndex];
                    } else if(Number(Data.boardCards[isdnTo]["def"]) > Number(Data.boardCards[isdnFrom]["atk"])) {
                        Data.blueLP -= Data.boardCards[isdnTo]["def"] - Data.boardCards[isdnFrom]["atk"];
                        console.log("Data.blueLP: " + Data.blueLP);
                    }
                }
            }
        }

        ScriptAction {
            script: {
                Data.battleFromIndex = -1;
                Data.battleToIndex = -1;
            }
        }
    }

    Image {
        id: redSword0
        x: 662*1.8
        y: 213*1.8
        z: 3
        width: 50*1.8
        height: 72*1.8
        source: "qrc:/image/sword.png"
        fillMode: Image.PreserveAspectFit
        visible: false
        rotation: 180
    }

    MouseArea {
        id: mouseAreaBoard
        anchors.rightMargin: 0
        anchors.bottomMargin: 2
        anchors.leftMargin: 0
        anchors.topMargin: -2
        anchors.fill: board
        hoverEnabled : true
        acceptedButtons: Qt.RightButton
        onClicked: {
            if(mouse.button === Qt.RightButton) {
                if(blueSword0.visible) {
                    Data.blueFrontCards[Data.battleFromIndex].battleState = 1;
                    Data.blueFrontCards[Data.battleFromIndex].swordVisible = true
                    Data.battleFromIndex = -1;
                    blueSword0.rotation = 0;
                    blueSword0.visible = false;
                    mouseAreaBoard.enabled = false;
                }
            }
        }
        onPositionChanged: {
            if(blueSword0.visible && Data.battleToIndex===-1) {
                var angle0 = Math.atan((mouseX-blueSword0.x-25*1.8)/(blueSword0.y+36*1.8-mouseY))
                if((blueSword0.y+36*1.8) < mouseY) {
                    blueSword0.rotation = angle0/3.1415*180 + 180
                } else {
                    blueSword0.rotation = angle0/3.1415*180
                }
            }
        }
        enabled: false
    }
}
