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
    back: Image { source: "qrc:/image/area/null.png"; anchors.centerIn: card_item }

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
    state: "deckArea"

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
        if(state === "deckArea") {
            frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
        }
    }

    //0:deck 1:hand 2:front 3:back 4:grave
    property bool isInHand : false
    onIsInHandChanged: {
        if(isInHand) {
            frontItem.source = "qrc:/image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
            card_item.width = 100
            card_item.height = 145
        } else {
            frontItem.source = "qrc:/image/area/" + Data.boardCards[isdn]["name"]+ ".png"
            card_item.width = 50
            card_item.height = 72
        }
    }
    property bool highlight: false
    onHighlightChanged: {
    }

    states: [
        State {
            name: "deckArea"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "handArea"
            PropertyChanges {
                target: card_item
                isInHand: true
            }
        },
        State {
            name: "summonFront"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "setFront"
            PropertyChanges {
                target: card_item
                isInHand: false
            }
        },
        State {
            name: "effectBack"
        },
        State {
            name: "setBack"
        }
    ]

    transitions: [
        Transition {
            from: "deckArea"
            to: "handArea"
            ParallelAnimation {
                NumberAnimation { target: card_item; properties: "x"; from: 732; to: x; duration: 200 }
                NumberAnimation { target: card_item; properties: "y"; from: 441; to: 529; duration: 200 }
                NumberAnimation { target: card_item; properties: "scale"; from: 0.5; to: 1.0; duration: 200 }
                NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 200 }
            }
        },
        Transition {
            from: "handArea"
            to: "summonFront"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 350+78*index; duration: 200 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 317; duration: 200 }
                    NumberAnimation { target: card_item; properties: "z"; to: 2; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                    NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                }
                ScriptAction { script: label.visible = true; }
            }

        },
        Transition {
            from: "handArea"
            to: "setFront"
            ParallelAnimation {
                NumberAnimation { target: card_item; properties: "x"; from: x; to: 348+78*index; duration: 200 }
                NumberAnimation { target: card_item; properties: "y"; from: y; to: 325; duration: 200 }
                NumberAnimation { target: card_item; properties: "z"; to: 2; duration: 200 }
                NumberAnimation { target: card_item; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                NumberAnimation { target: rotationFace; from: 0; to: 180; property: "angle"; duration: 200 }
                NumberAnimation { target: rotationStand; from: 0; to: 90; property: "angle"; duration: 200 }
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
            console.log("攻击表示....")//攻击表示
            cursorArea.cursorShape = Qt.SizeVerCursor
        } else if(judgeResult[judgeIndex] === 6) {
            console.log("防御表示....")//防御表示
            cursorArea.cursorShape = Qt.SizeHorCursor
        } else if(judgeResult[judgeIndex] === 7) {
            console.log("攻击....")//攻击
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
            if(card_item.state === "handArea") {
                card_item.y = 494;
                Data.sendInfoImage(isdn)
                judgeResult = Data.judgeHandCard(card_item.index);
                judgeCursor();
            } else if(card_item.state === "summonFront" || card_item.state === "setFront") {
                Data.sendInfoImage(isdn);
                judgeResult = Data.judgeFrontCard(card_item.index);
                judgeCursor();
            }
        }
        onExited: {
            if(card_item.state === "handArea") {
                card_item.y = 529;
                cursorArea.cursorShape = Qt.ArrowCursor;
                judgeIndex = 0;
                judgeResult = [];
            } else if(card_item.state === "summonFront" || card_item.state === "setFront") {
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
                if(judgeResult[judgeIndex] === 3) {
                    var place2 = Data.findBlueFrontIndex();
                    if(place2 !== -1) {
                        console.log("receive front summon " + card_item.index);
                        Data.blueHandCards.splice(card_item.index, 1);
                        Data.adjustHand();
                        Data.blueFrontCards[place2] = card_item;
                        card_item.index = place2;
                        card_item.z = 2;
                        card_item.state = "summonFront";
//                        Data.blueSummonEnable = false;
                    } else {
                        console.log("can not find empty front area");
                    }
                } else if(judgeResult[judgeIndex] === 4) {
                    var place = Data.findBlueFrontIndex();
                    if(place !== -1) {
                        console.log("receive front set " + card_item.index);
                        Data.blueHandCards.splice(card_item.index, 1);
                        Data.adjustHand();
                        Data.blueFrontCards[place] = card_item;
                        card_item.index = place;
                        card_item.z = 2;
                        card_item.state = "setFront";
//                        Data.blueSummonEnable = false;
                    } else {
                        console.log("can not find empty front area");
                    }
                }
            }
        }
    }
}
