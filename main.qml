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
    }

    MenuItem {
    }

//    Button {
//        id: button28
//        x: 1566
//        y: 298
//        text: qsTr("Blue Draw")
//        onClicked: {
//            console.log("blue draw");
//            Data.blue_draw_card();
//        }
//    }

//    Button {
//        id: button29
//        x: 1566
//        y: 355
//        text: qsTr("Red Draw")
//        onClicked: {
//            console.log("red draw");
//            Data.red_draw_card();
//        }
//    }

//    Button {
//        id: button30
//        x: 1566
//        y: 405
//        text: qsTr("redVerticalFaceupFront")
//        onClicked: {
//            Data.redVerticalFaceupFront(Number(indexOfHand.text));
//            if(Data.oldSelectCard !== undefined) {
//                Data.oldSelectCard.highlight = false;
//            }
//        }
//    }

//    Button {
//        id: button32
//        x: 1566
//        y: 473
//        text: qsTr("redHorizontalFacedownFront")
//        onClicked: {
//            Data.redHorizontalFacedownFront(Number(indexOfHand.text));
//            if(Data.oldSelectCard !== undefined) {
//                Data.oldSelectCard.highlight = false;
//            }
//        }
//    }

//    Text {
//        id: element
//        x: 1566
//        y: 546
//        width: 142
//        height: 53
//        text: qsTr("Index of Hand")
//        font.pixelSize: 12
//    }

//    TextInput {
//        id: indexOfHand
//        x: 1566
//        y: 605
//        width: 112
//        height: 77
//        text: qsTr("0")
//        font.pixelSize: 12
//        horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//    }

//    Button {
//        id: button
//        x: 1566
//        y: 199
//        width: 128
//        height: 65
//        text: qsTr("start game")
//        onClicked: {
//            Data.start_game();
//        }
//    }
}
