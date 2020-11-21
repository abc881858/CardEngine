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
}
