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

    signal hand_add(string id)
    signal front_add(string id)
    signal back_add(string id)
    signal grave_add(string id)
    signal deck_add(string id)
    signal hand_remove(int index)
    signal front_remove(int index)
    signal back_remove(int index)
    signal grave_remove(int index)
    signal deck_remove(int index)
    signal dialog_show(string text)
    signal start_game()
    signal go_draw_phase()
    signal go_standby_phase()
    signal go_main1_phase()
    signal go_battle_phase()
    signal go_main2_phase()
    signal go_end_phase()

    Rectangle {
        id: rectangle
        x: 8
        y: 0
        width: 340
        height: 40
        color: "#ffffff"
        border.color: "#00aaff"

        Text {
            id: element1
            x: 0
            y: 0
            width: 90
            height: 40
            text: qsTr("Add Index:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        TextInput {
            id: addIndex
            x: 90
            y: 0
            width: 80
            height: 40
            text: "0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: element2
            x: 170
            y: 0
            width: 90
            height: 40
            text: qsTr("Remove Index:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        TextInput {
            id: removeIndex
            x: 260
            y: 0
            width: 80
            height: 40
            text: "0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Button {
        id: button1
        x: 8
        y: 46
        width: 154
        text: qsTr("Blue Hand add One Card")
        onClicked: {
            console.log("send hand add");
            hand_add(card_id.text)
        }
    }

    Button {
        id: button2
        x: 8
        y: 91
        width: 154
        text: qsTr("Blue Front add One Card")
        onClicked: {
            console.log("send front add");
            front_add(card_id.text)
        }
    }

    Button {
        id: button3
        x: 8
        y: 136
        width: 154
        text: qsTr("Blue Back add One Card")
        onClicked: {
            console.log("send back add");
            back_add(card_id.text)
        }
    }

    Button {
        id: button4
        x: 8
        y: 181
        width: 154
        text: qsTr("Blue Grave add One Card")
        onClicked: {
            console.log("send grave add");
            grave_add(card_id.text)
        }
    }

    Button {
        id: button5
        x: 8
        y: 226
        width: 154
        text: qsTr("Blue Deck add One Card")
        onClicked: {
            console.log("send deck add");
            deck_add(card_id.text)
        }
    }

    Button {
        id: button6
        x: 175
        y: 45
        width: 172
        text: qsTr("Blue Hand remove One Card")
        onClicked: {
            console.log("send hand remove");
            hand_remove(removeIndex.text)
        }
    }

    Button {
        id: button7
        x: 175
        y: 90
        width: 172
        text: qsTr("Blue Front remove One Card")
        onClicked: {
            console.log("send front remove");
            front_remove(removeIndex.text)
        }
    }

    Button {
        id: button8
        x: 175
        y: 135
        width: 172
        text: qsTr("Blue Back remove One Card")
        onClicked: {
            console.log("send back remove");
            back_remove(removeIndex.text)
        }
    }

    Button {
        id: button9
        x: 175
        y: 180
        width: 172
        text: qsTr("Blue Grave remove One Card")
        onClicked: {
            console.log("send grave remove");
            grave_remove(removeIndex.text)
        }
    }

    Button {
        id: button10
        x: 175
        y: 225
        width: 172
        text: qsTr("Blue Deck remove One Card")
        onClicked: {
            console.log("send deck remove");
            deck_remove(removeIndex.text)
        }
    }

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
        text: qsTr("名称")
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
        text: qsTr("属性")
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
        text: qsTr("等级")
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
        text: qsTr("类型")
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
        text: qsTr("种族")
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
        text: qsTr("攻击")
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
        text: qsTr("防御")
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
        x: 363
        y: 420
        text: qsTr("Draw Phase")
        onClicked: {
            console.log("draw phase");
            go_draw_phase();
        }
    }

    Button {
        id: button14
        x: 363
        y: 480
        text: qsTr("Standby Phase")
        onClicked: {
            console.log("standby phase");
            go_standby_phase();
        }
    }

    Button {
        id: button15
        x: 363
        y: 537
        text: qsTr("M1 Phase")
        onClicked: {
            console.log("main1 phase");
            go_main1_phase();
        }
    }

    Button {
        id: button
        x: 517
        y: 420
        text: qsTr("Battle Phase")
        onClicked: {
            console.log("Battle Phase")
            go_battle_phase();
        }
    }

    Button {
        id: button11
        x: 517
        y: 480
        text: qsTr("M2 Phase")
        onClicked: {
            console.log("main2 phase");
            go_main2_phase();
        }
    }

    Button {
        id: button12
        x: 517
        y: 537
        text: qsTr("End Phase")
        onClicked: {
            console.log("end phase");
            go_end_phase();
        }
    }

    Button {
        id: button16
        x: 517
        y: 361
        text: qsTr("Dialog")
        onClicked: {
            console.log("dialog show");
            dialog_show("some text....");
        }
    }

    Button {
        id: button17
        x: 363
        y: 361
        width: 100
        height: 40
        text: qsTr("start game")
        onClicked: {
            console.log("start game");
            start_game();
        }
    }

    Button {
        id: button18
        x: 8
        y: 281
        width: 154
        text: qsTr("Red Hand add One Card")
    }

    Button {
        id: button19
        x: 8
        y: 326
        width: 154
        text: qsTr("Red Front add One Card")
    }

    Button {
        id: button20
        x: 8
        y: 371
        width: 154
        text: qsTr("Red Back add One Card")
    }

    Button {
        id: button21
        x: 8
        y: 416
        width: 154
        text: qsTr("Red Grave add One Card")
    }

    Button {
        id: button22
        x: 8
        y: 461
        width: 154
        text: qsTr("Red Deck add One Card")
    }

    Button {
        id: button23
        x: 175
        y: 280
        width: 172
        text: qsTr("Red Hand remove One Card")
    }

    Button {
        id: button24
        x: 175
        y: 325
        width: 172
        text: qsTr("Red Front remove One Card")
    }

    Button {
        id: button25
        x: 175
        y: 370
        width: 172
        text: qsTr("Red Back remove One Card")
    }

    Button {
        id: button26
        x: 175
        y: 415
        width: 172
        text: qsTr("Red Grave remove One Card")
    }

    Button {
        id: button27
        x: 175
        y: 460
        width: 172
        text: qsTr("Red Deck remove One Card")
    }

    Component.onCompleted: {
        card_id.text = "1"
    }
}
