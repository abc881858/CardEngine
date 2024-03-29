import QtQuick 2.0
import QtGraphicalEffects 1.12
import "data.js" as Data
import QtQuick.Controls 2.14
import QtMultimedia 5.14

Item {
    id: card_item
    Audio {
        id: card_moveMusic
        source: "voice/card_move.wav"
    }
    Audio {
        id: ikenieMusic
        source: "voice/ikenie.wav"
    }
    Audio {
        id: magic_activeMusic
        source: "voice/magic_active.wav"
    }
    Audio {
        id: card_attacked_brakeMusic
        source: "voice/card_attacked_brake.wav"
    }
    Audio {
        id: card_openMusic
        source: "voice/card_open.wav"
    }
    Audio {
        id: attackMusic
        source: "voice/attack.wav"
    }

    width: 90
    height: 130
    state: "none"

    property bool attackEveryTurn: true
    property int isdn
    property int index
    property var judgeResult: []
    property int judgeIndex: 0

    property alias swordVisible: sword.visible
    property alias swordRotation: sword.rotation

    TextInput {
        id: label
        property string atkLabel: Data.boardCards[isdn]["atk"]
        property string defLabel: Data.boardCards[isdn]["def"]
        anchors.horizontalCenter: card_image.horizontalCenter
        anchors.topMargin: 5
        width: 117
        height: 31
        color: "#ffffff"
        font.pixelSize: 24
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        visible: false
        readOnly: true
        text: atkLabel + "/" + defLabel;
    }

    NumberAnimation { id: highlightAnimation1; target: card_item; properties: "y"; from: 952; to: 889; duration: 200 }
    NumberAnimation { id: unhighlightAnimation1; target: card_item; properties: "y"; from: 889; to: 952; duration: 200 }
    NumberAnimation { id: highlightAnimation2; target: card_item; properties: "y"; from: -128; to: -65; duration: 200 }
    NumberAnimation { id: unhighlightAnimation2; target: card_item; properties: "y"; from: -65; to: -128; duration: 200 }

    function checkHand() {
        if(card_item.state === "blueHandArea") {
            if(Data.boardObject.state === "blueMain1Phase" || Data.boardObject.state === "blueMain2Phase") {
                if(Data.findBlueFrontIndex() !== -1) {
                    if(Data.blueSpecialSummonEnable) {
                        if(Data.canSpecialSummon(card_item.isdn)) {
                            specialButton.visible = true;
                        }
                    }
                    if(Data.blueSummonEnable) {
                        var card_level = Number(Data.boardCards[card_item.isdn]["level"]);
                        if(card_level < 5) {
                            summonButton.visible = true;
                            setButton.visible = true;
                            Data.tributeNumber = 0
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
                if(Data.canActive(card_item.isdn)) {
                    activeButton.visible = true;
                }
            } else if(Data.boardObject.state === "blueBattlePhase") {
                if(card_item.attackEveryTurn) {
                    attackButton.visible = true;
                }
            } else if(Data.boardObject.state === "blueChainPhase") {
                if(Data.canActive(card_item.isdn)) {
                    activeButton.visible = true;
                }
            } else if(Data.boardObject.state === "blueTributePhase") {
                tributeButton.visible = true;
            }
        } else if(card_item.state === "blueHorizontalFaceupFront") {
            if(Data.boardObject.state === "blueMain1Phase" || Data.boardObject.state === "blueMain2Phase") {
                if(Data.canActive(card_item.isdn)) {
                    activeButton.visible = true;
                }
            } else if(Data.boardObject.state === "blueTributePhase") {
                tributeButton.visible = true;
            }
        } else if(card_item.state === "blueVerticalFacedownFront") {
            if(Data.boardObject.state === "blueTributePhase") {
                tributeButton.visible = true;
            }
        } else if(card_item.state === "blueHorizontalFacedownFront") {
            if(Data.boardObject.state === "blueTributePhase") {
                tributeButton.visible = true;
            }
        } else if(card_item.state === "redVerticalFaceupFront") {
            if(Data.boardObject.state === "blueBattlePhase") {
                if(Data.battleFromIndex !== -1) {
                    Data.battleToIndex = card_item.index;
                    Data.blueFrontCards[Data.battleFromIndex].swordVisible = false;
                }
            }
            if(Data.boardObject.state === "blueSpecifyPhase") {
                specifyButton.visible = true;
            }
        } else if(card_item.state === "redHorizontalFaceupFront") {
            if(Data.boardObject.state === "blueSpecifyPhase") {
                specifyButton.visible = true;
            }
        } else if(card_item.state === "redHorizontalFacedownFront") {
            if(Data.boardObject.state === "blueBattlePhase") {
                if(Data.battleFromIndex !== -1) {
                    Data.battleToIndex = card_item.index;
                    Data.blueFrontCards[Data.battleFromIndex].swordVisible = false;
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

            checkHand();
            checkFront();
        } else {
            highlight_image.visible = false;

            tipInfo.visible = false;

            summonButton.visible = false;
            setButton.visible = false;
            specialButton.visible = false;
            tributeButton.visible = false;
            specifyButton.visible = false;
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
        x: 0
        y: 0
        rotation: 0
        source: "image/sword.png"
        visible: false
        property int endX: 235
        property int endY: -486
    }

    function swordAnimationStart () {
        swordAnimation.start();
    }

    SequentialAnimation {
        id: swordAnimation
        ScriptAction {
            script:
            {
                sword.visible = true;
                if(Data.boardObject.state === "blueBattleAnimation")
                {
                    sword.endX = 235;
                    sword.endY = -486;
                    sword.rotation = 0;
                }
                else if(Data.boardObject.state === "redBattleAnimation")
                {
                    sword.endX = -520;
                    sword.endY = 509;
                    sword.rotation = 180;
                }
            }
        }
        NumberAnimation {
            target: sword;
            properties: "rotation";
            from: (Data.boardObject.state === "blueBattleAnimation") ? 0 : 180;
            to: from + 26;
            duration: 200
        }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { attackMusic.play() } }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: sword;
                properties: "x";
                from: 0
                to: (Data.boardObject.state === "blueBattleAnimation") ? sword.endX : -500;
                duration: 200
            }
            NumberAnimation
            {
                target: sword;
                properties: "y";
                from: 0
                to: (Data.boardObject.state === "blueBattleAnimation") ? sword.endY : 509;
                duration: 200
            }
        }
        ScriptAction {
            script: {
                sword.visible = false;
                sword.rotation = 0;
                sword.x = card_item.x;
                sword.y = card_item.y;

                if(Data.boardObject.state === "blueBattleAnimation")
                {
                    card_item.attackEveryTurn = false;
                    var isdnFrom = Data.blueFrontCards[Data.battleFromIndex].isdn;
                    Data.battleFromIndex = -1;
                    Data.battleToIndex = -1;
                    Data.boardObject.redLP -= Number(Data.boardCards[isdnFrom]["atk"]);
                    Data.boardObject.state = "blueBattlePhase";
                }
            }
        }
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
                    Data.boardDialog.index = 2
                    Data.boardDialog.visible = true
                } else if(Data.tributeNumber === 2) {
                    Data.tributeCard = card_item;
                    Data.boardDialog.index = 3
                    Data.boardDialog.visible = true
                } else if(Data.tributeNumber === 3) {
                    Data.tributeCard = card_item;
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
        id: specialButton
        y: summonButton.visible && setButton.visible ? -210 : summonButton.visible ? -140 : -70
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
        height: 60
        text: "特殊召唤"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: {
            card_item.highlight = false;
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
            card_item.highlight = false;
            card_item.state = "blueGrave";
            Data.tributeNumber = Data.tributeNumber - 1;
            if(Data.tributeNumber === 0) {
                Data.boardObject.state = Data.boardObject.lastState;
            }
        }
    }

    Button {
        id: specifyButton
        y: -70
        anchors.horizontalCenter: card_image.horizontalCenter
        width: 180
        height: 60
        text: "指定"
        font.pixelSize: 24
        font.bold: true
        visible: false
        onClicked: {
            card_item.highlight = false;
            Data.specifyNumber = Data.specifyNumber - 1;
            if(Data.specifyNumber === 0) {
                Data.boardObject.state = Data.boardObject.lastState;
                const [ret1, ret2, ret3] = Data.boardObject.coinThree();
                var atkNum = Number(label.atkLabel);
                var defNum = Number(label.defLabel);
                atkNum -= 700;
                defNum -= 700;
                if(ret1 === true) {
                    atkNum -= 700;
                    defNum -= 700;
                }
                if(ret2 === true) {
                    atkNum -= 700;
                    defNum -= 700;
                }
                if(ret3 === true) {
                    atkNum -= 700;
                    defNum -= 700;
                }
                if(atkNum <= 0 || defNum <= 0) {
                    card_item.state = "redGrave";
                } else {
                    labelTimer.atkNew = atkNum;
                    labelTimer.defNew = defNum;
                    labelTimer.start();
                }
            }
        }
    }

    Timer {
        id: labelTimer
        property int remain: 0
        property int atkNew: 0
        property int defNew: 0
        interval: 40
        running: false
        repeat: true
        onTriggered: {
            remain++;
            if(remain > 100) {
                var atkOld = Number(label.atkLabel);
                var defOld = Number(label.defLabel);
                if(atkNew < atkOld) {
                    atkOld -= 100;
                } else if (atkNew > atkOld) {
                    atkOld += 100;
                }
                if(defNew < defOld) {
                    defOld -= 100;
                } else if(defNew > defOld) {
                    defOld += 100;
                }
                if(atkNew === atkOld && defNew === defOld) {
                    remain = 0;
                    labelTimer.stop();
                } else {
                    label.atkLabel = atkOld.toString();
                    label.defLabel = defOld.toString();
                }
            }
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

    function effectLabel(atk, def) {
        var atkNum = Number(Data.boardCards[isdn]["atk"]) + atk;
        var defNum = Number(Data.boardCards[isdn]["def"]) + def;
        if(atkNum < 0) atkNum = 0;
        if(defNum < 0) defNum = 0;
        label.text = atkNum.toString() + "/" + defNum.toString();
    }

    SequentialAnimation {
        id: effectLabelAnimation
        running: false
        ScriptAction {
            script: {
                Data.redFrontCards[0].effectLabel(-500, -500);
                Data.redFrontCards[1].effectLabel(-500, -500);
                Data.blueFrontCards[0].effectLabel(0, 1500);
            }
        }
        //to do...
    }

    SequentialAnimation {
        id: effect3Animation
        running: false
        ScriptAction { script: { effectActiveAnimation.start() } }
        PauseAnimation { duration: 1000 }
        //先翻转再攻击我
        ScriptAction { script: { Data.blueFrontCards[0].state = "blueHorizontalFaceupFront"; } }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { Data.redFrontCards[0].state = "redVerticalFaceupFront"; } }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { effectLabelAnimation.start() } }
        ScriptAction {
            script: {
                Data.redFrontCards[0].swordAnimationStart();
            }
        }
        PauseAnimation { duration: 2000 }
        ScriptAction { script: {
                var atkNum = Number(Data.boardCards[Data.redFrontCards[0].isdn]["atk"]) - 500;
                var defNum = Number(Data.boardCards[Data.blueFrontCards[0].isdn]["def"]) + 1500;
                Data.boardObject.redLP -= (defNum - atkNum);
            }
        }
        PauseAnimation { duration: 2000 }
        ScriptAction {
            script: {
                Data.redFrontCards[1].swordAnimationStart();
            }
        }
        PauseAnimation { duration: 2000 }
        ScriptAction { script: {
                var atkNum = Number(Data.boardCards[Data.redFrontCards[1].isdn]["atk"]) - 500;
                var defNum = Number(Data.boardCards[Data.blueFrontCards[0].isdn]["def"]) + 1500;
                Data.boardObject.redLP -= (defNum - atkNum);
            }
        }
        PauseAnimation { duration: 2000 }
        ScriptAction {
            script: {
                Data.boardObject.state = "redEndPhase"
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
            if(isdn === 6) {
                if(Data.boardObject.state === "blueChainPhase") {
                    effect3Animation.start();
                } else if(Data.boardObject.state === "blueMain1Phase" || Data.boardObject.state === "blueMain2Phase") {
                    //请丢弃一张手牌
                }
            } else if(isdn === 7) {
                Data.boardDialog.index = 5
                Data.boardDialog.visible = true
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
                Data.boardObject.state = "blueBattleAnimation";
                swordAnimation.start();
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
            from: "blueVerticalFaceupFront"
            to: "blueHorizontalFaceupFront"
            SequentialAnimation {
                ScriptAction { script: { card_openMusic.play(); } }
                ParallelAnimation {
                    NumberAnimation { target: rotationStand; to: 90; property: "angle"; duration: 270 }
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
                NumberAnimation { target: rotationFace; to: 0; property: "angle"; duration: 270 }
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
                    NumberAnimation { target: rotationFace; to: 0; property: "angle"; duration: 270 }
                    NumberAnimation { target: rotationStand; to: 180; property: "angle"; duration: 270 }
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
                    PauseAnimation { duration: 1600 }
                    ScriptAction {
                        script: {
                            label.visible = false
                            effect2.visible = false
                            delete Data.blueFrontCards[card_item.index];
                            if(Data.tributeNumber === 0) {
                                var place2 = Data.findBlueFrontIndex();
                                var old_place2 = Data.tributeCard.index;
                                Data.blueHandCards.splice(old_place2, 1);
                                Data.blueFrontCards[place2] = Data.tributeCard;
                                Data.tributeCard.index = place2;
                                Data.tributeCard.z = 5+Data.blueGraveCards.length;
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
                PauseAnimation {
                    duration: 4200
                }
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
