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
        x: 1775
        y: 189
        text: qsTr("Blue Draw")
        onClicked: {
            console.log("blue draw");
            Data.blue_draw_card();
        }
    }

    Button {
        id: button29
        x: 1775
        y: 281
        text: qsTr("Red Draw")
        onClicked: {
            console.log("red draw");
            Data.red_draw_card();
        }
    }

    Button {
        id: button30
        x: 1764
        y: 376
        text: qsTr("redVerticalFaceupFront")
        onClicked: {
            Data.redVerticalFaceupFront(Number(indexOfHand.text));
        }
    }

    Button {
        id: button32
        x: 1764
        y: 486
        text: qsTr("redHorizontalFacedownFront")
        onClicked: {
            Data.redHorizontalFacedownFront(Number(indexOfHand.text));
        }
    }

    Text {
        id: element
        x: 1785
        y: 615
        width: 78
        height: 8
        text: qsTr("Index of Hand")
        font.pixelSize: 12
    }

    TextInput {
        id: indexOfHand
        x: 1785
        y: 646
        width: 80
        height: 15
        text: qsTr("0")
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Button {
        id: button
        x: 1775
        y: 84
        text: qsTr("start game")
        onClicked: {
            Data.start_game();
        }
    }
}
