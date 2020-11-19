.pragma library

var array = '{\
"0":{"name":"null","description":"No_Description","attribute":"No_Attribute","level":"0","kind":"No_Kind","type":"No_Type","atk":"-1","def":"-1"},\
"1":{"name":"meleecreepgood","description":"meleecreepgood","attribute":"Light_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1300","def":"1200"},\
"2":{"name":"meleecreepbad","description":"meleecreepbad","attribute":"Dark_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1300","def":"1200"},\
"3":{"name":"rangedcreepgood","description":"rangedcreepgood","attribute":"Light_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1200","def":"1300"},\
"4":{"name":"rangedcreepbad","description":"rangedcreepbad","attribute":"Dark_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1200","def":"1300"},\
"5":{"name":"zeus","description":"zeus","attribute":"Light_Attribute","level":"2","kind":"EffectMonster_Kind","type":"Spellcaster_Type","atk":"500","def":"350"},\
"6":{"name":"axe","description":"axe","attribute":"Earth_Attribute","level":"7","kind":"EffectMonster_Kind","type":"BeastWarrior_Type","atk":"1900","def":"1400"}\
}'
var boardCards;

var turnNumber = 0
var blueLP = 8000
var redLP = 8000

var blueDeck = [5,6,1,2,3,4]
var redDeck = [5,6,1,2,3,4]

var componentObject;
var boardObject;
var dialogText;
var dialogObject;
var infoImageObject;
var infoTextObject;

var blueHandCards = []
var blueFrontCards = new Array(5)
var blueBackCards = new Array(5)
var blueGraveCards = []
var blueDeckCards = []

var redHandCards = []
var redFrontCards = new Array(5)
var redBackCards = new Array(5)
var redGraveCards = []
var redDeckCards = []

//blue DP 1
//blue SP 2
//blue M1 3
//blue BP 4
//blue M2 5
//blue EP 6

//red DP -1
//red SP -2
//red M1 -3
//red BP -4
//red M2 -5
//red EP -6

var phase = 0;
var blueSummonEnable = true;

function sendInfoImage(isdn) {
    infoImageObject.source = "qrc:/image/info/" + boardCards[isdn]["name"] +".png";
    infoTextObject.text = boardCards[isdn]["description"]
}

function startGame() {
    //set up blue deck
    console.log("deck add...");

    boardCards = JSON.parse(array);
    for(let index in blueDeck)
    {
        var deckImage = Qt.createQmlObject('import QtQuick 2.0;Image{width:50;height:72;}', boardObject);
        deckImage.source = "qrc:/image/area/" + boardCards[blueDeck[index]]["name"] +".png";
        deckImage.x = 732+0.1*index;
        deckImage.y = 441-0.1*index;
        deckImage.z = 2;
        blueDeckCards.push(deckImage);
    }
}

function adjustHand() {
    var n = blueHandCards.length;
    var card_skip = (n > 5) ? (412 / (n - 1)) : 102;
    for(let index in blueHandCards) {
        blueHandCards[index].x = 275 + card_skip * index;
        blueHandCards[index].y = 529;
        blueHandCards[index].z = 100 + 0.1 * index;
    }
}

function findBlueFrontIndex() {
    if(blueFrontCards[0] === undefined) return 0;
    if(blueFrontCards[1] === undefined) return 1;
    if(blueFrontCards[2] === undefined) return 2;
    if(blueFrontCards[3] === undefined) return 3;
    if(blueFrontCards[4] === undefined) return 4;
    return -1;
}

function findBlueBackIndex() {
    if(blueBackCards[0] === undefined) return 0;
    if(blueBackCards[1] === undefined) return 1;
    if(blueBackCards[2] === undefined) return 2;
    if(blueBackCards[3] === undefined) return 3;
    if(blueBackCards[4] === undefined) return 4;
    return -1;
}

function findRedFrontIndex() {
    if(redFrontCards[0] === undefined) return 0;
    if(redFrontCards[1] === undefined) return 1;
    if(redFrontCards[2] === undefined) return 2;
    if(redFrontCards[3] === undefined) return 3;
    if(redFrontCards[4] === undefined) return 4;
    return -1;
}

function findRedBackIndex() {
    if(redBackCards[0] === undefined) return 0;
    if(redBackCards[1] === undefined) return 1;
    if(redBackCards[2] === undefined) return 2;
    if(redBackCards[3] === undefined) return 3;
    if(redBackCards[4] === undefined) return 4;
    return -1;
}

//发动效果 1
//特殊召唤 2
//召唤 3
//放置 4
function judgeHandCard(index) {
    var result = [];
    console.log("judgeHandCard index: " + index);
    if(phase === 3 || phase === 5)
    {
        if(blueHandCards[index].isdn === 5)
        {
            if(blueFrontCards[0] !== undefined ||
               blueFrontCards[1] !== undefined ||
               blueFrontCards[2] !== undefined ||
               blueFrontCards[3] !== undefined ||
               blueFrontCards[4] !== undefined)
            {
                result.push(2);
            }
        }
        if(blueSummonEnable === true)
        {
            result.push(3);
            result.push(4);
        }
    }

    return result;
}

//发动效果 1
//攻击表示 5
//防御表示 6
//攻击 7
function judgeFrontCard(index) {
    console.log("judgeFrontCard index: " + index);
    if(phase===3 || phase===5)
    {
        if(canEffect(blueFrontCards[index]))
        {
            return 1;
        }
        else if(canTurnAtk(blueFrontCards[index]))
        {
            return 5;
        }
        else if(canTurnDef(blueFrontCards[index]))
        {
            return 6;
        }
    }
    else if(phase===4)
    {
        if(canAttack(blueFrontCards[index]))
        {
            return 7;
        }
    }

    return 0;
}

function canEffect(obj) {
    return true;
}

function canTurnAtk(obj) {
    return true;
}

function canTurnDef(obj) {
    return true;
}

function canAttack(obj) {
    return true;
}

function hand_add(id) {
    console.log("receive hand add " + id);
    var component = Qt.createComponent("HandImage.qml");
    if (component.status === componentObject.Ready) {
        var handImage = component.createObject(boardObject);
        handImage.source = "qrc:/image/hand/" + boardCards[id]["name"] +".png";
        handImage.index = blueHandCards.length;
        handImage.isdn = Number(id);
        blueHandCards.push(handImage);
        adjustHand();
    }
}

function front_add(id) {
    var index = findBlueFrontIndex();
    if(index !== -1) {
        console.log("receive front add " + id);
        var component = Qt.createComponent("FrontImage.qml");
        if (component.status === componentObject.Ready) {
            var frontImage = component.createObject(boardObject);
            frontImage.source = "qrc:/image/hand/" + boardCards[id]["name"] +".png";
            frontImage.text = boardCards[id]["atk"] + "/" + boardCards[id]["def"];
            frontImage.x = 350+78*index;
            frontImage.y = 317;
            frontImage.z = 2;
            frontImage.index = index;
            frontImage.isdn = Number(id);
            blueFrontCards[index] = frontImage;
        }
    } else {
        console.log("can not find empty front area");
    }
}

function back_add(id) {
    var index = findBlueBackIndex();
    if(index !== -1) {
        console.log("receive back add " + id);
        var backImage = Qt.createQmlObject('import QtQuick 2.0;Image{width:50;height:72;}', boardObject);
        backImage.source = "qrc:/image/area/" + boardCards[id]["name"] +".png";
        backImage.x = 350+78*index;
        backImage.y = 424;
        backImage.z = 2;
        blueBackCards[index] = backImage;
    } else {
        console.log("can not find empty back area");
    }
}

function grave_add(id) {
    console.log("receive grave add " + boardCards[id]["name"]);
}

function deck_add(id) {
    console.log("receive deck add " + boardCards[id]["name"]);
}

function hand_remove(index) {
    console.log("receive hand remove " + index);
    var handImage = blueHandCards[index];
    handImage.destroy();
    blueHandCards.splice(index, 1);
    adjustHand();
}

function front_remove(index) {
    console.log("receive front remove " + index);
    var frontImage = blueFrontCards[index];
    frontImage.destroy();
    delete blueFrontCards[index];
}

function back_remove(index) {
    console.log("receive back remove " + index);
    var backImage = blueBackCards[index];
    backImage.destroy();
    delete blueBackCards[index];
}

function grave_remove(index) {
    console.log("receive grave remove " + index);
}

function deck_remove(index) {
    console.log("receive deck remove " + index);
}

function dialog_show(text) {
    console.log("receive dialog show " + text);
    dialogText.text = text
    dialogObject.visible = true
}
function start_game() {
    console.log("receive start game");
    startGame();
}

function go_draw_phase() {
    phase = 1;
}

function go_standby_phase() {
    phase = 2;
}

function go_main1_phase() {
    phase = 3;
}

function go_battle_phase() {
    phase = 4;
    if(blueFrontCards[0] !== undefined) blueFrontCards[0].swordVisiable = true;
    if(blueFrontCards[1] !== undefined) blueFrontCards[1].swordVisiable = true;
    if(blueFrontCards[2] !== undefined) blueFrontCards[2].swordVisiable = true;
    if(blueFrontCards[3] !== undefined) blueFrontCards[3].swordVisiable = true;
    if(blueFrontCards[4] !== undefined) blueFrontCards[4].swordVisiable = true;
}

function go_main2_phase() {
    phase = 5;
}

function go_end_phase() {
    phase = 6;
    blueSummonEnable = true;
}
