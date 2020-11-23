import QtQuick 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import "data.js" as Data

Item {
    anchors.top: parent.top
    anchors.right: parent.right
    width: 800
    height: 600

    Image {
        id: image
        x: 600
        y: 0
        width: 200
        height: 290
        source: "image/info/null.png"
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: element3
        x: 363
        y: 0
        width: 67
        height: 40
        text: "ISDN"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 32
    }

    Rectangle {
        x: 436
        y: 0
        width: 140
        height: 40
        border.width: 1
        border.color: "#000000"

        TextInput {
            id: card_id
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
            onTextChanged: {
                if(text!==null && parseInt(text)>=0)
                {
                    console.log(text);
                    var JsonArray = JSON.parse(Data.array);
                    name.text = JsonArray[text]["name"];
                    attr.text = JsonArray[text]["attribute"];
                    level.text = JsonArray[text]["level"];
                    kind.text = JsonArray[text]["kind"];
                    type.text = JsonArray[text]["type"];
                    atk.text = JsonArray[text]["atk"];
                    def.text = JsonArray[text]["def"];
                    image.source = "image/info/" + name.text + ".png";
                }
            }
        }
    }

    Text {
        id: label
        x: 363
        y: 45
        width: 33
        height: 40
        text: qsTr("mingcheng")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Text {
        id: name
        x: 419
        y: 45
        width: 157
        height: 40
        color: "#00aaff"
        lineHeight: 1
        styleColor: "#7b7df3"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Text {
        id: label1
        x: 363
        y: 90
        width: 33
        height: 40
        text: qsTr("shuxing")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize:12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: attr
        x: 419
        y: 91
        width: 157
        height: 40
        color: "#00aaff"
        styleColor: "#7b7df3"
        lineHeight: 1
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: label2
        x: 363
        y: 135
        width: 33
        height: 40
        text: qsTr("dengji")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: level
        x: 419
        y: 135
        width: 157
        height: 40
        color: "#00aaff"
        styleColor: "#7b7df3"
        verticalAlignment: Text.AlignVCenter
        lineHeight: 1
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: label3
        x: 363
        y: 180
        width: 33
        height: 40
        text: qsTr("leixing")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: kind
        x: 419
        y: 180
        width: 157
        height: 40
        color: "#00aaff"
        styleColor: "#7b7df3"
        lineHeight: 1
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: label4
        x: 363
        y: 226
        width: 33
        height: 40
        text: qsTr("zhongzu")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: type
        x: 419
        y: 226
        width: 157
        height: 40
        color: "#00aaff"
        styleColor: "#7b7df3"
        verticalAlignment: Text.AlignVCenter
        lineHeight: 1
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: label5
        x: 363
        y: 270
        width: 33
        height: 40
        text: qsTr("gongji")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: atk
        x: 419
        y: 270
        width: 157
        height: 40
        color: "#00aaff"
        styleColor: "#7b7df3"
        lineHeight: 1
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: label6
        x: 363
        y: 315
        width: 33
        height: 40
        text: qsTr("fangyu")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: def
        x: 419
        y: 316
        width: 157
        height: 40
        color: "#00aaff"
        styleColor: "#7b7df3"
        lineHeight: 1
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: button13
        x: 8
        y: 39
        width: 79
        height: 22
        text: qsTr("Draw Phase")
        onClicked: {
            console.log("draw phase");
            Data.go_draw_phase();
        }
    }

    Button {
        id: button14
        x: 8
        y: 67
        width: 100
        height: 24
        text: qsTr("Standby Phase")
        onClicked: {
            console.log("standby phase");
            Data.go_standby_phase();
        }
    }

    Button {
        id: button15
        x: 8
        y: 97
        width: 68
        height: 23
        text: qsTr("M1 Phase")
        onClicked: {
            console.log("main1 phase");
            Data.go_main1_phase();
        }
    }

    Button {
        id: button
        x: 102
        y: 39
        width: 93
        height: 22
        text: qsTr("Battle Phase")
        onClicked: {
            console.log("Battle Phase")
            Data.go_battle_phase();
        }
    }

    Button {
        id: button11
        x: 114
        y: 67
        width: 66
        height: 18
        text: qsTr("M2 Phase")
        onClicked: {
            console.log("main2 phase");
            Data.go_main2_phase();
        }
    }

    Button {
        id: button12
        x: 102
        y: 97
        width: 78
        height: 23
        text: qsTr("End Phase")
        onClicked: {
            console.log("end phase");
            Data.go_end_phase();
        }
    }

    Button {
        id: button16
        x: 102
        y: 8
        width: 70
        height: 25
        text: qsTr("Dialog")
        onClicked: {
            console.log("dialog show");
            Data.dialog_show("some text....");
        }
    }

    Button {
        id: button17
        x: 8
        y: 8
        width: 79
        height: 25
        text: qsTr("start game")
        onClicked: {
            console.log("start game");
            Data.start_game();
        }
    }

    Button {
        id: button28
        x: 8
        y: 242
        text: qsTr("Blue Draw")
        onClicked: {
            console.log("blue draw");
            Data.blue_draw_card();
        }
    }

    Button {
        id: button29
        x: 162
        y: 242
        text: qsTr("Red Draw")
        onClicked: {
            console.log("red draw");
            Data.red_draw_card();
        }
    }

    Button {
        id: button30
        x: 8
        y: 299
        text: qsTr("redVerticalFaceupFront")
        onClicked: {
            Data.redVerticalFaceupFront(Number(indexOfHand.text));
        }
    }

    Button {
        id: button32
        x: 8
        y: 345
        text: qsTr("redHorizontalFacedownFront")
        onClicked: {
            Data.redHorizontalFacedownFront(Number(indexOfHand.text));
        }
    }

    Text {
        id: element
        x: 172
        y: 346
        text: qsTr("Index of Hand")
        font.pixelSize: 12
    }

    TextInput {
        id: indexOfHand
        x: 172
        y: 365
        width: 80
        height: 15
        text: qsTr("0")
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Component.onCompleted: {
        card_id.text = "1"
    }
}
