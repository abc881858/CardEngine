import QtQuick 2.0
import QtGraphicalEffects 1.12
import "data.js" as Data

Flipable {
    id: card_item
    property int index
    property var judgeResult: []
    property int judgeIndex: 0
    property alias swordVisiable: sword.visible

    front: Image { id: frontItem; source: "qrc:/image/area/null.png"; anchors.centerIn: card_item }
    back: Image { id: backItem; source: "qrc:/image/area/null.png"; anchors.centerIn: card_item }

    Image {
        id: sword
        anchors.centerIn: parent
        source: "qrc:/image/sword.png"
        visible: false
    }

    TextInput {
        id: label
        anchors.horizontalCenter: frontItem.horizontalCenter
        anchors.top: frontItem.bottom
        anchors.topMargin: 5
        width: 65
        height: 17
        color: "#ffffff"
        font.pixelSize: 14
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        visible: false
        text: Data.boardCards[isdn]["atk"] + "/" + Data.boardCards[isdn]["def"];
    }

    width: 50
    height: 72
    state: "none"

    transform: [
        Rotation {
            id: rotationFace;
            origin.x: card_item.width / 2;
            origin.y: card_item.height / 2
            axis { x: 0; y: 1; z: 0 }
            angle: 180
        },
        Rotation {
            id: rotationStand;
            origin.x: card_item.width / 2;
            origin.y: card_item.height / 2
            axis { x: 0; y: 0; z: 1 }
        }
    ]

    property int isdn
    onIsdnChanged: {
        if(state === "blueDeckArea") {
            frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
        } else if(state === "redDeckArea") {
            frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
            backItem.source = "qrc:/image/area/null2.png"
        }
    }

    //0:deck 1:hand 2:front 3:back 4:grave
    property bool isInHand : false
    onIsInHandChanged: {
        if(isInHand) {
            frontItem.source = "qrc:/image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
            card_item.width = 100
            card_item.height = 145
            if(state === "blueDeckArea") {
                backItem.source = "qrc:/image/hand/null.png"
            } else {
                backItem.source = "qrc:/image/hand/null2.png"
            }
        } else {
            frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
            card_item.width = 50
            card_item.height = 72
            if(state === "blueDeckArea") {
                backItem.source = "qrc:/image/area/null.png"
            } else {
                backItem.source = "qrc:/image/area/null2.png"
            }
        }
    }
    property bool highlight: false
    onHighlightChanged: {
    }

    states: [
        State {
            name: "blueDeckArea"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "blueHandArea"
            PropertyChanges {
                target: card_item
                isInHand: true
            }
        },
        State {
            name: "blueVerticalFaceupFront"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "blueHorizontalFacedownFront"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "blueActiveBack"
        },
        State {
            name: "blueSetBack"
        },
        State {
            name: "redDeckArea"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "redHandArea"
            PropertyChanges {
                target: card_item
                isInHand: true
            }
        },
        State {
            name: "redVerticalFaceupFront"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "redHorizontalFacedownFront"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "redActiveBack"
        },
        State {
            name: "redSetBack"
        },
        State {
            name: "blueBattle"
        }
    ]

    transitions: [
        Transition {
            from: "blueDeckArea"
            to: "blueHandArea"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: 732; to: x; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: 441; to: 529; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 0.5; to: 1.0; duration: 200 }
                    NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 200 }
                }
            }
        },
        Transition {
            from: "blueHandArea"
            to: "blueVerticalFaceupFront"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 350+78*card_item.index; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 317; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                }
                ScriptAction {
                    script: {
                        label.visible = true
                        Data.adjustBlueHand();
                    }
                }
            }
        },
        Transition {
            from: "blueHandArea"
            to: "blueHorizontalFacedownFront"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 348+78*card_item.index; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 325; duration: 200 }
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
            from: "redDeckArea"
            to: "redHandArea"
            ParallelAnimation {
                NumberAnimation { target: card_item; properties: "x"; from: 270; to: x; duration: 200 }
                NumberAnimation { target: card_item; properties: "y"; from: 105; to: -71; duration: 200 }
                NumberAnimation { target: card_item; properties: "scale"; from: 0.5; to: 1.0; duration: 200 }
            }
        },
        Transition {
            from: "redHandArea"
            to: "redVerticalFaceupFront"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 350+78*(4-card_item.index); duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 213; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                    NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 200 }
                    NumberAnimation { target: rotationStand; from: 0; to: 180; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        Data.adjustRedHand();
                        label.visible = true
                    }
                }
            }
        },
        Transition {
            from: "redHandArea"
            to: "redHorizontalFacedownFront"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 348+78*(4-card_item.index); duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 213; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                    NumberAnimation { target: rotationStand; from: 0; to: 90; property: "angle"; duration: 200 }
                }
                ScriptAction {
                    script: {
                        Data.adjustRedHand();
                    }
                }
            }
        },
        Transition {
            from: "blueVerticalFaceupFront";
            to: "blueBattle";
            ScriptAction {
                script: {
                    swordVisiable = true;
                }
            }
        }
    ]

    function judgeCursor() {
        if(judgeResult[judgeIndex] === 1) {
            console.log("fadongxiaoguo....")//发动效果
            cursorArea.cursorShape = Qt.WaitCursor
        } else if(judgeResult[judgeIndex] === 2) {
            console.log("teshuzhaohuan....")//特殊召唤
            cursorArea.cursorShape = Qt.PointingHandCursor
        } else if(judgeResult[judgeIndex] === 3) {
            console.log("zhaohuan....")//召唤
            cursorArea.cursorShape = Qt.OpenHandCursor
        } else if(judgeResult[judgeIndex] === 4) {
            console.log("fangzhi....")//放置
            cursorArea.cursorShape = Qt.ClosedHandCursor
        } else if(judgeResult[judgeIndex] === 5) {
            console.log("gongjibiaoshi....")//攻击表示
            cursorArea.cursorShape = Qt.SizeVerCursor
        } else if(judgeResult[judgeIndex] === 6) {
            console.log("fangyubiaoshi....")//防御表示
            cursorArea.cursorShape = Qt.SizeHorCursor
        } else if(judgeResult[judgeIndex] === 7) {
            console.log("gongji....")//攻击
            cursorArea.cursorShape = Qt.SizeAllCursor
        } else {
            cursorArea.cursorShape = Qt.ArrowCursor//无
        }
    }

    MouseArea {
        id: cursorArea
        anchors.fill: card_item
        hoverEnabled : true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: {
            if(card_item.state === "blueHandArea") {
                card_item.y = 494;
                Data.sendInfoImage(isdn)
                judgeResult = Data.judgeHandCard(card_item.index);
                judgeCursor();
            } else if(card_item.state === "redHandArea") {
                card_item.y = -36;
                Data.sendInfoImage(0)
            } else if(card_item.state === "redVerticalFaceupFront") {
                Data.sendInfoImage(isdn)
            } else if(card_item.state === "redHorizontalFacedownFront") {
                Data.sendInfoImage(0)
            } else if(card_item.state === "blueVerticalFaceupFront" ||
                      card_item.state === "blueHorizontalFacedownFront") {
                Data.sendInfoImage(isdn);
                judgeResult = Data.judgeFrontCard(card_item.index);
                judgeCursor();
            } else if(card_item.state == "blueBattle") {
                Data.sendInfoImage(isdn);
                judgeResult = Data.judgeFrontCard(card_item.index);
                judgeCursor();
            }
        }
        onExited: {
            if(card_item.state === "blueHandArea") {
                card_item.y = 529;
                cursorArea.cursorShape = Qt.ArrowCursor;
                judgeIndex = 0;
                judgeResult = [];
            } else if(card_item.state === "redHandArea") {
                card_item.y = -71;
                Data.sendInfoImage(0)
            } else if(card_item.state === "blueVerticalFaceupFront" ||
                      card_item.state === "blueHorizontalFacedownFront") {
                cursorArea.cursorShape = Qt.ArrowCursor;
                judgeIndex = 0;
                judgeResult = [];
            } else if(card_item.state == "blueBattle") {
                cursorArea.cursorShape = Qt.ArrowCursor;
                judgeIndex = 0;
                judgeResult = [];
            }
        }
        onClicked: {
            if(mouse.button === Qt.RightButton) {
                var size = judgeResult.length;
                if(size!==0) {
                    judgeIndex = (judgeIndex+1)%size;
                    judgeCursor();
                }
            } else {
                if(judgeResult[judgeIndex] === 2) {
                    var place3 = Data.findBlueFrontIndex();
                    if(place3 !== -1) {
                        var old_place3 = card_item.index;
                        console.log("receive front special summon " + old_place3);
                        Data.blueHandCards.splice(old_place3, 1);
                        Data.blueFrontCards[place3] = card_item;
                        card_item.index = place3;
                        card_item.z = 2;
                        card_item.state = "blueVerticalFaceupFront";
                        Data.boardSocket.sendTextMessage("specialFront#"+old_place3+"@"+place3);
                    } else {
                        console.log("can not find empty front area");
                    }
                } else if(judgeResult[judgeIndex] === 3) {
                    var place2 = Data.findBlueFrontIndex();
                    if(place2 !== -1) {
                        var old_place2 = card_item.index;
                        console.log("receive front summon " + old_place2);
                        Data.blueHandCards.splice(old_place2, 1);
                        Data.blueFrontCards[place2] = card_item;
                        card_item.index = place2;
                        card_item.z = 2;
                        Data.blueSummonEnable = false;
                        card_item.state = "blueVerticalFaceupFront";
                        Data.boardSocket.sendTextMessage("summonFront#"+old_place2+"@"+place2);
                    } else {
                        console.log("can not find empty front area");
                    }
                } else if(judgeResult[judgeIndex] === 4) {
                    var place = Data.findBlueFrontIndex();
                    if(place !== -1) {
                        var old_place = card_item.index;
                        console.log("receive front set " + old_place);
                        Data.blueHandCards.splice(old_place, 1);
                        Data.blueFrontCards[place] = card_item;
                        card_item.index = place;
                        card_item.z = 2;
                        Data.blueSummonEnable = false;
                        card_item.state = "blueHorizontalFacedownFront";
                        Data.boardSocket.sendTextMessage("setFront#"+old_place+"@"+place3);
                    } else {
                        console.log("can not find empty front area");
                    }
                } else if(judgeResult[judgeIndex] === 7) {
                    Data.battleFromIndex = card_item.index;
                }
            }
        }
    }
}
