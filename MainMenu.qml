import QtQuick 2.3
import "data.js" as Data
//import QtWebSockets 1.0
import QtQuick.Controls 2.14
import QtMultimedia 5.14

Item {
    id: main_menu
    anchors.left: parent.left
    anchors.top: parent.top
    width: 1440
    height: 1080

    Audio {
        id: startMusic
//        source: "voice/start.wav"
    }

    Audio {
        id: decideMusic
//        source: "voice/decide.wav"
    }

    Image {
        id: menu_0
        anchors.fill: main_menu
        width: 1440
        height: 1080
        source: "image/menu/menu_main_0.png"

        Image {
            id: menu_1
            x: 177
            y: 527
            width: 135
            height: 522
            source: "image/menu/menu_main_1.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                }
            }
        }

        Image {
            id: menu_2
            x: 486
            y: 527
            width: 135
            height: 522
            source: "image/menu/menu_main_2.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    jdks_ani.start();
                }
            }
        }

        Image {
            id: menu_3
            x: 794
            y: 527
            width: 135
            height: 522
            source: "image/menu/menu_main_3.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                }
            }
        }

        Image {
            id: menu_4
            x: 1103
            y: 527
            width: 135
            height: 522
            source: "image/menu/menu_main_4.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                }
            }
        }
    }

    Rectangle {
        id: jdls_mask
        anchors.fill: main_menu
        width: 1440
        height: 1080
        color: "black"
        visible: false
    }

    Image {
        id:jdks
        x: 507
        y: 435
        width: 828
        height: 288
        source: "image/juedoukaishi.png"
        visible: false
    }

    ParallelAnimation {
        id: jdks_ani
        running: false
        SequentialAnimation {
            ScriptAction { script: { decideMusic.play(); menu_0.visible = false; jdls_mask.visible = true; jdls_mask.opacity = 0.5; } }
            PauseAnimation { duration: 1000 }
            ScriptAction { script: { jdls_mask.visible = false; } }
        }
        SequentialAnimation {
            ScriptAction { script: { jdks.visible = true; startMusic.play(); } }
            NumberAnimation { target: jdks; property: "y"; from: -300; to: 335; duration: 800; easing.type: Easing.OutElastic }
            PauseAnimation { duration: 500 }
            ScriptAction { script: { jdks.visible = false; main_menu.visible = false; Data.start_game(); } }
        }
    }
}
