.pragma library

var array = '{\
"0":{"name":"null","description":"","attribute":"No_Attribute","level":"0","kind":"No_Kind","type":"No_Type","atk":"-1","def":"-1"},\
"1":{"name":"meleecreepgood","description":"meleecreepgood","attribute":"Light_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1300","def":"1200"},\
"2":{"name":"meleecreepbad","description":"meleecreepbad","attribute":"Dark_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1300","def":"1200"},\
"3":{"name":"rangedcreepgood","description":"rangedcreepgood","attribute":"Light_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1200","def":"1300"},\
"4":{"name":"rangedcreepbad","description":"rangedcreepbad","attribute":"Dark_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1200","def":"1300"},\
"5":{"name":"zeus","description":"zeus","attribute":"Light_Attribute","level":"2","kind":"EffectMonster_Kind","type":"Spellcaster_Type","atk":"500","def":"350"},\
"6":{"name":"axe","description":"axe","attribute":"Earth_Attribute","level":"7","kind":"EffectMonster_Kind","type":"BeastWarrior_Type","atk":"1900","def":"1400"}\
}'
var boardCards;
var boardSocket;

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

var battleFromIndex;
var battleToIndex;

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
    boardCards = JSON.parse(array);
    console.log("set up blue deck...");
    for(let blueIndex in blueDeck) {
        var blueComponent = Qt.createComponent("CardItem.qml");
        if (blueComponent.status === componentObject.Ready) {
            var blueDeckImage = blueComponent.createObject(boardObject);
            blueDeckImage.state = "blueDeckArea";
            blueDeckImage.index = blueDeckCards.length;
            blueDeckImage.isdn = Number(blueDeck[blueIndex]);
            blueDeckImage.x = 732+1*blueIndex;
            blueDeckImage.y = 441-1*blueIndex;
            blueDeckImage.z = 2;
            blueDeckCards.push(blueDeckImage);
        }
    }
    console.log("set up red deck...");
    for(let redIndex in redDeck) {
        var redComponent = Qt.createComponent("CardItem.qml");
        if (redComponent.status === componentObject.Ready) {
            var redDeckImage = redComponent.createObject(boardObject);
            redDeckImage.state = "redDeckArea";
            redDeckImage.index = redDeckCards.length;
            redDeckImage.isdn = Number(redDeck[redIndex]);
            redDeckImage.x = 270-1*redIndex;
            redDeckImage.y = 105-1*redIndex;
            redDeckImage.z = 2;
            redDeckCards.push(redDeckImage);
        }
    }
}

function adjustBlueHand() {
    var n = blueHandCards.length;
    var card_skip = (n > 5) ? (412 / (n - 1)) : 102;
    for(let index in blueHandCards) {
        blueHandCards[index].x = 275 + card_skip * index;
        blueHandCards[index].y = 529;
        blueHandCards[index].z = 100 + 0.1 * index;
        blueHandCards[index].index = index;
    }
}

function adjustRedHand() {
    var n = redHandCards.length;
    var card_skip = (n > 5) ? (412 / (n - 1)) : 102;
    for(let index in redHandCards) {
        redHandCards[index].x = 275 + 408 - card_skip * index;
        redHandCards[index].y = -71;
        redHandCards[index].z = 100 + 0.1 * index;
        redHandCards[index].index = index;
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
    if(phase === 3 || phase === 5) {
        if(blueHandCards[index].isdn === 5) {
            if(blueFrontCards[0] !== undefined ||
                    blueFrontCards[1] !== undefined ||
                    blueFrontCards[2] !== undefined ||
                    blueFrontCards[3] !== undefined ||
                    blueFrontCards[4] !== undefined) {
                result.push(2);
            }
        } if(blueSummonEnable === true) {
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
    var result = [];
    console.log("judgeFrontCard index: " + index);
    if(phase===3 || phase===5) {
        if(canEffect(blueFrontCards[index])) {
            result.push(1);
        } else if(canTurnAtk(blueFrontCards[index])) {
            result.push(5);
        } else if(canTurnDef(blueFrontCards[index])) {
            result.push(6);
        }
    }
    else if(phase===4) {
        if(canAttack(blueFrontCards[index])) {
            result.push(7);
        }
    }

    return result;
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

function blue_draw_card() {
    console.log("receive blue draw card");
    if(blueDeckCards.length === 0) {
        console.log("you lose");
    } else {
        var handImage = blueDeckCards.pop();
        blueHandCards.push(handImage);
        adjustBlueHand();
        handImage.state = "blueHandArea";
        boardSocket.sendTextMessage("draw#"+handImage.isdn);
    }
}

function red_draw_card() {
    console.log("receive red draw card");
    if(redDeckCards.length === 0) {
        console.log("you win");
    } else {
        var handImage = redDeckCards.pop();
        redHandCards.push(handImage);
        adjustRedHand();
        handImage.state = "redHandArea";
    }
}

function handleMessage(command, parameter) {
    if(command === "draw") {
        red_draw_card();
    }
}

function redVerticalFaceupFront(index) {
    console.log("receive red vertical faceup front " + index);
    var place = findRedFrontIndex();
    var frontImage = redHandCards.splice(index, 1)[0];
    redFrontCards[place] = frontImage;
    frontImage.index = place;
    frontImage.z = 2;
    frontImage.state = "redVerticalFaceupFront";
}

function redHorizontalFacedownFront(index) {
    console.log("red horizontal facedown front " + index);
    var place = findRedFrontIndex();
    var frontImage = redHandCards.splice(index, 1)[0];
    redFrontCards[place] = frontImage;
    frontImage.index = place;
    frontImage.z = 2;
    frontImage.state = "redHorizontalFacedownFront";
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
    for(var index = 0; index<5; index++) {
        if(blueFrontCards[index] !== undefined) blueFrontCards[index].state = "blueBattle"
    }

//    if(blueFrontCards[0] !== undefined) blueFrontCards[0].stateswordVisiable = true;
//    if(blueFrontCards[1] !== undefined) blueFrontCards[1].swordVisiable = true;
//    if(blueFrontCards[2] !== undefined) blueFrontCards[2].swordVisiable = true;
//    if(blueFrontCards[3] !== undefined) blueFrontCards[3].swordVisiable = true;
//    if(blueFrontCards[4] !== undefined) blueFrontCards[4].swordVisiable = true;
}

function go_main2_phase() {
    phase = 5;
}

function go_end_phase() {
    phase = 6;
    blueSummonEnable = true;
}
