import QtQuick 2.0
import QtGraphicalEffects 1.12
import "data.js" as Data
import QtQuick.Controls 2.14

Item {
    id: card_item
    width: 90
    height: 130
    state: "none"

    property int isdn
    property int index
    property var judgeResult: []
    property int judgeIndex: 0

    property alias swordVisible: sword.visible
    property alias highlightVisible: highlight_image.visible
    property alias highlightRotation: highlight_image.rotation
    property alias highlightSource: highlight_image.source

    // 0：无 1：等待攻击 2：选择了攻击来源 3：选择了攻击目标
    property int battleState: 0

    Flipable {
        id: card_image
        anchors.fill: card_item
        front: Image { id: frontItem; source: "qrc:/image/area/null.png"; anchors.centerIn: card_image }
        back: Image { id: backItem; source: "qrc:/image/area/null.png"; anchors.centerIn: card_image }
        transform: [
            Rotation {
                id: rotationFace;
                origin.x: card_image.width / 2;
                origin.y: card_image.height / 2
                axis { x: 0; y: 1; z: 0 }
                angle: 180
            },
            Rotation {
                id: rotationStand;
                origin.x: card_image.width / 2;
                origin.y: card_image.height / 2
                axis { x: 0; y: 0; z: 1 }
            }
        ]
    }

    Image {
        id: sword
        anchors.fill: card_item
        source: "qrc:/image/sword.png"
        opacity: 0.5
        visible: false
    }

    Image {
        id: highlight_image
        anchors.fill: card_item
        x: -5
        y: -5
        source: "qrc:/image/chooseBlue.png"
        visible: false
    }

    TextInput {
        id: label
        anchors.horizontalCenter: card_image.horizontalCenter
        anchors.topMargin: 5
        width: 117
        height: 31
        color: "#ffffff"
        font.pixelSize: 18
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        visible: false
        text: Data.boardCards[isdn]["atk"] + "/" + Data.boardCards[isdn]["def"];
    }

    Button {
        id: summonButton
        y: -70
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 260
        height: 60
        text: "召唤"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: {
            var place2 = Data.findBlueFrontIndex();
            if(place2 !== -1) {
                var old_place2 = card_item.index;
                Data.blueHandCards.splice(old_place2, 1);
                Data.blueFrontCards[place2] = card_item;
                card_item.index = place2;
                card_item.z = 2;
                Data.blueSummonEnable = false;
                card_item.highlightVisible = false;
                delete Data.oldSelectCard;
                card_item.state = "blueVerticalFaceupFront";
                Data.boardSocket.sendTextMessage("summonFront#"+old_place2+"@"+place2);
            }
        }
    }

    Button {
        id: setButton
        y: -140
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 260
        height: 60
        text: "放置"
        font.pixelSize: 24
        font.bold: true
        visible: false
    }

    Button {
        id: specialButton
        y: -210
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 260
        height: 60
        text: "特殊召唤"
        font.pixelSize: 24
        font.bold: true
        visible: false
    }

    //0:deck 1:hand 2:front 3:back 4:grave

    states: [
        State {
            name: "blueDeckArea"
        },
        State {
            name: "blueHandArea"
        },
        State {
            name: "blueHandAreaHighlight"
        },
        State {
            name: "blueVerticalFaceupFront"
        },
        State {
            name: "blueVerticalFacedownFront"
        },
        State {
            name: "blueHorizontalFaceupFront"
        },
        State {
            name: "blueHorizontalFacedownFront"
        },
        State {
            name: "blueActiveBack"
        },
        State {
            name: "blueSetBack"
        },
        State {
            name: "blueGrave"
        },
        State {
            name: "redDeckArea"
        },
        State {
            name: "redHandArea"
        },
        State {
            name: "redHandAreaHighlight"
        },
        State {
            name: "redVerticalFaceupFront"
        },
        State {
            name: "redVerticalFacedownFront"
        },
        State {
            name: "redHorizontalFaceupFront"
        },
        State {
            name: "redHorizontalFacedownFront"
        },
        State {
            name: "redActiveBack"
        },
        State {
            name: "redSetBack"
        },
        State {
            name: "redGrave"
        }
    ]

    transitions: [
        Transition {
            to: "blueDeckArea"
            ScriptAction {
                script: {
                    frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                    backItem.source = "qrc:/image/area/null.png"
                    card_item.width = 90
                    card_item.height = 130
                }
            }
        },
        Transition {
            from: "blueDeckArea"
            to: "blueHandArea"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        frontItem.source = "qrc:/image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/hand/null.png"
                        card_item.width = 180
                        card_item.height = 261
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: 1318; to: x; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: 794; to: 952; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 0.5; to: 1.0; duration: 200 }
                    NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 200 }
                }
            }
        },
        Transition {
            from: "blueHandArea"
            to: "blueHandAreaHighlight"
            SequentialAnimation {
                NumberAnimation { target: card_item; properties: "y"; from: 952; to: 889; duration: 200 }
                ScriptAction {
                    script: {
                        if(Data.boardObject.state === "blueMain1Phase" || Data.boardObject.state === "blueMain2Phase") {
                            if(Data.findBlueFrontIndex() !== -1) {
                                if(Data.blueSummonEnable) {
                                    summonButton.visible = true;
                                    setButton.visible = true;
                                }
                            }
                        }
                    }
                }
            }
        },
        Transition {
            from: "blueHandAreaHighlight"
            to: "blueHandArea"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        summonButton.visible = false;
                        setButton.visible = false;
                        specialButton.visible = false;
                    }
                }
            }
            NumberAnimation { target: card_item; properties: "y"; from: 889; to: 952; duration: 200 }
        },
        Transition {
            from: "blueHandAreaHighlight"
            to: "blueVerticalFaceupFront"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/area/null.png"
                        card_item.width = 90
                        card_item.height = 130
                        summonButton.visible = false;
                        setButton.visible = false;
                        specialButton.visible = false;
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 630+140*card_item.index; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 571; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                }
                ScriptAction {
                    script: {
                        Data.adjustBlueHand();
                        label.anchors.top = card_image.bottom
                        label.visible = true
                    }
                }
            }
        },
        Transition {
            from: "blueHandAreaHighlight"
            to: "blueHorizontalFacedownFront"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/area/null.png"
                        card_item.width = 90
                        card_item.height = 130
                        summonButton.visible = false;
                        setButton.visible = false;
                        specialButton.visible = false;
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 626+140*card_item.index; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 585; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                    NumberAnimation { target: rotationFace; from: 0; to: 180; property: "angle"; duration: 200 }
                    NumberAnimation { target: rotationStand; from: 0; to: -90; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        Data.adjustBlueHand();
                    }
                }
            }
        },
        Transition {
            to: "redDeckArea"
            ScriptAction {
                script: {
                    frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                    backItem.source = "qrc:/image/area/null2.png"
                    card_item.width = 90
                    card_item.height = 130
                }
            }
        },
        Transition {
            from: "redDeckArea"
            to: "redHandArea"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        frontItem.source = "qrc:/image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/hand/null2.png"
                        card_item.width = 180
                        card_item.height = 261
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: 486; to: x; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: 189; to: -128; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 0.5; to: 1.0; duration: 200 }
                }
            }
        },
        Transition {
            from: "redHandArea"
            to: "redHandAreaHighlight"
            NumberAnimation { target: card_item; properties: "y"; from: -128; to: -65; duration: 200 }
        },
        Transition {
            from: "redHandAreaHighlight"
            to: "redHandArea"
            NumberAnimation { target: card_item; properties: "y"; from: -65; to: -128; duration: 200 }
        },
        Transition {
            from: "redHandAreaHighlight"
            to: "redVerticalFaceupFront"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/area/null2.png"
                        card_item.width = 90
                        card_item.height = 130
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 630+140*(4-card_item.index); duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 383; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                    NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 200 }
                    NumberAnimation { target: rotationStand; from: 0; to: 180; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        Data.adjustRedHand();
                        label.anchors.bottom = card_image.top
                        label.visible = true
                    }
                }
            }
        },
        Transition {
            from: "redHandAreaHighlight"
            to: "redHorizontalFacedownFront"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/area/null.png"
                        card_item.width = 90
                        card_item.height = 130
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 626+140*(4-card_item.index); duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 383; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                    NumberAnimation { target: rotationStand; from: 0; to: -90; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        Data.adjustRedHand();
                    }
                }
            }
        },
        Transition {
            from: "redHorizontalFacedownFront"
            to: "redHorizontalFaceupFront"
            SequentialAnimation {
                NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 200 }
                ScriptAction {
                    script: {
                        label.anchors.bottom = card_image.top
                        label.visible = true
                    }
                }
            }
        },
        Transition {
            from: "blueVerticalFaceupFront"
            to: "blueGrave"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 1334; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 594; duration: 200 }
                }
                ScriptAction {
                    script: {
                        label.visible = false
                        card_item.z = 5+Data.blueGraveCards.length
                    }
                }
            }
        },
        Transition {
            from: "blueHorizontalFaceupFront"
            to: "blueGrave"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 1334; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 594; duration: 200 }
                    NumberAnimation { target: rotationStand; to: 0; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        label.visible = false
                        card_item.z = 5+Data.blueGraveCards.length
                    }
                }
            }
        },
        Transition {
            from: "redVerticalFaceupFront"
            to: "redGrave"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 488; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 360; duration: 200 }
                    NumberAnimation { target: rotationStand; to: 180; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        label.visible = false
                        card_item.z = 5+Data.redGraveCards.length
                    }
                }
            }
        },
        Transition {
            from: "redHorizontalFaceupFront"
            to: "redGrave"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 488; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 360; duration: 200 }
                    NumberAnimation { target: rotationStand; to: 180; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        label.visible = false
                        card_item.z = 5+Data.redGraveCards.length
                    }
                }
            }
        }
    ]

    MouseArea {
        id: cursorArea
        anchors.fill: card_item
        acceptedButtons: Qt.LeftButton
        onClicked: {
            Data.highlightCard(card_item)
        }
    }
}
