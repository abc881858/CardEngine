import QtQuick 2.0
import QtGraphicalEffects 1.12
import "data.js" as Data

Flipable {
    id: deckItem
    property int index
    property int isdn
    property var judgeResult: []
    property int judgeIndex: 0
    state: "origin"
    property alias source: frontItem.source
    width: 50
    height: 72

    front: Image { id: frontItem; source: "qrc:/image/hand/null.png"; anchors.centerIn: deckItem }
    back: Image { source: "qrc:/image/hand/null.png"; anchors.centerIn: deckItem }
    transform: [
        Rotation {
            id: rotation;
            origin.x: deckItem.width / 2;
            origin.y: deckItem.height / 2
            axis { x: 0; y: 1; z: 0 }
        },
        Rotation {
            id: rotation2;
            origin.x: deckItem.width / 2;
            origin.y: deckItem.height / 2
            axis { x: 0; y: 0; z: 1 }
        }
    ]

//    MouseArea {
//        id: cursorArea
//        anchors.fill: deckItem
//        hoverEnabled : true
//        onEntered: {
//            if(deckItem.state === "origin") {
//                deckItem.state = "highlight"
//            }
//        }
//    }
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
        },
        Transition {
            from: "highlight"
            to: "origin"
        },
        Transition {
            to: "outside"
            ParallelAnimation {
                NumberAnimation { target: deckItem; properties: "x"; from: 250; to: 321; duration: 500 }
                NumberAnimation { target: deckItem; properties: "y"; from: 529; to: 287; duration: 500 }
                NumberAnimation { target: deckItem; properties: "z"; to: 2; duration: 500 }
                NumberAnimation { target: deckItem; properties: "scale"; from: 1.0; to: 2.0; duration: 500 }
                NumberAnimation { target: rotation; to: 180; property: "angle"; duration: 500 }
                NumberAnimation { target: rotation2; to: 90; property: "angle"; duration: 500 }
            }
        }
    ]
}
