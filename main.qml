import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    id: demo
    visible: true
    x: 20
    y: 50
    width: 1600
    height: 600
    title: qsTr("Demo")

    BoardItem {
        id: dotaBoard
    }

    DebugItem {
        id: dotaDebug
    }

    Component.onCompleted: {
        dotaDebug.hand_add.connect(dotaBoard.hand_add)
        dotaDebug.front_add.connect(dotaBoard.front_add)
        dotaDebug.back_add.connect(dotaBoard.back_add)
        dotaDebug.grave_add.connect(dotaBoard.grave_add)
        dotaDebug.deck_add.connect(dotaBoard.deck_add)
        dotaDebug.hand_remove.connect(dotaBoard.hand_remove)
        dotaDebug.front_remove.connect(dotaBoard.front_remove)
        dotaDebug.back_remove.connect(dotaBoard.back_remove)
        dotaDebug.grave_remove.connect(dotaBoard.grave_remove)
        dotaDebug.deck_remove.connect(dotaBoard.deck_remove)
        dotaDebug.dialog_show.connect(dotaBoard.dialog_show)
        dotaDebug.start_game.connect(dotaBoard.start_game)
        dotaDebug.go_battle_phase.connect(dotaBoard.go_battle_phase)
    }
}
