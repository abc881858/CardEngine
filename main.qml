import QtQuick 2.14
import QtQuick.Window 2.14
import "data.js" as Data
import QtQuick.Controls 2.14

Window {
    id: demo
    visible: true
    x: 0
    y: 0
    width: 2262
    height: 1080
    title: qsTr("Demo")

    visibility: Window.FullScreen

    BoardItem {
        id: dotaBoard;
    }

    Button {
        id: button28
        x: 1870
        y: 305
        text: qsTr("Blue Draw")
        onClicked: {
            console.log("blue draw");
            Data.blue_draw_card();
        }
    }

    Button {
        id: button29
        x: 1870
        y: 362
        text: qsTr("Red Draw")
        onClicked: {
            console.log("red draw");
            Data.red_draw_card();
        }
    }

    Button {
        id: button30
        x: 1870
        y: 412
        text: qsTr("redVerticalFaceupFront")
        onClicked: {
            Data.redVerticalFaceupFront(Number(indexOfHand.text));
        }
    }

    Button {
        id: button32
        x: 1870
        y: 480
        text: qsTr("redHorizontalFacedownFront")
        onClicked: {
            Data.redHorizontalFacedownFront(Number(indexOfHand.text));
        }
    }

    Button {
        id: button35
        x: 1472
        y: 425
        text: qsTr("BlueEP-RedDP")
        onClicked: {
            Data.boardObject.state = "blueEndPhase";
            Data.boardObject.state = "redDrawPhase";
        }
    }

    Button {
        id: button36
        x: 1472
        y: 953
        text: qsTr("RedEP-BlueDP")
        onClicked: {
            Data.boardObject.state = "redEndPhase";
            Data.boardObject.state = "blueDrawPhase";
        }
    }

    Text {
        id: element
        x: 1870
        y: 553
        width: 142
        height: 53
        text: qsTr("Index of Hand")
        font.pixelSize: 12
    }

    TextInput {
        id: indexOfHand
        x: 1870
        y: 612
        width: 112
        height: 77
        text: qsTr("0")
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Button {
        id: button
        x: 1870
        y: 206
        width: 128
        height: 65
        text: qsTr("start game")
        onClicked: {
            Data.start_game();
        }
    }

    Button {
        id: button38
        x: 1472
        y: 86
        text: qsTr("BlueDP-BlueSP")
        onClicked: {
            Data.boardObject.state =  "blueDrawPhase"
            Data.boardObject.state =  "blueStandbyPhase"
        }
    }

    Button {
        id: button39
        x: 1472
        y: 152
        text: qsTr("BlueSP-BlueM1")
        onClicked: {
            Data.boardObject.state =  "blueStandbyPhase"
            Data.boardObject.state =  "blueMain1Phase"
        }
    }

    Button {
        id: button40
        x: 1472
        y: 212
        text: qsTr("BlueM1-BlueBP")
        onClicked: {
            Data.boardObject.state =  "blueMain1Phase"
            Data.boardObject.state =  "blueBattlePhase"
        }
    }

    Button {
        id: button41
        x: 1472
        y: 276
        text: qsTr("BlueBP-BlueM2")
        onClicked: {
            Data.boardObject.state =  "blueBattlePhase"
            Data.boardObject.state =  "blueMain2Phase"
        }
    }

    Button {
        id: button42
        x: 1472
        y: 347
        text: qsTr("BlueM2-BlueEP")
        onClicked: {
            Data.boardObject.state =  "blueMain2Phase"
            Data.boardObject.state =  "blueEndPhase"
        }
    }

    Button {
        id: button43
        x: 1472
        y: 510
        text: qsTr("RedDP-RedSP")
        onClicked: {
            Data.boardObject.state =  "redDrawPhase"
            Data.boardObject.state =  "redStandbyPhase"
        }
    }

    Button {
        id: button44
        x: 1472
        y: 590
        text: qsTr("RedSP-RedM1")
        onClicked: {
            Data.boardObject.state =  "redStandbyPhase"
            Data.boardObject.state =  "redMain1Phase"
        }
    }

    Button {
        id: button45
        x: 1472
        y: 670
        text: qsTr("RedM1-RedBP")
        onClicked: {
            Data.boardObject.state =  "redMain1Phase"
            Data.boardObject.state =  "redBattlePhase"
        }
    }

    Button {
        id: button46
        x: 1472
        y: 755
        text: qsTr("RedBP-RedM2")
        onClicked: {
            Data.boardObject.state =  "redBattlePhase"
            Data.boardObject.state =  "redMain2Phase"
        }
    }

    Button {
        id: button47
        x: 1472
        y: 856
        text: qsTr("RedM2-RedEP")
        onClicked: {
            Data.boardObject.state =  "redMain2Phase"
            Data.boardObject.state =  "redEndPhase"
        }
    }
}
