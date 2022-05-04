import QtQuick 2.3
import "data.js" as Data
//import QtWebSockets 1.0
import QtQuick.Controls 2.14
import QtMultimedia 5.14

Image {
    Audio {
        id: backmusicMusic
        loops: Audio.Infinite
        source: "voice/backmusic.mp3"
    }

    Audio {
        id: battle_turnMusic
        source: "voice/battle_turn.wav"
    }

    Audio {
        id: turn_changeMusic
        source: "voice/turn_change.wav"
    }

    Audio {
        id: damageMusic
        source: "voice/damage.wav"
    }

    id: board
    anchors.left: parent.left
    anchors.top: parent.top
    width: 1440
    height: 1080
    source: "image/bg.png"
    state: "startGame"

    property int prevBlueLP: 8000
    property int blueLP: 8000
    onBlueLPChanged: {
        damageMusic.play();
        blueDamageTimer.damageMinus = blueLP < prevBlueLP;
        blueDamageTimer.damageValue = (blueLP > prevBlueLP) ? (blueLP - prevBlueLP) : (prevBlueLP - blueLP);
        blueDamageTimer.lpValue = prevBlueLP;
        blueDamageTimer.start();
        prevBlueLP = blueLP;
    }

    property int prevRedLP: 8000
    property int redLP: 8000
    onRedLPChanged: {
        damageMusic.play();
        redDamageTimer.damageMinus = redLP < prevRedLP;
        redDamageTimer.damageValue = (redLP > prevRedLP) ? (redLP - prevRedLP) : (prevRedLP - redLP);
        redDamageTimer.lpValue = prevRedLP;
        redDamageTimer.start();
        prevRedLP = redLP;
    }

    Component.onCompleted: {
        Data.componentObject = Component;
        Data.boardObject = board;
        Data.boardDialog = dialogImage;
//        Data.boardSocket = socket;
        Data.infoImageObject = infoImage;
        Data.infoTextObject = infoText;
    }

//    WebSocket {
//        id: socket
//        url: "ws://127.0.0.1:7720"
//        active: true
//        onTextMessageReceived: {
//            console.log(message)
//            Data.handleMessage(message.split("#")[0], message.split("#")[1]);
//        }
//    }

    MouseArea {
        anchors.fill: board
        onClicked: {
            if(Data.oldSelectCard !== undefined) {
                Data.oldSelectCard.highlight = false;
            }
        }
    }

    Image {
        id: lp_red_wan
        x: 102
        y: 0
        width: 47
        height: 61
        source: "image/LP/LPNA.png"
    }

    Image {
        id: lp_red_qian
        x: 149
        y: 0
        width: 47
        height: 61
        source: "image/LP/LP8.png"
    }

    Image {
        id: lp_red_bai
        x: 196
        y: 0
        width: 47
        height: 61
        source: "image/LP/LP0.png"
    }

    Image {
        id: lp_red_shi
        x: 243
        y: 0
        width: 47
        height: 61
        source: "image/LP/LP0.png"
    }

    Image {
        id: lp_red_ge
        x: 290
        y: 0
        width: 47
        height: 61
        source: "image/LP/LP0.png"
    }

    Image {
        id: lp_blue_wan
        x: 102
        y: 950
        width: 47
        height: 61
        source: "image/LP/LPNA.png"
    }

    Image {
        id: lp_blue_qian
        x: 149
        y: 950
        width: 47
        height: 61
        source: "image/LP/LP8.png"
    }

    Image {
        id: lp_blue_bai
        x: 196
        y: 950
        width: 47
        height: 61
        source: "image/LP/LP0.png"
    }

    Image {
        id: lp_blue_shi
        x: 243
        y: 950
        width: 47
        height: 61
        source: "image/LP/LP0.png"
    }

    Image {
        id: lp_blue_ge
        x: 290
        y: 950
        width: 47
        height: 61
        source: "image/LP/LP0.png"
    }

    Image {
        id: damage_red_minus
        x: 800
        y: 200
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_red_wan
        x: 829
        y: 200
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_red_qian
        x: 858
        y: 200
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_red_bai
        x: 887
        y: 200
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_red_shi
        x: 916
        y: 200
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_red_ge
        x: 945
        y: 200
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_blue_minus
        x: 794
        y: 800
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_blue_wan
        x: 829
        y: 800
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_blue_qian
        x: 858
        y: 800
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_blue_bai
        x: 887
        y: 800
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_blue_shi
        x: 916
        y: 800
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: damage_blue_ge
        x: 945
        y: 800
        width: 29
        height: 72
        source: "image/LP/damageNA.png"
    }

    Image {
        id: dialogImage
        x: 560
        y: 360
        z: 99
        width: 742
        height: 324
        source: "image/dialog/dialog3.png"
        visible: false
        property int index: 3

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(dialogImage.index === 1) {
                    dialogImage.visible = false
                    Data.blueChainCard = true
                } else if(dialogImage.index === 3) {
                    dialogImage.visible = false
                    Data.blueTributeSummon = true
                }
            }
        }
    }

    Rectangle {
        id: rect_DP
        x: 398
        y: 148
        width: 72
        height: 135
        clip: true
        Image {
            id: image_DP
            x: 0
            y: 0
            width: 144
            height: 270
            source: "image/phase/pha_s_dr.bmp"
        }
    }

    Rectangle {
        id: rect_SP
        x: 398
        y: 282
        width: 72
        height: 135
        clip: true
        Image {
            id: image_SP
            x: 0
            y: 0
            width: 144
            height: 270
            source: "image/phase/pha_s_st.bmp"
        }
    }

    Rectangle {
        id: rect_M1
        x: 398
        y: 417
        width: 72
        height: 135
        clip: true
        Image {
            id: image_M1
            x: 0
            y: 0
            width: 144
            height: 270
            source: "image/phase/pha_s_m1.bmp"
        }
    }

    Rectangle {
        id: rect_BP
        x: 398
        y: 553
        width: 72
        height: 135
        clip: true
        Image {
            id: image_BP
            x: 0
            y: 0
            width: 144
            height: 270
            source: "image/phase/pha_s_ba.bmp"

            MouseArea {
                id: mouse_BP
                anchors.fill: parent
                onClicked: {
                    if(board.state === "blueMain1Phase") {
                        board.state = "blueBattlePhase";
                    }
                }
            }
        }
    }

    Rectangle {
        id: rect_M2
        x: 398
        y: 687
        width: 72
        height: 135
        clip: true
        Image {
            id: image_M2
            x: 0
            y: 0
            width: 144
            height: 270
            source: "image/phase/pha_s_m2.bmp"

            MouseArea {
                id: mouse_M2
                anchors.fill: parent
                onClicked: {
                    if(board.state === "blueBattlePhase") {
                        board.state = "blueMain2Phase";
                    }
                }
            }
        }
    }

    Rectangle {
        id: rect_EP
        x: 398
        y: 823
        width: 72
        height: 135
        clip: true
        Image {
            id: image_EP
            x: 0
            y: 0
            width: 144
            height: 270
            source: "image/phase/pha_s_en.bmp"

            MouseArea {
                id: mouse_EP
                anchors.fill: parent
                onClicked: {
                    if(board.state === "blueMain1Phase" ||
                            board.state === "blueBattlePhase" ||
                            board.state === "blueMain2Phase") {
                        board.state = "blueEndPhase";
                    }
                }
            }
        }
    }

    Image {
        id: battlePhaseImage
        x: 649
        y: 498
        width: 475
        height: 79
        source: "image/phase_name/e_ba_b1.png"
        visible: false
    }

    Image {
        id: otherPhaseImage
        x: 770
        y: 498
        width: 430
        height: 79
        source: "image/phase_name/e_dr_b.png"
        visible: false
    }

    Image {
        id: infoImage
        x: 4
        y: 135
        width: 360
        height: 522
        source: "image/info/null.png"
        fillMode: Image.PreserveAspectFit
    }

    ScrollView {
        id: infoScroll
        x: 14
        y: 666
        width: 332
        height: 265
        TextArea {
            id: infoText
            width: 322
            height: 265
            readOnly: true
            font.family: "Helvetica"
            font.pointSize: 10
            wrapMode: TextEdit.Wrap
        }
    }

//    AnimatedSprite {
//        id: coinAnimation
//        running: false
//        source: "loading.png"
//        frameWidth: 72
//        frameHeight: 72
//        frameCount: 14
//        frameDuration: 500
//    }

    Timer {
        id: redDamageTimer
        property bool damageMinus: false
        property int damageValue: 0
        property int damageQian: damageValue/1000
        property int damageBai: (damageValue-damageQian*1000)/100
        property int damageShi: (damageValue-damageQian*1000-damageBai*100)/10
        property int damageGe: damageValue%10
        property string damagePath: "image/LP/damage%1.png"
        property int lpValue: 8000
        property int lpQian: lpValue/1000
        property int lpBai: (lpValue-lpQian*1000)/100
        property int lpShi: (lpValue-lpQian*1000-lpBai*100)/10
        property int lpGe: lpValue%10
        property string lpPath: "image/LP/LP%1.png"
        interval: 200
        running: false
        repeat: true
        onTriggered: {
            if(damageValue > 0)
            {
                if(damageMinus)
                {
                    damage_red_minus.source = damagePath.arg("A");
                }
                else
                {
                    damage_red_minus.source = damagePath.arg("B");
                }

                damage_red_qian.source = damagePath.arg((damageQian===0) ? "NA" : damageQian.toString());
                damage_red_bai.source = damagePath.arg((damageQian===0 && damageBai===0) ? "NA" : damageBai.toString());
                damage_red_shi.source = damagePath.arg((damageQian===0 && damageBai===0 && damageShi===0) ? "NA" : damageShi.toString());
                damage_red_ge.source = damagePath.arg((damageQian===0 && damageBai===0 && damageShi===0 && damageGe===0) ? "NA" : damageGe.toString());

                damageValue = damageValue - 400;

                if(damageValue > 0)
                {
                    lpValue = lpValue - 400;
                }
                else
                {
                    lpValue = lpValue - 400 - damageValue;
                }

                lp_red_qian.source = lpPath.arg((lpQian===0) ? "NA" : lpQian.toString());
                lp_red_bai.source = lpPath.arg((lpQian===0 && lpBai===0) ? "NA" : lpBai.toString());
                lp_red_shi.source = lpPath.arg((lpQian===0 && lpBai===0 && lpShi===0) ? "NA" : lpShi.toString());
                lp_red_ge.source = lpPath.arg((lpQian===0 && lpBai===0 && lpShi===0 && lpGe===0) ? "NA" : lpGe.toString());
            }
            else
            {
                redDamageTimer.stop();
                damage_red_minus.source = damagePath.arg("NA");
                damage_red_qian.source = damagePath.arg("NA");
                damage_red_bai.source = damagePath.arg("NA");
                damage_red_shi.source = damagePath.arg("NA");
                damage_red_ge.source = damagePath.arg("NA");
            }
        }
    }

    Timer {
        id: blueDamageTimer
        property bool damageMinus: false
        property int damageValue: 0
        property int damageQian: damageValue/1000
        property int damageBai: (damageValue-damageQian*1000)/100
        property int damageShi: (damageValue-damageQian*1000-damageBai*100)/10
        property int damageGe: damageValue%10
        property string damagePath: "image/LP/damage%1.png"
        property int lpValue: 8000
        property int lpQian: lpValue/1000
        property int lpBai: (lpValue-lpQian*1000)/100
        property int lpShi: (lpValue-lpQian*1000-lpBai*100)/10
        property int lpGe: lpValue%10
        property string lpPath: "image/LP/LP%1.png"
        interval: 200
        running: false
        repeat: true
        onTriggered: {
            if(damageValue > 0)
            {
                if(damageMinus)
                {
                    damage_blue_minus.source = damagePath.arg("A");
                }
                else
                {
                    damage_blue_minus.source = damagePath.arg("B");
                }

                damage_blue_qian.source = damagePath.arg((damageQian===0) ? "NA" : damageQian.toString());
                damage_blue_bai.source = damagePath.arg((damageQian===0 && damageBai===0) ? "NA" : damageBai.toString());
                damage_blue_shi.source = damagePath.arg((damageQian===0 && damageBai===0 && damageShi===0) ? "NA" : damageShi.toString());
                damage_blue_ge.source = damagePath.arg((damageQian===0 && damageBai===0 && damageShi===0 && damageGe===0) ? "NA" : damageGe.toString());

                damageValue = damageValue - 400;

                if(damageValue > 0)
                {
                    lpValue = lpValue - 400;
                }
                else
                {
                    lpValue = lpValue - 400 - damageValue;
                }

                lp_blue_qian.source = lpPath.arg((lpQian===0) ? "NA" : lpQian.toString());
                lp_blue_bai.source = lpPath.arg((lpQian===0 && lpBai===0) ? "NA" : lpBai.toString());
                lp_blue_shi.source = lpPath.arg((lpQian===0 && lpBai===0 && lpShi===0) ? "NA" : lpShi.toString());
                lp_blue_ge.source = lpPath.arg((lpQian===0 && lpBai===0 && lpShi===0 && lpGe===0) ? "NA" : lpGe.toString());
            }
            else
            {
                blueDamageTimer.stop();
                damage_blue_minus.source = damagePath.arg("NA");
                damage_blue_qian.source = damagePath.arg("NA");
                damage_blue_bai.source = damagePath.arg("NA");
                damage_blue_shi.source = damagePath.arg("NA");
                damage_blue_ge.source = damagePath.arg("NA");
            }
        }
    }

    states: [
        State {
            name: "startGame"
        },
        State {
            name: "blueDrawPhase"
        },
        State {
            name: "blueStandbyPhase"
        },
        State {
            name: "blueMain1Phase"
        },
        State {
            name: "blueBattlePhase"
        },
        State {
            name: "blueBattleAnimation"
        },
        State {
            name: "blueMain2Phase"
        },
        State {
            name: "blueEndPhase"
        },
        State {
            name: "redDrawPhase"
        },
        State {
            name: "redStandbyPhase"
        },
        State {
            name: "redMain1Phase"
        },
        State {
            name: "redBattlePhase"
        },
        State {
            name: "redMain2Phase"
        },
        State {
            name: "redEndPhase"
        }
    ]

    function showBlueSword() {
        for(var index = 0; index<5; index++) {
            if(Data.blueFrontCards[index] !== undefined) {
                if(Data.blueFrontCards[index].state === "blueVerticalFaceupFront") {
                    Data.blueFrontCards[index].swordVisible = true;
                    Data.blueFrontCards[index].attackEveryTurn = true;
                }
            }
        }
    }

    function showRedSword() {
        for(var index = 0; index<5; index++) {
            if(Data.redFrontCards[index] !== undefined) {
                if(Data.redFrontCards[index].state === "redVerticalFaceupFront") {
                    Data.redFrontCards[index].swordRotation = 180;
                    Data.redFrontCards[index].swordVisible = true;
                }
            }
        }
    }

    function hideSword() {
        for(var index = 0; index<5; index++) {
            if(Data.blueFrontCards[index] !== undefined) {
                if(Data.blueFrontCards[index].state === "blueVerticalFaceupFront") {
                    Data.blueFrontCards[index].swordVisible = false;
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_blue_DP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_DP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_DP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_dr_b.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction { script: { Data.blue_draw_card(); } }
            PauseAnimation { duration: 300 }
            ScriptAction {
                script: {
                    Data.blueSummonEnable = true;
                    state = "blueStandbyPhase";
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_blue_SP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_SP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_SP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_st_b.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction {
                script: {
                    state = "blueMain1Phase";
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_blue_M1
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_M1.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_M1.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_m1_b.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction {
                script: {
                    /**/
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_blue_BP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_BP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_BP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b1.png"; battlePhaseImage.visible = true; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b2.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b3.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b4.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b5.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b6.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b7.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_b8.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.visible = false; } }
        }
        SequentialAnimation {
            ScriptAction {
                script: {
                    showBlueSword();
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_blue_M2
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_M2.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_M2.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_m2_b.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            ScriptAction {
                script: {
                    hideSword();
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_blue_EP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_EP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_EP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_en_b.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            ScriptAction {
                script: {
                    hideSword();
                }
            }
            PauseAnimation { duration: 800 }
            ScriptAction {
                script: {
                    state = "redDrawPhase";
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_red_DP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_DP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_DP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_dr_r.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction { script: { Data.red_draw_card(); } }
            PauseAnimation { duration: 300 }
            ScriptAction {
                script: {
                    state = "redStandbyPhase";
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_red_SP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_SP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_SP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_st_r.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction {
                script: {
                    state = "redMain1Phase";
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_red_M1
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_M1.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_M1.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_m1_r.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction {
                script: {
                    Data.redHorizontalFacedownFront(0);
                }
            }
            PauseAnimation { duration: 2000 }
            ScriptAction {
                script: {
                    Data.redVerticalFaceupFront(0);
                }
            }
            PauseAnimation { duration: 2000 }
            ScriptAction {
                script: {
                     state = "redBattlePhase"
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_red_BP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_BP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_BP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r1.png"; battlePhaseImage.visible = true; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r2.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r3.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r4.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r5.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r6.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r7.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "image/phase_name/e_ba_r8.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 1500 }
            ScriptAction {
                script: {
                    showRedSword();
                    battle_turnMusic.play();
                }
            }
            PauseAnimation { duration: 1000 }
            ScriptAction {
                script: {
                    if(Data.findBlueFrontMatchActiveCondition()) {
                        Data.boardDialog.source = "image/dialog/dialog1.png"
                        Data.boardDialog.index = 1
                        Data.boardDialog.visible = true
                    }
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_red_M2
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_M2.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_M2.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_m2_r.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction {
                script: {
                    /**/
                }
            }
        }
    }

    ParallelAnimation {
        id: ani_red_EP
        running: false
        SequentialAnimation {
            loops: Animation.Infinite
            ScriptAction { script: { image_EP.x = 0; } }
            PauseAnimation { duration: 200 }
            ScriptAction { script: { image_EP.x = -72 } }
            PauseAnimation { duration: 600 }
        }
        SequentialAnimation {
            ScriptAction { script: { otherPhaseImage.source = "image/phase_name/e_en_r.png"; otherPhaseImage.visible = true; } }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 0; to: 1; duration: 200 }
            PauseAnimation { duration: 400 }
            NumberAnimation { target: otherPhaseImage; property: "opacity"; from: 1; to: 0; duration: 200 }
            ScriptAction { script: { otherPhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 800 }
            ScriptAction {
                script: {
                    state = "blueDrawPhase";
                }
            }
        }
    }

    transitions: [
        Transition {
            from: "startGame"
            to: "blueDrawPhase"
            SequentialAnimation {
                ScriptAction { script: { backmusicMusic.play(); Data.blue_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.blue_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.blue_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.blue_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.blue_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.red_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.red_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.red_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.red_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { Data.red_draw_card(); } }
                PauseAnimation { duration: 300 }
                ScriptAction { script: { ani_blue_DP.start(); } }
            }
        },
        Transition {
            from: "blueDrawPhase"
            to: "blueStandbyPhase"
            ScriptAction {
                script: {
                    image_DP.x = 0;
                    ani_blue_DP.stop();
                    ani_blue_SP.start();
                }
            }
        },
        Transition {
            from: "blueStandbyPhase"
            to: "blueMain1Phase"
            ScriptAction {
                script: {
                    image_SP.x = 0;
                    ani_blue_SP.stop();
                    ani_blue_M1.start();
                }
            }
        },
        Transition {
            from: "blueMain1Phase"
            to: "blueBattlePhase"
            ScriptAction {
                script: {
                    image_M1.x = 0;
                    ani_blue_M1.stop();
                    ani_blue_BP.start();
                    battle_turnMusic.play();
                }
            }
        },
        Transition {
            from: "blueMain1Phase"
            to: "blueEndPhase"
            ScriptAction {
                script: {
                    image_M1.x = 0;
                    ani_blue_M1.stop();
                    ani_blue_EP.start();
                }
            }
        },
        Transition {
            from: "blueBattlePhase"
            to: "blueMain2Phase"
            ScriptAction {
                script: {
                    image_BP.x = 0;
                    ani_blue_BP.stop();
                    ani_blue_M2.start();
                }
            }
        },
        Transition {
            from: "blueBattlePhase"
            to: "blueEndPhase"
            ScriptAction {
                script: {
                    image_BP.x = 0;
                    ani_blue_BP.stop();
                    ani_blue_EP.start();
                }
            }
        },
        Transition {
            from: "blueMain2Phase"
            to: "blueEndPhase"
            ScriptAction {
                script: {
                    image_M2.x = 0;
                    ani_blue_M2.stop();
                    ani_blue_EP.start();
                }
            }
        },
        Transition {
            from: "blueEndPhase"
            to: "redDrawPhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_EP.x = 0;
                        ani_blue_EP.stop();
                        image_DP.source = "image/phase/pha_b_dr.bmp"
                        image_DP.width = 648
                        image_DP.height = 135
                        image_SP.source = "image/phase/pha_b_st.bmp"
                        image_SP.width = 648
                        image_SP.height = 135
                        image_M1.source = "image/phase/pha_b_m1.bmp"
                        image_M1.width = 648
                        image_M1.height = 135
                        image_BP.source = "image/phase/pha_b_ba.bmp"
                        image_BP.width = 648
                        image_BP.height = 135
                        image_M2.source = "image/phase/pha_b_m2.bmp"
                        image_M2.width = 648
                        image_M2.height = 135
                        image_EP.source = "image/phase/pha_b_en.bmp"
                        image_EP.width = 648
                        image_EP.height = 135
                        turn_changeMusic.play();
                    }
                }
                ScriptAction { script: { image_DP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_DP.source = "image/phase/pha_s_dr.bmp"
                        image_DP.width = 144
                        image_DP.height = 270
                        image_DP.x = 0
                        image_DP.y = -135
                    }
                }
                ScriptAction { script: { image_SP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_SP.source = "image/phase/pha_s_st.bmp"
                        image_SP.width = 144
                        image_SP.height = 270
                        image_SP.x = 0
                        image_SP.y = -135
                    }
                }
                ScriptAction { script: { image_M1.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_M1.source = "image/phase/pha_s_m1.bmp"
                        image_M1.width = 144
                        image_M1.height = 270
                        image_M1.x = 0
                        image_M1.y = -135
                    }
                }
                ScriptAction { script: { image_BP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_BP.source = "image/phase/pha_s_ba.bmp"
                        image_BP.width = 144
                        image_BP.height = 270
                        image_BP.x = 0
                        image_BP.y = -135
                    }
                }
                ScriptAction { script: { image_M2.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_M2.source = "image/phase/pha_s_m2.bmp"
                        image_M2.width = 144
                        image_M2.height = 270
                        image_M2.x = 0
                        image_M2.y = -135
                    }
                }
                ScriptAction { script: { image_EP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_EP.source = "image/phase/pha_s_en.bmp"
                        image_EP.width = 144
                        image_EP.height = 270
                        image_EP.x = 0
                        image_EP.y = -135
                        ani_red_DP.start()
                    }
                }
            }
        },
        Transition {
            from: "redDrawPhase"
            to: "redStandbyPhase"
            ScriptAction {
                script: {
                    image_DP.x = 0;
                    image_DP.y = -135;
                    ani_red_DP.stop();
                    ani_red_SP.start();
                }
            }
        },
        Transition {
            from: "redStandbyPhase"
            to: "redMain1Phase"
            ScriptAction {
                script: {
                    image_SP.x = 0;
                    image_SP.y = -135;
                    ani_red_SP.stop();
                    ani_red_M1.start();
                }
            }
        },
        Transition {
            from: "redMain1Phase"
            to: "redBattlePhase"
            ScriptAction {
                script: {
                    image_M1.x = 0;
                    image_M1.y = -135;
                    ani_red_M1.stop();
                    ani_red_BP.start();
                }
            }
        },
        Transition {
            from: "redMain1Phase"
            to: "redEndPhase"
            ScriptAction {
                script: {
                    image_M1.x = 0;
                    image_M1.y = -135;
                    ani_red_M1.stop();
                    ani_red_EP.start();
                }
            }
        },
        Transition {
            from: "redBattlePhase"
            to: "redMain2Phase"
            ScriptAction {
                script: {
                    image_BP.x = 0;
                    image_BP.y = -135;
                    ani_red_BP.stop();
                    ani_red_M2.start();
                }
            }
        },
        Transition {
            from: "redBattlePhase"
            to: "redEndPhase"
            ScriptAction {
                script: {
                    image_BP.x = 0;
                    image_BP.y = -135;
                    ani_red_BP.stop();
                    ani_red_EP.start();
                }
            }
        },
        Transition {
            from: "redMain2Phase"
            to: "redEndPhase"
            ScriptAction {
                script: {
                    image_M2.x = 0;
                    image_M2.y = -135;
                    ani_red_M2.stop();
                    ani_red_EP.start();
                }
            }
        },
        Transition {
            from: "redEndPhase"
            to: "blueDrawPhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_DP.x = 0;
                        ani_red_EP.stop();
                        image_DP.source = "image/phase/pha_r_dr.bmp"
                        image_DP.width = 648
                        image_DP.height = 135
                        image_DP.y = 0
                        image_SP.source = "image/phase/pha_r_st.bmp"
                        image_SP.width = 648
                        image_SP.height = 135
                        image_SP.y = 0
                        image_M1.source = "image/phase/pha_r_m1.bmp"
                        image_M1.width = 648
                        image_M1.height = 135
                        image_M1.y = 0
                        image_BP.source = "image/phase/pha_r_ba.bmp"
                        image_BP.width = 648
                        image_BP.height = 135
                        image_BP.y = 0
                        image_M2.source = "image/phase/pha_r_m2.bmp"
                        image_M2.width = 648
                        image_M2.height = 135
                        image_M2.y = 0
                        image_EP.source = "image/phase/pha_r_en.bmp"
                        image_EP.width = 648
                        image_EP.height = 135
                        image_EP.y = 0
                        turn_changeMusic.play();
                    }
                }
                ScriptAction { script: { image_DP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_DP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_DP.source = "image/phase/pha_s_dr.bmp"
                        image_DP.width = 144
                        image_DP.height = 270
                        image_DP.x = 0
                        image_DP.y = 0
                    }
                }
                ScriptAction { script: { image_SP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_SP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_SP.source = "image/phase/pha_s_st.bmp"
                        image_SP.width = 144
                        image_SP.height = 270
                        image_SP.x = 0
                        image_SP.y = 0
                    }
                }
                ScriptAction { script: { image_M1.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M1.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_M1.source = "image/phase/pha_s_m1.bmp"
                        image_M1.width = 144
                        image_M1.height = 270
                        image_M1.x = 0
                        image_M1.y = 0
                    }
                }
                ScriptAction { script: { image_BP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_BP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_BP.source = "image/phase/pha_s_ba.bmp"
                        image_BP.width = 144
                        image_BP.height = 270
                        image_BP.x = 0
                        image_BP.y = 0
                    }
                }
                ScriptAction { script: { image_M2.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_M2.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_M2.source = "image/phase/pha_s_m2.bmp"
                        image_M2.width = 144
                        image_M2.height = 270
                        image_M2.x = 0
                        image_M2.y = 0
                    }
                }
                ScriptAction { script: { image_EP.x = -72 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -144 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -216 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -288 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -360 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -432 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -504 } }
                PauseAnimation { duration: 20 }
                ScriptAction { script: { image_EP.x = -576 } }
                PauseAnimation { duration: 20 }
                ScriptAction {
                    script: {
                        image_EP.source = "image/phase/pha_s_en.bmp"
                        image_EP.width = 144
                        image_EP.height = 270
                        image_EP.x = 0
                        image_EP.y = 0
                        ani_blue_DP.start();
                    }
                }
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
