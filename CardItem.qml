import QtQuick 2.0
import QtGraphicalEffects 1.12
import "data.js" as Data
import QtQuick.Controls 2.14
import QtMultimedia 5.14

Item {
    id: card_item
    width: 90
    height: 130
    state: "none"

    Audio {
        id: card_moveMusic
        source: "qrc:/voice/card_move.wav"
    }

    property int isdn
    property int index
    property var judgeResult: []
    property int judgeIndex: 0

    property alias swordVisible: sword.visible

    NumberAnimation { id: highlightAnimation1; target: card_item; properties: "y"; from: 952; to: 889; duration: 200 }
    NumberAnimation { id: unhighlightAnimation1; target: card_item; properties: "y"; from: 889; to: 952; duration: 200 }
    NumberAnimation { id: highlightAnimation2; target: card_item; properties: "y"; from: -128; to: -65; duration: 200 }
    NumberAnimation { id: unhighlightAnimation2; target: card_item; properties: "y"; from: -65; to: -128; duration: 200 }

    function checkHand() {
        if(card_item.state === "blueHandArea") {
            highlightAnimation1.start();
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

    function checkFront() {
        if(card_item.state === "blueVerticalFaceupFront") {
            if(Data.boardObject.state === "blueMain1Phase" ||
                    Data.boardObject.state === "blueMain2Phase") {
                //
            } else if(Data.boardObject.state === "blueBattlePhase") {
                Data.battleFromIndex = card_item.index;
            }
        } else if(card_item.state === "redVerticalFaceupFront" ||
                  card_item.state === "redHorizontalFacedownFront") {
            if(Data.boardObject.state === "blueBattlePhase") {
                if(Data.battleFromIndex !== -1) {
                    Data.battleToIndex = card_item.index;
//                    var angle0 = Math.atan((mouseX-blueSword0.x-25*1.8)/(blueSword0.y+36*1.8-mouseY))
//                    if((blueSword0.y+36*1.8) < mouseY) {
//                        blueSword0.rotation = angle0/3.1415*180 + 180
//                    } else {
//                        blueSword0.rotation = angle0/3.1415*180
//                    }
                    Data.blueFrontCards[Data.battleFromIndex].swordVisible = false;
                    Data.blueSword.visible = true;
                    Data.blueSwordAnimationObject.start();
                }
            }
        }
    }

    property bool highlight: false
    onHighlightChanged: {
        if(highlight) {
            if(card_item.state === "blueHandArea") {
                highlight_image.source = "qrc:/image/chooseBlue.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
            } else if(card_item.state === "blueVerticalFaceupFront" ||
                      card_item.state === "blueVerticalFacedownFront" ||
                      card_item.state === "blueGrave") {
                highlight_image.source = "qrc:/image/selectBlue.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
            } else if(card_item.state === "blueHorizontalFaceupFront" ||
                      card_item.state === "blueHorizontalFacedownFront") {
                highlight_image.source = "qrc:/image/selectBlue.png";
                highlight_image.rotation = 90;
                highlight_image.visible = true;
            } else if(card_item.state === "redHandArea") {
                highlight_image.source = "qrc:/image/chooseRed.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
                highlightAnimation2.start();
            } else if(card_item.state === "redVerticalFaceupFront" ||
                      card_item.state === "redVerticalFacedownFront" ||
                      card_item.state === "redGrave") {
                highlight_image.source = "qrc:/image/selectRed.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
            } else if(card_item.state === "redHorizontalFaceupFront" ||
                      card_item.state === "redHorizontalFacedownFront") {
                highlight_image.source = "qrc:/image/selectRed.png";
                highlight_image.rotation = 90;
                highlight_image.visible = true;
            }
            Data.sendInfoImage(card_item.isdn);
            Data.oldSelectCard = card_item;

            checkHand();
            checkFront();

        } else {
            highlight_image.visible = false;
            if(card_item.state === "blueHandArea") {
                unhighlightAnimation1.start();
                summonButton.visible = false;
                setButton.visible = false;
                specialButton.visible = false;
            } else if(card_item.state === "redHandArea") {
                unhighlightAnimation2.start();
            }
        }
    }

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
        readOnly: true
        text: Data.boardCards[isdn]["atk"] + "/" + Data.boardCards[isdn]["def"];
    }

    Button {
        id: summonButton
        y: -70
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
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
                highlight_image.visible = false;
                delete Data.oldSelectCard;
                card_item.state = "blueVerticalFaceupFront";
                //                Data.boardSocket.sendTextMessage("summonFront#"+old_place2+"@"+place2);
            }
        }
    }

    Button {
        id: setButton
        y: -140
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
        height: 60
        text: "放置"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: {
            var place = Data.findBlueFrontIndex();
            if(place !== -1) {
                var old_place = card_item.index;
                Data.blueHandCards.splice(old_place, 1);
                Data.blueFrontCards[place] = card_item;
                card_item.index = place;
                card_item.z = 2;
                Data.blueSummonEnable = false;
                highlight_image.visible = false;
                card_item.state = "blueHorizontalFacedownFront";
                //                Data.boardSocket.sendTextMessage("setFront#"+old_place+"@"+place3);
            }
        }
    }

    Button {
        id: specialButton
        y: -210
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
        height: 60
        text: "特殊召唤"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: {
            var place3 = Data.findBlueFrontIndex();
            if(place3 !== -1) {
                var old_place3 = card_item.index;
                Data.blueHandCards.splice(old_place3, 1);
                Data.blueFrontCards[place3] = card_item;
                card_item.index = place3;
                card_item.z = 2;
                card_item.state = "blueVerticalFaceupFront";
                highlight_image.visible = false;
                //                Data.boardSocket.sendTextMessage("specialFront#"+old_place3+"@"+place3);
            }
        }
    }

    Button {
        id: attackButton
        y: -70
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
        height: 60
        text: "攻击"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: {
            var place = Data.findBlueFrontIndex();
            if(place !== -1) {
                var old_place = card_item.index;
                Data.blueHandCards.splice(old_place, 1);
                Data.blueFrontCards[place] = card_item;
                card_item.index = place;
                card_item.z = 2;
                Data.blueSummonEnable = false;
                highlight_image.visible = false;
                card_item.state = "blueHorizontalFacedownFront";
                //                Data.boardSocket.sendTextMessage("setFront#"+old_place+"@"+place3);
            }
        }
    }

    states: [
        State {
            name: "blueDeckArea"
        },
        State {
            name: "blueHandArea"
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
                        card_moveMusic.play();
                        frontItem.source = "qrc:/image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/hand/null.png"
                        card_item.width = 180
                        card_item.height = 261
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: 1318; to: x; duration: 270 }
                    NumberAnimation { target: card_item; properties: "y"; from: 794; to: 952; duration: 270 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 0.5; to: 1.0; duration: 270 }
                    NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 270 }
                }
                ScriptAction {
                    script: {
                        card_moveMusic.stop();
                    }
                }
            }
        },
        Transition {
            from: "blueHandArea"
            to: "blueVerticalFaceupFront"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        card_moveMusic.play();
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
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 630+140*card_item.index; duration: 270 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 571; duration: 270 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 270 }
                }
                ScriptAction {
                    script: {
                        card_moveMusic.stop();
                        Data.adjustBlueHand();
                        label.anchors.top = card_image.bottom
                        label.visible = true
                    }
                }
            }
        },
        Transition {
            from: "blueHandArea"
            to: "blueHorizontalFacedownFront"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        card_moveMusic.play();
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
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 626+140*card_item.index; duration: 270 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 585; duration: 270 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 270 }
                    NumberAnimation { target: rotationFace; from: 0; to: 180; property: "angle"; duration: 270 }
                    NumberAnimation { target: rotationStand; from: 0; to: -90; property: "angle"; duration: 270 }
                }
                ScriptAction {
                    script: {
                        card_moveMusic.stop();
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
                        card_moveMusic.play();
                        frontItem.source = "qrc:/image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "qrc:/image/hand/null2.png"
                        card_item.width = 180
                        card_item.height = 261
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: 486; to: x; duration: 270 }
                    NumberAnimation { target: card_item; properties: "y"; from: 189; to: -128; duration: 270 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 0.5; to: 1.0; duration: 270 }
                }
            }
        },
        Transition {
            from: "redHandArea"
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
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 630+140*(4-card_item.index); duration: 270 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 383; duration: 270 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 270 }
                    NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 270 }
                    NumberAnimation { target: rotationStand; from: 0; to: 180; property: "angle"; duration: 270 }
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
            from: "redHandArea"
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
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 626+140*(4-card_item.index); duration: 270 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 383; duration: 270 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 270 }
                    NumberAnimation { target: rotationStand; from: 0; to: -90; property: "angle"; duration: 270 }
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
        onClicked: {
            if(Data.oldSelectCard !== undefined) {
                Data.oldSelectCard.highlight = false;
            }
            card_item.highlight = true;
        }
    }
}
