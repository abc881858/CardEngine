import QtQuick 2.3
import "data.js" as Data
import QtQuick.Dialogs 1.2
//import QtWebSockets 1.0
import QtQuick.Controls 2.14

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
//        Data.boardSocket = socket;
        Data.infoImageObject = infoImage;
        Data.infoTextObject = infoText;
        Data.dialogText = textDialog;
        Data.dialogObject = dialog;
        Data.blueSword = blueSword0;
        Data.redSword = redSword0;
        Data.blueSwordAnimationObject = blueSwordAnimation;
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

    Image {
        id: lp_blue_wan
        x: 102
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/NA.png"
    }

    Image {
        id: lp_blue_qian
        x: 149
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP8.png"
    }

    Image {
        id: lp_blue_bai
        x: 196
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_blue_shi
        x: 243
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_blue_ge
        x: 290
        y: 0
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_red_wan
        x: 102
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/NA.png"
    }

    Image {
        id: lp_red_qian
        x: 149
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP8.png"
    }

    Image {
        id: lp_red_bai
        x: 196
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_red_shi
        x: 243
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Image {
        id: lp_red_ge
        x: 290
        y: 950
        width: 47
        height: 61
        source: "qrc:/image/LP/LP0.png"
    }

    Dialog {
        id: dialog
        visible: false
        width: 720
        height: 180
        contentItem: Rectangle {
            color: "lightskyblue"
            Text {
                id: textDialog
                color: "navy"
                anchors.centerIn: parent
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
        width: 342
        height: 265
        TextArea {
            id: infoText
            readOnly: true
            font.family: "Helvetica"
            font.pointSize: 10
            wrapMode: TextEdit.Wrap
        }
    }

    Image {
        id: blueSword0
        x: 630
        y: 571
        z: 3
        width: 90
        height: 130
        source: "qrc:/image/sword.png"
        fillMode: Image.PreserveAspectFit
        visible: false
        property int indexFrom: 0
        property int indexTo: 0
    }

    SequentialAnimation {
        id: blueSwordAnimation
        ParallelAnimation {
            NumberAnimation {
                target: blueSword0
                properties: "x";
                to: 630+(4-blueSword0.indexTo)*140
                duration: 200
            }
            NumberAnimation {
                target: blueSword0
                properties: "y";
                from: 571
                to: 383
                duration: 200
            }
        }
        ScriptAction {
            script: {
                blueSword0.visible = false;
                blueSword0.x = 630;
                blueSword0.y = 571;
                blueSword0.rotation = 0;
                blueSword0.source = "qrc:/image/sword.png"
            }
        }
        PauseAnimation {
            duration: 1000
        }
        ScriptAction {
            script: {
                if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFacedownFront") {
                    Data.redFrontCards[Data.battleToIndex].state = "redHorizontalFaceupFront";
                }
            }
        }
        PauseAnimation {
            duration: 1000
        }
        ScriptAction {
            script: {
                var isdnFrom = Data.blueFrontCards[Data.battleFromIndex].isdn;
                var isdnTo = Data.redFrontCards[Data.battleToIndex].isdn;
                if(Data.redFrontCards[Data.battleToIndex].state === "redVerticalFaceupFront") {
                    if(Number(Data.boardCards[isdnFrom]["atk"]) >= Number(Data.boardCards[isdnTo]["atk"])) {
                        Data.redFrontCards[Data.battleToIndex].state = "redGrave";
                        Data.redGraveCards.push(Data.redFrontCards[Data.battleToIndex]);
                        delete Data.redFrontCards[Data.battleToIndex];
                        Data.redLP -= Data.boardCards[isdnFrom]["atk"] - Data.boardCards[isdnTo]["atk"];
                        console.log("Data.redLP: " + Data.redLP);
                    }
                    if(Number(Data.boardCards[isdnFrom]["atk"]) <= Number(Data.boardCards[isdnTo]["atk"])) {
                        Data.blueFrontCards[Data.battleFromIndex].state = "blueGrave";
                        Data.blueGraveCards.push(Data.blueFrontCards[Data.battleFromIndex]);
                        delete Data.blueFrontCards[Data.battleFromIndex];
                        Data.blueLP -= Data.boardCards[isdnTo]["atk"] - Data.boardCards[isdnFrom]["atk"];
                        console.log("Data.blueLP: " + Data.blueLP);
                    }
                } else if(Data.redFrontCards[Data.battleToIndex].state === "redHorizontalFaceupFront") {
                    if(Number(Data.boardCards[isdnFrom]["atk"]) > Number(Data.boardCards[isdnTo]["def"])) {
                        Data.redFrontCards[Data.battleToIndex].state = "redGrave";
                        Data.redGraveCards.push(Data.redFrontCards[Data.battleToIndex]);
                        delete Data.redFrontCards[Data.battleToIndex];
                    } else if(Number(Data.boardCards[isdnTo]["def"]) > Number(Data.boardCards[isdnFrom]["atk"])) {
                        Data.blueLP -= Data.boardCards[isdnTo]["def"] - Data.boardCards[isdnFrom]["atk"];
                        console.log("Data.blueLP: " + Data.blueLP);
                    }
                }
            }
        }
        ScriptAction {
            script: {
                Data.battleFromIndex = -1;
                Data.battleToIndex = -1;
            }
        }
    }

    Image {
        id: redSword0
        x: 1192
        y: 383
        z: 3
        width: 90
        height: 130
        source: "qrc:/image/sword.png"
        fillMode: Image.PreserveAspectFit
        visible: false
        rotation: 180
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

    transitions: [
        Transition {
            from: "startGame"
            to: "blueDrawPhase"
            ParallelAnimation {
                SequentialAnimation {
                    id: animation_DP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_DP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_DP.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 500 }
                    ScriptAction { script: { Data.blue_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.blue_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.blue_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.blue_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.blue_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.red_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.red_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.red_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.red_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.red_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { Data.blue_draw_card(); } }
                    PauseAnimation { duration: 250 }
                    ScriptAction { script: { state = "blueStandbyPhase"; } }
                }
            }
        },
        Transition {
            from: "blueDrawPhase"
            to: "blueStandbyPhase"
            ParallelAnimation {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            image_DP.x = 0;
                            animation_DP.stop();
                            animation3_DP.stop();
                        }
                    }
                    SequentialAnimation {
                        id: animation_SP
                        loops: Animation.Infinite
                        ScriptAction { script: { image_SP.x = 0; } }
                        PauseAnimation { duration: 200 }
                        ScriptAction { script: { image_SP.x = -72 } }
                        PauseAnimation { duration: 600 }
                    }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 800 }
                    ScriptAction { script: { state = "blueMain1Phase"; } }
                }
            }
        },
        Transition {
            from: "blueStandbyPhase"
            to: "blueMain1Phase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_SP.x = 0;
                        animation_SP.stop();
                    }
                }
                SequentialAnimation {
                    id: animation_M1
                    loops: Animation.Infinite
                    ScriptAction { script: { image_M1.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_M1.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "blueMain1Phase"
            to: "blueBattlePhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_M1.x = 0;
                        animation_M1.stop();
                        for(var index = 0; index<5; index++) {
                            if(Data.blueFrontCards[index] !== undefined) {
                                if(Data.blueFrontCards[index].state === "blueVerticalFaceupFront") {
                                    Data.blueFrontCards[index].battleState = 1
                                    Data.blueFrontCards[index].swordVisible = true;
                                }
                            }
                        }
                    }
                }
                SequentialAnimation {
                    id: animation_BP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_BP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_BP.x = -72 } }
                    PauseAnimation { duration: 600 }
                }

            }
        },
//        Transition {
//            from: "blueMain1Phase"
//            to: "blueEndPhase"
//            SequentialAnimation {
//                ScriptAction {
//                    script: {
//                        image_M1.x = 0;
//                        animation_M1.stop();
//                    }
//                }
//                SequentialAnimation {
//                    id: animation_EP
//                    loops: Animation.Infinite
//                    ScriptAction { script: { image_EP.x = 0; } }
//                    PauseAnimation { duration: 200 }
//                    ScriptAction { script: { image_EP.x = -72 } }
//                    PauseAnimation { duration: 600 }
//                }
//            }
//        },
        Transition {
            from: "blueBattlePhase"
            to: "blueMain2Phase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_BP.x = 0;
                        animation_BP.stop();
                        for(var index = 0; index<5; index++) {
                            if(Data.blueFrontCards[index] !== undefined) {
                                if(Data.blueFrontCards[index].state === "blueVerticalFaceupFront") {
                                    Data.blueFrontCards[index].battleState = 0
                                    Data.blueFrontCards[index].swordVisible = false;
                                }
                            }
                        }
                    }
                }
                SequentialAnimation {
                    id: animation_M2
                    loops: Animation.Infinite
                    ScriptAction { script: { image_M2.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_M2.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "blueBattlePhase"
            to: "blueEndPhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_BP.x = 0;
                        animation_BP.stop();
                        for(var index = 0; index<5; index++) {
                            if(Data.blueFrontCards[index] !== undefined) {
                                if(Data.blueFrontCards[index].state === "blueVerticalFaceupFront") {
                                    Data.blueFrontCards[index].battleState = 0
                                    Data.blueFrontCards[index].swordVisible = false;
                                }
                            }
                        }
                    }
                }
                SequentialAnimation {
                    id: animation3_EP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_EP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_EP.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "blueMain2Phase"
            to: "blueEndPhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_M2.x = 0;
                        animation_M2.stop();
                    }
                }
                SequentialAnimation {
                    id: animation_EP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_EP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_EP.x = -72 } }
                    PauseAnimation { duration: 600 }
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
                        animation_EP.stop();
                        animation3_EP.stop();
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
                    }
                }
                SequentialAnimation {
                    id: animation2_DP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_DP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_DP.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "redDrawPhase"
            to: "redStandbyPhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_DP.x = 0;
                        image_DP.y = -135;
                        animation2_DP.stop();
                    }
                }
                SequentialAnimation {
                    id: animation2_SP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_SP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_SP.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "redStandbyPhase"
            to: "redMain1Phase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_SP.x = 0;
                        image_SP.y = -135;
                        animation2_SP.stop();
                    }
                }
                SequentialAnimation {
                    id: animation2_M1
                    loops: Animation.Infinite
                    ScriptAction { script: { image_M1.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_M1.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "redMain1Phase"
            to: "redBattlePhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_M1.x = 0;
                        image_M1.y = -135;
                        animation2_M1.stop();
                    }
                }
                SequentialAnimation {
                    id: animation2_BP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_BP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_BP.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "redBattlePhase"
            to: "redMain2Phase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_BP.x = 0;
                        image_BP.y = -135;
                        animation2_BP.stop();
                    }
                }
                SequentialAnimation {
                    id: animation2_M2
                    loops: Animation.Infinite
                    ScriptAction { script: { image_M2.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_M2.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "redMain2Phase"
            to: "redEndPhase"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        image_M2.x = 0;
                        image_M2.y = -135;
                        animation2_M2.stop();
                    }
                }
                SequentialAnimation {
                    id: animation2_EP
                    loops: Animation.Infinite
                    ScriptAction { script: { image_EP.x = 0; } }
                    PauseAnimation { duration: 200 }
                    ScriptAction { script: { image_EP.x = -72 } }
                    PauseAnimation { duration: 600 }
                }
            }
        },
        Transition {
            from: "redEndPhase"
            to: "blueDrawPhase"
            ParallelAnimation {
                SequentialAnimation {
                    ScriptAction {
                        script: Data.blueSummonEnable = true;
                    }
                    PauseAnimation { duration: 2500 }
                    ScriptAction { script: { state = "blueStandbyPhase"; } }
                }
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            image_DP.x = 0;
                            animation2_EP.stop();
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

                        }
                    }
                    SequentialAnimation {
                        id: animation3_DP
                        loops: Animation.Infinite
                        ScriptAction { script: { image_DP.x = 0; } }
                        PauseAnimation { duration: 200 }
                        ScriptAction { script: { image_DP.x = -72 } }
                        PauseAnimation { duration: 600 }
                    }
                }
            }
        }
    ]
}
