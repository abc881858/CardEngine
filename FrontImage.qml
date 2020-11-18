import QtQuick 2.0
import "data.js" as Data

Item {
    property alias source: pic.source;
    property alias text: label.text;
    property alias swordVisiable: sword.visible
    property string name
    property string description
    property string attribute
    property int level
    property string kind
    property string type
    property int atk
    property int def

    property bool hasAttacked;

    Image {
        id: pic
        anchors.left: parent.left
        anchors.top: parent.top
        width:50
        height:72

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                if(Data.judgeCard() === true)
                {
                    cursorShape = Qt.WaitCursor
                }
            }
        }

        Image {
            id: sword
            anchors.centerIn: parent
            source: "qrc:/image/sword.png"
            visible: false

//            MouseArea {
//                anchors.fill: parent
//                hoverEnabled: true
//                onPositionChanged: { sword.rotation = Math.atan((mouseX-width/2)/(height/2-mouseY))/Math.PI*180; }
//            }
        }
    }

    TextInput {
        id: label
        anchors.horizontalCenter: pic.horizontalCenter
        anchors.top: pic.bottom
        anchors.topMargin: 5
        width: 65
        height: 17
        color: "#ffffff"
        font.pixelSize: 12
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
