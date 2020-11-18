import QtQuick 2.3
import "data.js" as Data
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Image {
    id: board
    anchors.top: parent.top
    anchors.left: parent.left
    width: 800
    height: 600
    source: "qrc:/image/beijing.jpg"

    Component.onCompleted: {
        Data.boardObject = board;
        Data.startGame();
    }

    function hand_add(id) {
        console.log("receive hand add " + id);
        var component = Qt.createComponent("HandImage.qml");
        if (component.status === Component.Ready) {
            var handImage = component.createObject(board);
            handImage.source = "qrc:/image/hand/" + Data.boardCards[id]["name"] +".png";
            Data.blueHandCards.push(handImage);
            Data.adjustHand();
        }
    }

    function front_add(id) {
        var index = Data.findBlueFrontIndex();
        if(index !== -1) {
            console.log("receive front add " + id);
            var component = Qt.createComponent("FrontImage.qml");
            if (component.status === Component.Ready) {
                var frontImage = component.createObject(board);
                frontImage.source = "qrc:/image/hand/" + Data.boardCards[id]["name"] +".png";
                frontImage.x = 350+78*index;
                frontImage.y = 317;
                frontImage.z = 2;
                frontImage.text = Data.boardCards[id]["atk"] + "/" + Data.boardCards[id]["def"];
                Data.blueFrontCards[index] = frontImage;
            }
        } else {
            console.log("can not find empty front area");
        }
    }
    function back_add(id) {
        var index = Data.findBlueBackIndex();
        if(index !== -1) {
            console.log("receive back add " + id);
            var backImage = Qt.createQmlObject('import QtQuick 2.0;Image{width:50;height:72;}', board);
            backImage.source = "qrc:/image/area/" + Data.boardCards[id]["name"] +".png";
            backImage.x = 350+78*index;
            backImage.y = 424;
            backImage.z = 2;
            Data.blueBackCards[index] = backImage;
        } else {
            console.log("can not find empty back area");
        }
    }
    function grave_add(id) {
        console.log("receive grave add " + Data.boardCards[id]["name"]);
    }
    function deck_add(id) {
        console.log("receive deck add " + Data.boardCards[id]["name"]);
    }

    function hand_remove(index) {
        console.log("receive hand remove " + index);
        var handImage = Data.blueHandCards[index];
        handImage.destroy();
        Data.blueHandCards.splice(index, 1);
        Data.adjustHand();
    }
    function front_remove(index) {
        console.log("receive front remove " + index);
        var frontImage = Data.blueFrontCards[index];
        frontImage.destroy();
        delete Data.blueFrontCards[index];
    }
    function back_remove(index) {
        console.log("receive back remove " + index);
        var backImage = Data.blueBackCards[index];
        backImage.destroy();
        delete Data.blueBackCards[index];
    }
    function grave_remove(index) {
        console.log("receive grave remove " + index);
    }
    function deck_remove(index) {
        console.log("receive deck remove " + index);
    }
    function dialog_show(text) {
        console.log("receive dialog show " + text);
        textDialog.text = text
        dialog.visible = true
    }
    function start_game() {
        console.log("receive start game");
        Data.startGame();
    }
    function go_battle_phase() {
        if(Data.blueFrontCards[0] !== undefined) Data.blueFrontCards[0].swordVisiable = true;
        if(Data.blueFrontCards[1] !== undefined) Data.blueFrontCards[1].swordVisiable = true;
        if(Data.blueFrontCards[2] !== undefined) Data.blueFrontCards[2].swordVisiable = true;
        if(Data.blueFrontCards[3] !== undefined) Data.blueFrontCards[3].swordVisiable = true;
        if(Data.blueFrontCards[4] !== undefined) Data.blueFrontCards[4].swordVisiable = true;
    }

    Dialog {
        id: dialog
        visible: false
        width: 400
        height: 100
        modality: Qt.NonModal
        contentItem: Rectangle {
            color: "lightskyblue"
            Text {
                id: textDialog
                color: "navy"
                anchors.centerIn: parent
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1}
}
##^##*/
