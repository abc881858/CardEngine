import QtQuick 2.3
import "data.js" as Data
//import QtWebSockets 1.0
import QtQuick.Controls 2.14
import QtMultimedia 5.14

Image {
    id: board
    anchors.left: parent.left
    anchors.top: parent.top
    width: 1440
    height: 1080
    source: "qrc:/image/bg.png"
    state: "startGame"

    Component.onCompleted: {
        Data.componentObject = Component;
        Data.boardObject = board;
        Data.boardDialog = dialogImage;
//        Data.boardSocket = socket;
        Data.infoImageObject = infoImage;
        Data.infoTextObject = infoText;
        Data.blueSword = blueSword;
        Data.redSword = redSword;
        Data.blueSwordAnimationObject = blueSwordAnimation;
        Data.redSwordAnimationObject = redSwordAnimation;
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

    Audio {
        id: backmusicMusic
        loops: Audio.Infinite
        source: "qrc:/voice/backmusic.mp3"
    }

    Audio {
        id: battle_turnMusic
        source: "qrc:/voice/battle_turn.wav"
    }

    Audio {
        id: turn_changeMusic
        source: "qrc:/voice/turn_change.wav"
    }

    Audio {
        id: attackMusic
        source: "qrc:/voice/attack.wav"
    }

    Audio {
        id: damageMusic
        source: "qrc:/voice/damage.wav"
    }

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
        source: "qrc:/image/LP/NA.png"
    }

    Image {
        id: lp_red_qian
        x: 149
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP8.png"
    }

    Image {
        id: lp_red_bai
        x: 196
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_red_shi
        x: 243
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_red_ge
        x: 290
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_blue_wan
        x: 102
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/NA.png"
    }

    Image {
        id: lp_blue_qian
        x: 149
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP8.png"
    }

    Image {
        id: lp_blue_bai
        x: 196
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_blue_shi
        x: 243
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_blue_ge
        x: 290
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: damage_red_minus
        x: 800
        y: 200
        width: 29
        height: 72
        source: "qrc:/image/LP/damageA.png"
        visible: false
    }

    Image {
        id: damage_red_wan
        x: 829
        y: 200
        width: 29
        height: 72
        source: "qrc:/image/LP/damageNA.png"
        visible: false
    }

    Image {
        id: damage_red_qian
        x: 858
        y: 200
        width: 29
        height: 72
        source: "qrc:/image/LP/damage1.png"
        visible: false
    }

    Image {
        id: damage_red_bai
        x: 887
        y: 200
        width: 29
        height: 72
        source: "qrc:/image/LP/damage9.png"
        visible: false
    }

    Image {
        id: damage_red_shi
        x: 916
        y: 200
        width: 29
        height: 72
        source: "qrc:/image/LP/damage0.png"
        visible: false
    }

    Image {
        id: damage_red_ge
        x: 945
        y: 200
        width: 29
        height: 72
        source: "qrc:/image/LP/damage0.png"
        visible: false
    }

    Image {
        id: dialogImage
        x: 560
        y: 360
        z: 99
        width: 742
        height: 324
        source: "qrc:/image/dialog/dialog3.png"
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
            source: "qrc:/image/phase/pha_s_dr.bmp"
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
            source: "qrc:/image/phase/pha_s_st.bmp"
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
            source: "qrc:/image/phase/pha_s_m1.bmp"
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
            source: "qrc:/image/phase/pha_s_ba.bmp"

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
            source: "qrc:/image/phase/pha_s_m2.bmp"

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
            source: "qrc:/image/phase/pha_s_en.bmp"

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
        source: "qrc:/image/phase_name/e_ba_b1.png"
        visible: false
    }

    Image {
        id: otherPhaseImage
        x: 770
        y: 498
        width: 430
        height: 79
        source: "qrc:/image/phase_name/e_dr_b.png"
        visible: false
    }

    Image {
        id: infoImage
        x: 4
        y: 135
        width: 360
        height: 522
        source: "qrc:/image/info/null.png"
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

    AnimatedSprite {
        id: coinAnimation
        running: false
        source: "loading.png"
        frameWidth: 72
        frameHeight: 72
        frameCount: 14
        frameDuration: 500
    }

    Image {
        id: blueSword
        x: 630
        y: 571
        z: 9
        width: 90
        height: 130
        source: "qrc:/image/sword.png"
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    Image {
        id: redSword
        x: 1192
        y: 383
        z: 9
        width: 90
        height: 130
        source: "qrc:/image/sword.png"
        fillMode: Image.PreserveAspectFit
        visible: false
        rotation: 180
    }

    SequentialAnimation {
        id: redSwordAnimation
        PauseAnimation { duration: 300 }
        ScriptAction { script: { redSword.visible = true } }
        PauseAnimation { duration: 200 }
        NumberAnimation { target: redSword; properties: "rotation"; from: 180; to: 252; duration: 200 }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { attackMusic.play() } }
        ParallelAnimation {
            NumberAnimation { target: redSword; properties: "x"; from: 1192; to: 630; duration: 200 }
            NumberAnimation { target: redSword; properties: "y"; from: 383; to: 571; duration: 200 }
        }
        ScriptAction {
            script: {
                redSword.visible = false;
                redSword.rotation = 180;
                redSword.x = 1192;
                redSword.y = 383;
            }
        }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { Data.blueFrontCards[0].effectActive(); } }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { Data.redFrontCards[0].effectLabel(); } }
        PauseAnimation { duration: 1000 }
        ScriptAction {
            script: {
                Data.redLP -= 1100;
                damageMusic.play();
                damage_red_minus.visible = true;
                damage_red_qian.source = "qrc:/image/LP/damage1.png";
                damage_red_bai.source = "qrc:/image/LP/damage1.png";
                damage_red_qian.visible = true;
                damage_red_bai.visible = true;
                damage_red_shi.visible = true;
                damage_red_ge.visible = true;
                lp_red_qian.source = "qrc:/image/LP/LP5.png"
                lp_red_bai.source = "qrc:/image/LP/LP0.png"
            }
        }
        PauseAnimation { duration: 1500 }
        ScriptAction {
            script: {
                damage_red_minus.visible = false;
                damage_red_qian.visible = false;
                damage_red_bai.visible = false;
                damage_red_shi.visible = false;
                damage_red_ge.visible = false;

                Data.redFrontCards[0].state = "redGrave";
                Data.redGraveCards.push(Data.redFrontCards[0]);
                delete Data.redFrontCards[0];
            }
        }

        PauseAnimation { duration: 500 }
        ScriptAction {
            script: {
                Data.redFrontCards[1].swordVisible = false;
                redSword.x = 1050;
                redSword.y = 383;
                redSword.visible = true;
            }
        }
        PauseAnimation { duration: 200 }
        NumberAnimation { target: redSword; properties: "rotation"; from: 180; to: 246; duration: 200 }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { attackMusic.play() } }
        ParallelAnimation {
            NumberAnimation { target: redSword; properties: "x"; from: 1050; to: 630; duration: 200 }
            NumberAnimation { target: redSword; properties: "y"; from: 383; to: 571; duration: 200 }
        }
        ScriptAction {
            script: {
                redSword.visible = false;
                redSword.rotation = 180;
                redSword.x = 1192;
                redSword.y = 383;
            }
        }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { Data.blueFrontCards[0].effectActive(); } }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { Data.redFrontCards[1].effectLabel(); } }
        PauseAnimation { duration: 1000 }
        ScriptAction {
            script: {
                Data.redLP -= 1900;
                damageMusic.play();
                damage_red_minus.visible = true;
                damage_red_qian.source = "qrc:/image/LP/damage1.png";
                damage_red_bai.source = "qrc:/image/LP/damage9.png";
                damage_red_qian.visible = true;
                damage_red_bai.visible = true;
                damage_red_shi.visible = true;
                damage_red_ge.visible = true;
                lp_red_qian.source = "qrc:/image/LP/LP3.png"
                lp_red_bai.source = "qrc:/image/LP/LP1.png"
            }
        }
        PauseAnimation { duration: 1500 }
        ScriptAction {
            script: {
                damage_red_minus.visible = false;
                damage_red_qian.visible = false;
                damage_red_bai.visible = false;
                damage_red_shi.visible = false;
                damage_red_ge.visible = false;

                Data.redFrontCards[1].state = "redGrave";
                Data.redGraveCards.push(Data.redFrontCards[1]);
                delete Data.redFrontCards[1];
            }
        }
        PauseAnimation { duration: 1500 }
        ScriptAction {
            script: {
                state = "redEndPhase"
            }
        }
    }

    SequentialAnimation {
        id: blueSwordAnimation
        NumberAnimation { target: blueSword; properties: "rotation"; from: 0; to: 26; duration: 200 }
        PauseAnimation { duration: 1000 }
        ScriptAction { script: { attackMusic.play() } }
        ParallelAnimation {
            NumberAnimation { target: blueSword; properties: "x"; from: 630; to: 865; duration: 200 }
            NumberAnimation { target: blueSword; properties: "y"; from: 571; to: 85; duration: 200 }
        }
        ScriptAction {
            script: {
                blueSword.visible = false;
                blueSword.rotation = 0;
                blueSword.x = 630;
                blueSword.y = 571;
            }
        }
        PauseAnimation { duration: 1000 }
//        ScriptAction {
//            script: {
//                if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFacedownFront") {
//                    Data.redFrontCards[Data.battleToIndex].state = "redHorizontalFaceupFront";
//                }
//            }
//        }
//        PauseAnimation {
//            duration: 1000
//        }
//        ScriptAction {
//            script: {
//                var isdnFrom = Data.blueFrontCards[Data.battleFromIndex].isdn;
//                var isdnTo = Data.redFrontCards[Data.battleToIndex].isdn;
//                if(Data.redFrontCards[Data.battleToIndex].state === "redVerticalFaceupFront") {
//                    if(Number(Data.boardCards[isdnFrom]["atk"]) >= Number(Data.boardCards[isdnTo]["atk"])) {
//                        Data.redFrontCards[Data.battleToIndex].state = "redGrave";
//                        Data.redGraveCards.push(Data.redFrontCards[Data.battleToIndex]);
//                        delete Data.redFrontCards[Data.battleToIndex];
//                        Data.redLP -= Data.boardCards[isdnFrom]["atk"] - Data.boardCards[isdnTo]["atk"];
//                        console.log("Data.redLP: " + Data.redLP);
//                    }
//                    if(Number(Data.boardCards[isdnFrom]["atk"]) <= Number(Data.boardCards[isdnTo]["atk"])) {
//                        Data.blueFrontCards[Data.battleFromIndex].state = "blueGrave";
//                        Data.blueGraveCards.push(Data.blueFrontCards[Data.battleFromIndex]);
//                        delete Data.blueFrontCards[Data.battleFromIndex];
//                        Data.blueLP -= Data.boardCards[isdnTo]["atk"] - Data.boardCards[isdnFrom]["atk"];
//                        console.log("Data.blueLP: " + Data.blueLP);
//                    }
//                } else if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFaceupFront") {
//                    if(Number(Data.boardCards[isdnFrom]["atk"]) > Number(Data.boardCards[isdnTo]["def"])) {
//                        Data.redFrontCards[Data.battleToIndex].state = "redGrave";
//                        Data.redGraveCards.push(Data.redFrontCards[Data.battleToIndex]);
//                        delete Data.redFrontCards[Data.battleToIndex];
//                    } else if(Number(Data.boardCards[isdnTo]["def"]) > Number(Data.boardCards[isdnFrom]["atk"])) {
//                        Data.blueLP -= Data.boardCards[isdnTo]["def"] - Data.boardCards[isdnFrom]["atk"];
//                        console.log("Data.blueLP: " + Data.blueLP);
//                    }
//                }
//            }
//        }
        ScriptAction {
            script: {
                var isdnFrom = Data.blueFrontCards[Data.battleFromIndex].isdn;
                Data.redLP -= Number(Data.boardCards[isdnFrom]["atk"]);
                Data.battleFromIndex = -1;
                Data.battleToIndex = -1;
                damageMusic.play();

                damage_red_minus.visible = true;
                damage_red_qian.visible = true;
                damage_red_bai.visible = true;
                damage_red_shi.visible = true;
                damage_red_ge.visible = true;
            }
        }
        PauseAnimation { duration: 200 }
        ScriptAction {
            script: {
                damage_red_bai.source = "qrc:/image/LP/damage5.png";
                lp_red_qian.source = "qrc:/image/LP/LP7.png"
                lp_red_bai.source = "qrc:/image/LP/LP6.png"
            }
        }
        PauseAnimation { duration: 200 }
        ScriptAction {
            script: {
                damage_red_bai.source = "qrc:/image/LP/damage1.png";
                lp_red_bai.source = "qrc:/image/LP/LP2.png"
            }
        }
        PauseAnimation { duration: 200 }
        ScriptAction {
            script: {
                damage_red_qian.source = "qrc:/image/LP/damageNA.png";
                damage_red_bai.source = "qrc:/image/LP/damage7.png";
                lp_red_qian.source = "qrc:/image/LP/LP6.png"
                lp_red_bai.source = "qrc:/image/LP/LP8.png"
            }
        }
        PauseAnimation { duration: 200 }
        ScriptAction {
            script: {
                damage_red_bai.source = "qrc:/image/LP/damage3.png";
                lp_red_bai.source = "qrc:/image/LP/LP4.png"
            }
        }
        PauseAnimation { duration: 150 }
        ScriptAction {
            script: {
                damage_red_minus.visible = false;
                damage_red_qian.visible = false;
                damage_red_bai.visible = false;
                damage_red_shi.visible = false;
                damage_red_ge.visible = false;
                lp_red_bai.source = "qrc:/image/LP/LP1.png"
            }
        }

        PauseAnimation { duration: 200 }
        ScriptAction {
            script: {

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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_dr_b.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_st_b.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_m1_b.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b1.png"; battlePhaseImage.visible = true; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b2.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b3.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b4.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b5.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b6.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b7.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_b8.png"; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_m2_b.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_en_b.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_dr_r.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_st_r.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_m1_r.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r1.png"; battlePhaseImage.visible = true; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r2.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r3.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r4.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r5.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r6.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r7.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.source = "qrc:/image/phase_name/e_ba_r8.png"; } }
            PauseAnimation { duration: 100 }
            ScriptAction { script: { battlePhaseImage.visible = false; } }
        }
        SequentialAnimation {
            PauseAnimation { duration: 1500 }
            ScriptAction {
                script: {
                    if(Data.findBlueFrontMatchActiveCondition()) {
                        Data.boardDialog.source = "qrc:/image/dialog/dialog1.png"
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_m2_r.png"; otherPhaseImage.visible = true; } }
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
            ScriptAction { script: { otherPhaseImage.source = "qrc:/image/phase_name/e_en_r.png"; otherPhaseImage.visible = true; } }
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
                        image_DP.source = "qrc:/image/phase/pha_b_dr.bmp"
                        image_DP.width = 648
                        image_DP.height = 135
                        image_SP.source = "qrc:/image/phase/pha_b_st.bmp"
                        image_SP.width = 648
                        image_SP.height = 135
                        image_M1.source = "qrc:/image/phase/pha_b_m1.bmp"
                        image_M1.width = 648
                        image_M1.height = 135
                        image_BP.source = "qrc:/image/phase/pha_b_ba.bmp"
                        image_BP.width = 648
                        image_BP.height = 135
                        image_M2.source = "qrc:/image/phase/pha_b_m2.bmp"
                        image_M2.width = 648
                        image_M2.height = 135
                        image_EP.source = "qrc:/image/phase/pha_b_en.bmp"
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
                        image_DP.source = "qrc:/image/phase/pha_s_dr.bmp"
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
                        image_SP.source = "qrc:/image/phase/pha_s_st.bmp"
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
                        image_M1.source = "qrc:/image/phase/pha_s_m1.bmp"
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
                        image_BP.source = "qrc:/image/phase/pha_s_ba.bmp"
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
                        image_M2.source = "qrc:/image/phase/pha_s_m2.bmp"
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
                        image_EP.source = "qrc:/image/phase/pha_s_en.bmp"
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
                    battle_turnMusic.play();
                    Data.showRedSword();
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
                        image_DP.source = "qrc:/image/phase/pha_r_dr.bmp"
                        image_DP.width = 648
                        image_DP.height = 135
                        image_DP.y = 0
                        image_SP.source = "qrc:/image/phase/pha_r_st.bmp"
                        image_SP.width = 648
                        image_SP.height = 135
                        image_SP.y = 0
                        image_M1.source = "qrc:/image/phase/pha_r_m1.bmp"
                        image_M1.width = 648
                        image_M1.height = 135
                        image_M1.y = 0
                        image_BP.source = "qrc:/image/phase/pha_r_ba.bmp"
                        image_BP.width = 648
                        image_BP.height = 135
                        image_BP.y = 0
                        image_M2.source = "qrc:/image/phase/pha_r_m2.bmp"
                        image_M2.width = 648
                        image_M2.height = 135
                        image_M2.y = 0
                        image_EP.source = "qrc:/image/phase/pha_r_en.bmp"
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
                        image_DP.source = "qrc:/image/phase/pha_s_dr.bmp"
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
                        image_SP.source = "qrc:/image/phase/pha_s_st.bmp"
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
                        image_M1.source = "qrc:/image/phase/pha_s_m1.bmp"
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
                        image_BP.source = "qrc:/image/phase/pha_s_ba.bmp"
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
                        image_M2.source = "qrc:/image/phase/pha_s_m2.bmp"
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
                        image_EP.source = "qrc:/image/phase/pha_s_en.bmp"
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
