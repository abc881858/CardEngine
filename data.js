.pragma library

var array = '{\
"0":{"name":"null","description":"","attribute":"No_Attribute","level":"0","kind":"No_Kind","type":"No_Type","atk":"-1","def":"-1"},\
"1":{"name":"meleecreepgood","description":"【天使族】\\n我一般见谁不顺眼就打谁的","attribute":"Light_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1300","def":"1200"},\
"2":{"name":"meleecreepbad","description":"【恶魔族】\\n我最大的梦想就是把夜魇的枯树换成天辉的","attribute":"Dark_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1300","def":"1200"},\
"3":{"name":"rangedcreepgood","description":"【天使族】\\n我们踏过青草与玫瑰，走向血河以北，用呐喊搭建虚构的耀武扬威。我们明白没有凯旋而归，明白死亡总是无声而纯粹。我们拔出刀剑，今夜再不能饮醉，天辉万岁","attribute":"Light_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1200","def":"1300"},\
"4":{"name":"rangedcreepbad","description":"【恶魔族】\\n英雄之所以为英雄，是因为他们沐浴在圣光中诞生。他们可以拿起武器，穿上盔甲，大杀四方。即便死了，他们也可以在圣泉中重生。而我们只不过是没有灵魂的躯壳罢了","attribute":"Dark_Attribute","level":"3","kind":"NormalMonster_Kind","type":"Warrior_Type","atk":"1200","def":"1300"},\
"5":{"name":"zeus","description":"【魔法师族·效果】\\n①当自己场上有其他怪兽时，这张卡可以从手牌特殊召唤。\\n②一回合一次，丢弃一张手牌发动，破坏对方场上一只怪兽\\n③一回合一次，丢弃两张手牌发动，对方场上怪兽守备力降低1000点，怪兽守备力降至0的场合破坏怪兽。若这张卡装备了[阿哈利姆神杖]则改为降低2000点守备力。","attribute":"Light_Attribute","level":"2","kind":"EffectMonster_Kind","type":"Spellcaster_Type","atk":"500","def":"350"},\
"6":{"name":"axe","description":"【兽战士族·效果】\\n①对方进入战斗流程时，这张卡可以变为表侧守备表示且守备力上升1500，强制对方所有怪兽变为表侧攻击表示[翻转效果不发动]且必须对这张卡发动攻击。\\n②这张卡受到怪兽攻击时，降低对方500攻·防。\\n③一回合一次，丢弃一张手牌，选择对方场上一只表侧表示的怪兽，若该怪兽守备力大于1000则降低700点防御力，否则破坏此怪兽并抽一张卡，若成功破坏了怪兽，此效果可以再次使用。若装备了[阿哈利姆神杖]则改为大于1500。","attribute":"Earth_Attribute","level":"7","kind":"EffectMonster_Kind","type":"BeastWarrior_Type","atk":"1900","def":"1400"},\
"7":{"name":"ogremagi","description":"【兽族·效果】\\n①自己场上没有怪兽而对方场上有怪兽时，这张卡可以从手牌特殊召唤。\\n②一回合一次，指定对方场上一只怪兽攻·守下降700，之后丢三枚硬币，每有一枚为正则额外下降700点攻·守，若因此效果降至0则破坏该怪兽。若这张卡装备了[阿哈利姆神杖]则此效果一回合可以使用两次。","attribute":"Fire_Attribute","level":"4","kind":"EffectMonster_Kind","type":"Beast_Type","atk":"1400","def":"2000"},\
"8":{"name":"meepo","description":"【兽族·效果】\\n①把自己1张手牌送去墓地才能发动。从手牌·卡组把1只[米波]特殊召唤。[米波]从场上离开的场合这张卡破坏。","attribute":"Earth_Attribute","level":"3","kind":"EffectMonster_Kind","type":"Beast_Type","atk":"1300","def":"1300"}\
}'
var boardCards;
//var boardSocket;

var turnNumber = 0
var blueLP = 8000
var redLP = 8000

var blueDeck = [1,2,3,4,5,6,7,8]
var redDeck = [1,2,3,4,5,6,7,8]

var componentObject;
var boardObject;
var boardDialog;
var infoImageObject;
var infoTextObject;
var blueSwordAnimationObject;
var redSwordAnimationObject;

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

var battleFromIndex = -1;
var battleToIndex = -1;

var blueSword;
var redSword;

var oldSelectCard;

var blueTributeSummon = false;
var blueChainCard = false
var blueSummonEnable = true;

var tributeNumber = 0;
var tributeCard;

function sendInfoImage(isdn) {
    infoImageObject.source = "qrc:/image/info/" + boardCards[isdn]["name"] +".png";
    infoTextObject.text = boardCards[isdn]["description"]
}

function start_game() {
    console.log("receive start game");
    boardCards = JSON.parse(array);
    console.log("set up blue deck...");
    for(let blueIndex in blueDeck) {
        var blueComponent = Qt.createComponent("CardItem.qml");
        if (blueComponent.status === componentObject.Ready) {
            var blueDeckImage = blueComponent.createObject(boardObject);
            blueDeckImage.state = "blueDeckArea";
            blueDeckImage.index = blueDeckCards.length;
            blueDeckImage.isdn = Number(blueDeck[blueIndex]);
            blueDeckImage.x = 1318+1*1.8*blueIndex;
            blueDeckImage.y = 794-1*1.8*blueIndex;
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
            redDeckImage.x = 486-1*1.8*redIndex;
            redDeckImage.y = 189-1*1.8*redIndex;
            redDeckImage.z = 2;
            redDeckCards.push(redDeckImage);
        }
    }

    boardObject.state =  "blueDrawPhase";
}

function adjustBlueHand() {
    var n = blueHandCards.length;
    var card_skip = (n > 5) ? (742 / (n - 1)) : 184;
    for(let index in blueHandCards) {
        blueHandCards[index].x = 495 + card_skip * index;
        blueHandCards[index].y = 952;
        blueHandCards[index].z = 180 + 0.1*1.8 * index;
        blueHandCards[index].index = index;
    }
}

function adjustRedHand() {
    var n = redHandCards.length;
    var card_skip = (n > 5) ? (742 / (n - 1)) : 184;
    for(let index in redHandCards) {
        redHandCards[index].x = 495 + 734 - card_skip * index;
        redHandCards[index].y = -128;
        redHandCards[index].z = 180 + 0.1*1.8 * index;
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

function getBlueFrontMonsterNumber() {
    var num = 0;
    if(blueFrontCards[0] !== undefined) ++num;
    if(blueFrontCards[1] !== undefined) ++num;
    if(blueFrontCards[2] !== undefined) ++num;
    if(blueFrontCards[3] !== undefined) ++num;
    if(blueFrontCards[4] !== undefined) ++num;
    return num;
}

function getRedFrontMonsterNumber() {
    var num = 0;
    if(redFrontCards[0] !== undefined) ++num;
    if(redFrontCards[1] !== undefined) ++num;
    if(redFrontCards[2] !== undefined) ++num;
    if(redFrontCards[3] !== undefined) ++num;
    if(redFrontCards[4] !== undefined) ++num;
    return num;
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

function blueFrontMatchActiveCondition(index) {
    if(blueFrontCards[index] !== undefined) { if(blueFrontCards[index].isdn === 6) { return true } }
    return false;
}

function findBlueFrontMatchActiveCondition() {
    if(blueFrontCards[0] !== undefined) { if(blueFrontMatchActiveCondition(0)) { return true; } }
    if(blueFrontCards[1] !== undefined) { if(blueFrontMatchActiveCondition(1)) { return true; } }
    if(blueFrontCards[2] !== undefined) { if(blueFrontMatchActiveCondition(2)) { return true; } }
    if(blueFrontCards[3] !== undefined) { if(blueFrontMatchActiveCondition(3)) { return true; } }
    if(blueFrontCards[4] !== undefined) { if(blueFrontMatchActiveCondition(4)) { return true; } }
    return false;
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
//        boardSocket.sendTextMessage("draw#"+handImage.isdn);
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

function showRedSword() {
    for(var index = 0; index<5; index++) {
        if(redFrontCards[index] !== undefined) {
            if(redFrontCards[index].state === "redVerticalFaceupFront") {
                redFrontCards[index].swordRotation = 180;
                redFrontCards[index].swordVisible = true;
            }
        }
    }
}
