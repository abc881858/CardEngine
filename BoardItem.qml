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
}
