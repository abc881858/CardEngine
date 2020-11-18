import QtQuick 2.0

Image {
    width: 100
    height: 145
    MouseArea {
        anchors.fill: parent
        hoverEnabled : true
        onEntered: parent.y = parent.y - 35
        onExited: parent.y = parent.y + 35
    }
}
