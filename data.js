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

var turnNumber = 0
var blueLP = 8000
var redLP = 8000

var blueDeck = [5,6,1,2,3,4]
var redDeck = [5,6,1,2,3,4]

var boardObject;
var boardCards;

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

var phase = {
    "draw_phase": 1,
    "standby_phase": 2,
    "main1_phase": 3,
    "battle_phase": 4,
    "main2_phase": 5,
    "end_phase": 6
};

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
