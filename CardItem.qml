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
//        source: "voice/card_move.wav"
    }
    Audio {
        id: ikenieMusic
//        source: "voice/ikenie.wav"
    }
    Audio {
        id: magic_activeMusic
//        source: "voice/magic_active.wav"
    }
    Audio {
        id: card_attacked_brakeMusic
//        source: "voice/card_attacked_brake.wav"
    }
    Audio {
        id: card_openMusic
//        source: "voice/card_open.wav"
    }

    property int isdn
    property int index
    property var judgeResult: []
    property int judgeIndex: 0

    property alias swordVisible: sword.visible
    property alias swordRotation: sword.rotation

    function effectActive() {
        effectActiveAnimation.start();
    }
    function effectLabel() {
        var atkNum = Number(Data.boardCards[isdn]["atk"]) - 500;
        var defNum = Number(Data.boardCards[isdn]["def"]) - 500;
        if(atkNum < 0) atkNum = 0;
        if(defNum < 0) defNum = 0;
        label.text = atkNum.toString() + "/" + defNum.toString();
    }

    NumberAnimation { id: highlightAnimation1; target: card_item; properties: "y"; from: 952; to: 889; duration: 200 }
    NumberAnimation { id: unhighlightAnimation1; target: card_item; properties: "y"; from: 889; to: 952; duration: 200 }
    NumberAnimation { id: highlightAnimation2; target: card_item; properties: "y"; from: -128; to: -65; duration: 200 }
    NumberAnimation { id: unhighlightAnimation2; target: card_item; properties: "y"; from: -65; to: -128; duration: 200 }

    function checkHand() {
        if(card_item.state === "blueHandArea") {
            if(Data.boardObject.state === "blueMain1Phase" || Data.boardObject.state === "blueMain2Phase") {
                if(Data.findBlueFrontIndex() !== -1) {
                    if(Data.blueSummonEnable) {
                        var card_level = Number(Data.boardCards[card_item.isdn]["level"]);
                        if(card_level < 5) {
                            summonButton.visible = true;
                            setButton.visible = true;
                        } else {
                            var blueFrontMonsterNumber = Data.getBlueFrontMonsterNumber();
                            if(card_level < 7 && blueFrontMonsterNumber > 0){
                                summonButton.visible = true;
                                setButton.visible = true;
                                Data.tributeNumber = 1
                            } else if(card_level < 9 && blueFrontMonsterNumber > 1){
                                summonButton.visible = true;
                                setButton.visible = true;
                                Data.tributeNumber = 2
                            } else if(card_level < 11 && blueFrontMonsterNumber > 2){
                                summonButton.visible = true;
                                setButton.visible = true;
                                Data.tributeNumber = 3
                            } else {
                                tipInfo.source = "image/tip/tip1.png"//必须要有祭品 才能召唤上场
                                tipInfo.visible = true
                            }
                        }
                    } else {
                        tipInfo.source = "image/tip/tip3.png"//战斗流程中 不能召唤
                        tipInfo.visible = true
                    }
                }
            }
        }
    }

    function checkFront() {
        if(card_item.state === "blueVerticalFaceupFront") {
            if(Data.boardObject.state === "blueMain1Phase" || Data.boardObject.state === "blueMain2Phase") {
                //
            } else if(Data.boardObject.state === "blueBattlePhase") {
                attackButton.visible = true
            }
        } else if(card_item.state === "redVerticalFaceupFront" || card_item.state === "redHorizontalFacedownFront") {
            if(Data.boardObject.state === "blueBattlePhase") {
                if(Data.battleFromIndex !== -1) {
                    Data.battleToIndex = card_item.index;
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
                highlight_image.source = "image/chooseBlue.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
                highlightAnimation1.start();
            } else if(card_item.state === "blueVerticalFaceupFront" ||
                      card_item.state === "blueVerticalFacedownFront" ||
                      card_item.state === "blueGrave") {
                highlight_image.source = "image/selectBlue.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
            } else if(card_item.state === "blueHorizontalFaceupFront" ||
                      card_item.state === "blueHorizontalFacedownFront") {
                highlight_image.source = "image/selectBlue.png";
                highlight_image.rotation = 90;
                highlight_image.visible = true;
            } else if(card_item.state === "redHandArea") {
                highlight_image.source = "image/chooseRed.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
                highlightAnimation2.start();
            } else if(card_item.state === "redVerticalFaceupFront" ||
                      card_item.state === "redVerticalFacedownFront" ||
                      card_item.state === "redGrave") {
                highlight_image.source = "image/selectRed.png";
                highlight_image.rotation = 0;
                highlight_image.visible = true;
            } else if(card_item.state === "redHorizontalFaceupFront" ||
                      card_item.state === "redHorizontalFacedownFront") {
                highlight_image.source = "image/selectRed.png";
                highlight_image.rotation = 90;
                highlight_image.visible = true;
            }
            Data.sendInfoImage(card_item.isdn);
            Data.oldSelectCard = card_item;

            if(Data.blueTributeSummon === true) {
                if(card_item.state === "blueVerticalFaceupFront" ||
                        card_item.state === "blueVerticalFacedownFront" ||
                        card_item.state === "blueHorizontalFaceupFront" ||
                        card_item.state === "blueHorizontalFacedownFront") {
                    tributeButton.visible = true;
                }
            } else if(Data.blueChainCard === true) {
                if(Data.blueFrontMatchActiveCondition(card_item.index) && card_item.state === "blueVerticalFaceupFront") {
                    activeButton.visible = true;
                }
            } else {
                checkHand();
                checkFront();
            }
        } else {
            highlight_image.visible = false;

            tipInfo.visible = false;

            summonButton.visible = false;
            setButton.visible = false;
            specialButton.visible = false;
            tributeButton.visible = false;
            attackButton.visible = false;
            activeButton.visible = false;

            if(card_item.state === "blueHandArea") {
                unhighlightAnimation1.start();
            } else if(card_item.state === "redHandArea") {
                unhighlightAnimation2.start();
            }
        }
    }

    Flipable {
        id: card_image
        anchors.fill: card_item
        front: Image { id: frontItem; source: "image/area/null.png"; anchors.centerIn: card_image }
        back: Image { id: backItem; source: "image/area/null.png"; anchors.centerIn: card_image }
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
        id: effect1
        width: 90
        height: 130
        clip: true
        anchors.horizontalCenter: card_item.horizontalCenter
        anchors.verticalCenter: card_item.verticalCenter
        source: frontItem.source
        visible: false
        Image {
            id: effectRainbow
            anchors.fill: effect1
            width: 138
            height: 130
            source: "image/eff_rainbow.png"
            visible: false
        }
    }

    Image {
        id: effect2
        width: 142
        height: 140
        opacity: 0.0
        anchors.horizontalCenter: card_item.horizontalCenter
        anchors.verticalCenter: card_item.verticalCenter
        source: "image/eff_set_b.png"
        visible: false
    }

    Image {
        id: sword
        anchors.fill: card_item
        source: "image/sword.png"
        visible: false
    }

    Image {
        id: tipInfo
        width: 290
        height: 72
        anchors.horizontalCenter: card_item.horizontalCenter
        anchors.bottom: card_item.top
        anchors.topMargin: 5
        source: "image/tip/tip1.png"
        visible: false
    }

    Image {
        id: highlight_image
        anchors.fill: card_item
        x: -5
        y: -5
        source: "image/chooseBlue.png"
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
            card_item.highlight = false;
            var place2 = Data.findBlueFrontIndex();
            if(place2 !== -1) {
                if(Data.tributeNumber === 0) {
                    var old_place2 = card_item.index;
                    Data.blueHandCards.splice(old_place2, 1);
                    Data.blueFrontCards[place2] = card_item;
                    card_item.index = place2;
                    card_item.z = 2;
//                    Data.blueSummonEnable = false;
                    card_item.state = "blueVerticalFaceupFront";
                    //Data.boardSocket.sendTextMessage("summonFront#"+old_place2+"@"+place2);
                } else if(Data.tributeNumber === 1) {
                    Data.tributeCard = card_item;
                    Data.boardDialog.source = "image/dialog/dialog2.png"
                    Data.boardDialog.index = 2
                    Data.boardDialog.visible = true
                } else if(Data.tributeNumber === 2) {
                    Data.tributeCard = card_item;
                    Data.boardDialog.source = "image/dialog/dialog3.png"
                    Data.boardDialog.index = 3
                    Data.boardDialog.visible = true
                } else if(Data.tributeNumber === 3) {
                    Data.tributeCard = card_item;
                    Data.boardDialog.source = "image/dialog/dialog4.png"
                    Data.boardDialog.index = 4
                    Data.boardDialog.visible = true
                }
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
            card_item.highlight = false
            var place = Data.findBlueFrontIndex();
            if(place !== -1) {
                var old_place = card_item.index;
                Data.blueHandCards.splice(old_place, 1);
                Data.blueFrontCards[place] = card_item;
                card_item.index = place;
                card_item.z = 2;
                Data.blueSummonEnable = false;
                card_item.state = "blueHorizontalFacedownFront";
                //Data.boardSocket.sendTextMessage("setFront#"+old_place+"@"+place3);
            }
        }
    }

    Button {
        id: tributeButton
        y: -70
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
        height: 60
        text: "献祭"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: {
            card_item.highlight = false
            card_item.state = "blueGrave";
        }
    }

    Image {
        id: effect3
        width: 133
        height: 131
        opacity: 0.0
        anchors.horizontalCenter: card_item.horizontalCenter
        anchors.verticalCenter: card_item.verticalCenter
        source: "image/active.png"
        visible: false
    }

    SequentialAnimation {
        id: effectActiveAnimation
        running: false
        ScriptAction { script: { magic_activeMusic.play(); effect3.visible = true } }
        ParallelAnimation {
            NumberAnimation { target: effect3; properties: "scale"; from: 0.0; to: 1.0; duration: 600; }
            NumberAnimation { target: effect3; properties: "opacity"; from: 0.0; to: 1.0; duration: 600; }
        }
        ScriptAction { script: { effect3.visible = false } }
    }

    SequentialAnimation {
        id: effect3Animation
        running: false
        ScriptAction { script: { effectActiveAnimation.start() } }
        PauseAnimation { duration: 1000 }
        //先翻转再攻击我
        ScriptAction {
            script: {
                Data.redFrontCards[0].state = "redVerticalFaceupFront"
                Data.redFrontCards[0].swordVisible = false
                Data.redSwordAnimationObject.start()
            }
        }
    }

    Button {
        id: activeButton
        y: -70
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
        height: 60
        text: "发动"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: { //点击发动按钮
            card_item.highlight = false
            Data.blueChainCard = false
            effect3Animation.start(); //效果3发动
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
            card_item.highlight = false
            var place3 = Data.findBlueFrontIndex();
            if(place3 !== -1) {
                var old_place3 = card_item.index;
                Data.blueHandCards.splice(old_place3, 1);
                Data.blueFrontCards[place3] = card_item;
                card_item.index = place3;
                card_item.z = 2;
                card_item.state = "blueVerticalFaceupFront";
                //Data.boardSocket.sendTextMessage("specialFront#"+old_place3+"@"+place3);
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
            card_item.highlight = false
            Data.battleFromIndex = card_item.index;
            if(Data.getRedFrontMonsterNumber() === 0) {
                Data.blueFrontCards[Data.battleFromIndex].swordVisible = false;
                Data.blueSword.visible = true;
                Data.blueSwordAnimationObject.start();
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
                    frontItem.source = "image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                    backItem.source = "image/area/null.png"
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
                        frontItem.source = "image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "image/hand/null.png"
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
                        frontItem.source = "image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "image/area/null.png"
                        card_item.width = 90
                        card_item.height = 130
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
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            effectRainbow.opacity = 0
                            effectRainbow.visible = false
                            effect1.opacity = 0.75
                            effect1.visible = true
                        }
                    }
                    NumberAnimation { target: effect1; properties: "scale"; from: 2.0; to: 1.0; duration: 200 }
                    ScriptAction {
                        script: {
                            effectRainbow.visible = true
                        }
                    }
                    ParallelAnimation {
                        NumberAnimation { target: effectRainbow; properties: "opacity"; from: 0; to: 1; duration: 400 }
                        NumberAnimation { target: effectRainbow; properties: "x"; from: -48; to: -24; duration: 400 }
                    }
                    ParallelAnimation {
                        NumberAnimation { target: effectRainbow; properties: "opacity"; from: 1; to: 0; duration: 400 }
                        NumberAnimation { target: effectRainbow; properties: "x"; from: -24; to: 0; duration: 400 }
                    }
                    ScriptAction {
                        script: {
                            effect1.visible = false
                        }
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
                        frontItem.source = "image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "image/area/null.png"
                        card_item.width = 90
                        card_item.height = 130
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
                    frontItem.source = "image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                    backItem.source = "image/area/null2.png"
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
                        frontItem.source = "image/hand/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "image/hand/null2.png"
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
                        ikenieMusic.play();
                        frontItem.source = "image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "image/area/null2.png"
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
                        card_moveMusic.play();
                        frontItem.source = "image/area/" + Data.boardCards[isdn]["name"]+ ".png"
                        backItem.source = "image/area/null.png"
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
                ScriptAction { script: { card_openMusic.play(); } }
                NumberAnimation { target: rotationFace; from: -180; to: 0; property: "angle"; duration: 270 }
                ScriptAction {
                    script: {
                        label.anchors.bottom = card_image.top
                        label.visible = true
                    }
                }
            }
        },
        Transition {
            from: "redHorizontalFacedownFront"
            to: "redVerticalFaceupFront"
            SequentialAnimation {
                ScriptAction { script: { card_openMusic.play(); } }
                ParallelAnimation {
                    NumberAnimation { target: rotationFace; from: 180; to: 0; property: "angle"; duration: 270 }
                    NumberAnimation { target: rotationStand; from: -90; to: 0; property: "angle"; duration: 270 }
                }
                ScriptAction {
                    script: {
                        label.anchors.bottom = card_image.top
                        label.visible = true
                    }
                }
            }
        },
        Transition {
            to: "blueGrave"
            SequentialAnimation {
                ScriptAction { script: { effect2.visible = true; ikenieMusic.play(); } }
                ParallelAnimation {
                    NumberAnimation { target: effect2; property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
                    NumberAnimation { target: effect2; property: "scale"; from: 0.1; to: 1.0; duration: 200 }
                    NumberAnimation { target: effect2; property: "rotation"; from: 0; to: 360; duration: 1600 }
                }
                ParallelAnimation {
                    NumberAnimation { target: effect2; property: "scale"; from: 1.0; to: 2.0; duration: 200 }
                    NumberAnimation { target: effect2; property: "opacity"; from: 1.0; to: 0.0; duration: 200 }
                }
                SequentialAnimation {
                    ScriptAction { script: { card_item.z = 5+Data.blueGraveCards.length } }
                    ParallelAnimation {
                        NumberAnimation { target: card_item; properties: "x"; from: x; to: 1334; duration: 200 }
                        NumberAnimation { target: card_item; properties: "y"; from: y; to: 594; duration: 200 }
                        NumberAnimation { target: rotationStand; to: 0; property: "angle"; duration: 200 }
                        NumberAnimation { target: rotationFace; to: 0; property: "angle"; duration: 200 }
                    }
                    ScriptAction {
                        script: {
                            label.visible = false
                            effect2.visible = false
                            delete Data.blueFrontCards[card_item.index];
                            Data.tributeNumber = Data.tributeNumber - 1;
                            if(Data.tributeNumber === 0) {
                                Data.blueTributeSummon = false;
                                var place2 = Data.findBlueFrontIndex();
                                var old_place2 = Data.tributeCard.index;
                                Data.blueHandCards.splice(old_place2, 1);
                                Data.blueFrontCards[place2] = Data.tributeCard;
                                Data.tributeCard.index = place2;
                                Data.tributeCard.z = 5+Data.blueGraveCards.length
                                Data.tributeCard.highlight = false;
                                Data.blueSummonEnable = false;
                                Data.tributeCard.state = "blueVerticalFaceupFront";
                            }
                        }
                    }
                }
            }
        },
        Transition {
            to: "redGrave"
            SequentialAnimation {
                ScriptAction { script: { card_attacked_brakeMusic.play(); } }
                ParallelAnimation {
                    NumberAnimation { target: card_item; properties: "x"; from: x; to: 488; duration: 270 }
                    NumberAnimation { target: card_item; properties: "y"; from: y; to: 360; duration: 270 }
                    NumberAnimation { target: rotationStand; to: -180; property: "angle"; duration: 270 }
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
