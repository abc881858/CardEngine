import QtQuick 2.14
import QtQuick.Window 2.14
import "data.js" as Data

Window {
    id: demo
    visible: true
    x: 20
    y: 50
    width: 1600
    height: 600
    title: qsTr("Demo")

    BoardItem {
        id: dotaBoard;
    }

    RemoteItem {
        id: dotaRemote;
    }

    Component.onCompleted: {
        dotaRemote.hand_add.connect(Data.hand_add)
        dotaRemote.front_add.connect(Data.front_add)
        dotaRemote.back_add.connect(Data.back_add)
        dotaRemote.grave_add.connect(Data.grave_add)
        dotaRemote.deck_add.connect(Data.deck_add)
        dotaRemote.hand_remove.connect(Data.hand_remove)
        dotaRemote.front_remove.connect(Data.front_remove)
        dotaRemote.back_remove.connect(Data.back_remove)
        dotaRemote.grave_remove.connect(Data.grave_remove)
        dotaRemote.deck_remove.connect(Data.deck_remove)
        dotaRemote.dialog_show.connect(Data.dialog_show)
        dotaRemote.start_game.connect(Data.start_game)
        dotaRemote.go_draw_phase.connect(Data.go_draw_phase)
        dotaRemote.go_standby_phase.connect(Data.go_standby_phase)
        dotaRemote.go_main1_phase.connect(Data.go_main1_phase)
        dotaRemote.go_battle_phase.connect(Data.go_battle_phase)
        dotaRemote.go_main2_phase.connect(Data.go_main2_phase)
        dotaRemote.go_end_phase.connect(Data.go_end_phase)
    }
}
