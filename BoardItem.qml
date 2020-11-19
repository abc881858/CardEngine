import QtQuick 2.3
import "data.js" as Data
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

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
        Data.infoImageObject = infoImage;
        Data.infoTextObject = infoText;
        Data.dialogText = textDialog;
        Data.dialogObject = dialog;
        Data.startGame();
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

//    Image {
//        id: cursor
//        x: -100
//        y: -100
//        z: 999
//        width: 72
//        height: 72
//        source: "qrc:/image/cursor/3.png"
//    }

//    MouseArea {
//        id: mouseArea
//        anchors.fill: parent
//        cursorShape: Qt.BlankCursor
//        hoverEnabled: true
//        onPositionChanged: {
//            cursor.x = mouseX-31
//            cursor.y = mouseY-15
//        }
//    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1}
}
##^##*/
