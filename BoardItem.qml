import QtQuick 2.3
import "data.js" as Data
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtWebSockets 1.0

Image {
    id: board
    anchors.top: parent.top
    anchors.left: parent.left
    width: 800
    height: 600
    source: "qrc:/image/beijing.jpg"

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

        Data.startGame();
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
        width: 400
        height: 100
        modality: Qt.NonModal
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
        x: 223
        y: 240
        width: 27
        height: 49
        onClicked: Data.go_main1_phase()
    }

    MouseArea {
        id: mouseAreaBP
        x: 223
        y: 314
        width: 27
        height: 49
        onClicked: Data.go_battle_phase()
    }

    MouseArea {
        id: mouseAreaM2
        x: 223
        y: 390
        width: 27
        height: 49
        onClicked: Data.go_main2_phase()
    }

    MouseArea {
        id: mouseAreaEP
        x: 223
        y: 464
        width: 27
        height: 49
        onClicked: Data.go_end_phase()
    }

    Image {
        id: infoImage
        x: 2
        y: 75
        width: 200
        height: 290
        source: "qrc:/image/info/null.png"
        fillMode: Image.PreserveAspectFit
    }

    TextEdit {
        id: infoText
        x: 8
        y: 371
        width: 176
        height: 147
        font.family: "Helvetica"
        font.pointSize: 10
        wrapMode: TextEdit.Wrap
    }

    Image {
        id: blueSword0
        x: 350
        y: 317
        z: 3
        width: 50
        height: 72
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
                to: 350+(4-blueSword0.indexTo)*78
                duration: 200
            }
            NumberAnimation {
                target: blueSword0
                properties: "y";
                from: 317
                to: 213
                duration: 200
            }
        }
        ScriptAction {
            script: {
                blueSword0.visible = false;
                blueSword0.x = 350;
                blueSword0.y = 317;
                blueSword0.rotation = 0;
                blueSword0.source = "qrc:/image/sword.png"

                if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFacedownFront") {
                    Data.redFrontCards[Data.battleToIndex].state = "redHorizontalFaceupFront";
                }
            }
        }
        PauseAnimation {
            duration: 2000
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
                }
                if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFaceupFront") {
                    if(Number(Data.boardCards[isdnFrom]["atk"]) > Number(Data.boardCards[isdnTo]["def"])) {
                        Data.redFrontCards[Data.battleToIndex].state = "redGrave";
                        Data.redGraveCards.push(Data.redFrontCards[Data.battleToIndex]);
                        delete Data.redFrontCards[Data.battleToIndex];
                    }
                    if(Number(Data.boardCards[isdnTo]["def"]) > Number(Data.boardCards[isdnFrom]["atk"])) {
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
        x: 662
        y: 213
        z: 3
        width: 50
        height: 72
        source: "qrc:/image/sword.png"
        fillMode: Image.PreserveAspectFit
        visible: false
        rotation: 180
    }

    MouseArea {
        id: mouseAreaBoard
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
            if(blueSword0.visible) {
                var angle0 = Math.atan((mouseX-blueSword0.x-25)/(blueSword0.y+36-mouseY))
                if((blueSword0.y+36) < mouseY) {
                    blueSword0.rotation = angle0/3.1415*180 + 180
                } else {
                    blueSword0.rotation = angle0/3.1415*180
                }
            }
        }
        enabled: false
    }
}
