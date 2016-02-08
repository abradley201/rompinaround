
var piece = function(id, ppic, bpic, hp, maxhp, shield, mp, maxmp, pos, kills, deaths, status, exp, allies) {
    
    this.id = id;
    
    this.ppic = ppic; 
    
    this.bpic = bpic; 
    
    this.hp = hp;
    
    this.maxhp = maxhp;
    
    this.shield = shield;
        
    this.mp = mp;
    
    this.maxmp = maxmp;
    
    this.pos = pos;
    
    this.kills = kills;
    
    this.deaths = deaths;
    
    this.status = status;
            
    this.exp = exp;

    this.allies = allies;
 
};


    Joan = new piece("Joan", "JoanP1", "JoanB1", 20, 20, 0, 10, 10, 0, 0, 0, null, 0, null);

    Ima = new piece("Ima", "ImaP1", "ImaB1", 20, 20, 0, 10, 10, 0, 0, 0, null, 0, null);

    Steph = new piece("Steph", "StephP1", "StephB1", 20, 20, 0, 10, 10, 0, 0, 0, null, 0, null);



var whiteCore;
var blackCore;

function GeneratePiece(x, y) {

    if ( x == "whiteCore" ) { 

                              var whiteCoreHP;




                                var xmlhttp = new XMLHttpRequest();
                                    xmlhttp.onreadystatechange=function()

                                        {
                                if (xmlhttp.readyState==4 && xmlhttp.status==200)
                                        {

                                        var theparse;

                                        theparse = JSON.parse(xmlhttp.responseText);

                                        whiteCoreHP = theparse.whiteCoreHP;

                                        whiteCore = new piece("whiteCore", "whiteCore", "whiteCore", whiteCoreHP, 500, 0, 0, 1, y, 0, 0, null, 0, null);


                                        place(whiteCore.pos, whiteCore);


                                        }
                                    }
                                    xmlhttp.open("GET","/pacemaker",true);
                                    xmlhttp.send();





                        }


    if ( x == "blackCore" ) { 

                              var blackCoreHP;




                                var xmlhttp = new XMLHttpRequest();
                                    xmlhttp.onreadystatechange=function()

                                        {
                                if (xmlhttp.readyState==4 && xmlhttp.status==200)
                                        {

                                        var theparse;

                                        theparse = JSON.parse(xmlhttp.responseText);

                                        blackCoreHP = theparse.blackCoreHP;

                                        blackCore = new piece("blackCore", "blackCore", "blackCore", blackCoreHP, 500, 0, 0, 1, y, 0, 0, null, 0, null);


                                        place(blackCore.pos, blackCore);


                                        }
                                    }
                                    xmlhttp.open("GET","/pacemaker",true);
                                    xmlhttp.send();











    }


};



    var yourHero;


function ClearBoard(x, y) {
    var c=document.getElementById(x);
    var ctx=c.getContext("2d");
    ctx.clearRect(0, 0, 80, 80); 
    if (y === undefined) {y = 1};
    ctx.globalAlpha = y;

};

var TargetColor;

function TargetCanvas(x, color) {
    
       var c=document.getElementById(x);
       var ctx=c.getContext("2d");

        
       if ( color == "a" ) {

       TargetColor = "a"; 
    
       ctx.globalAlpha = 0.3;
       ctx.fillStyle="#DF013A";
       ctx.fillRect(0, 0, 50, 50)  };


       if ( color == "b" ) {

       TargetColor = "b"; 
    
       ctx.globalAlpha = 0.3;
       ctx.fillStyle="#FE2EC8";
       ctx.fillRect(0, 0, 50, 50)  }; 

    
        if ( color == "c" ) {

       TargetColor = "c"; 
    
       ctx.globalAlpha = 0.3;
       ctx.fillStyle="#FF8000";
       ctx.fillRect(0, 0, 50, 50)  };
    
    
    document.getElementById(x).className = 'target'; 
  
};


var ValidTargetSquares = ['on','occupied'];


function crossbow() { if ( document.getElementsByClassName("target").length > 0 && TargetColor != "b" ) { sheath() };

    var TargetArray = [yourHero.pos + 3 * e, yourHero.pos - 3 * e, yourHero.pos + 3, yourHero.pos - 3, yourHero.pos + 1 + 2 * e, yourHero.pos + 2 + e, yourHero.pos + 2 - e, yourHero.pos + 1 - 2 * e, yourHero.pos - 1 - 2 * e, yourHero.pos - 2 - e, yourHero.pos - 2 + e, yourHero.pos - 1 + 2 * e];

    var x = 0;

    if ( Row(yourHero.pos).indexOf(yourHero.pos + 3) == -1 ) { TargetArray.splice(TargetArray.indexOf(yourHero.pos + 3), 1) };

    if ( Row(yourHero.pos).indexOf(yourHero.pos - 3) == -1 ) { TargetArray.splice(TargetArray.indexOf(yourHero.pos - 3), 1) };

    while ( x < TargetArray.length ) { if (ValidTargetSquares.indexOf(document.getElementById(TargetArray[x]).className) > -1) { TargetCanvas(TargetArray[x],"b") } x++ };

};

function holyexplosion() { if ( document.getElementsByClassName("target").length > 0 && TargetColor != "c" ) { sheath() };

    var x = 0;

    var y = 0;

    var row = Row(yourHero.pos);

    var clm = Clm(yourHero.pos);

    while ( x < row.length ) { if (ValidTargetSquares.indexOf(document.getElementById(row[x]).className) > -1 && row[x] != yourHero.pos) { TargetCanvas(row[x],"c") }; x++ };

    while ( y < clm.length ) { if (ValidTargetSquares.indexOf(document.getElementById(clm[y]).className) > -1 && clm[y] != yourHero.pos) { TargetCanvas(clm[y],"c") }; y++ };

};

function attack() { if ( document.getElementsByClassName("target").length > 0 && TargetColor != "a" ) { sheath() };
        
    
    function AC(x) {

    var AttackSquares = [yourHero.pos + 1, yourHero.pos - 1, yourHero.pos + e, yourHero.pos - e]
    return AttackSquares[x];
    
    }; 
    
    var z = 0;
    
    while ( z < 4 ) {
        
        
    if (ValidTargetSquares.indexOf(document.getElementById(AC(z)).className) > -1) { TargetCanvas(AC(z),"a") } 
        

    z++ }
    

    
};

function sheath() { SpecialTapped = false;

    var turnstile = [yourHero.id, enemyHero.id, whiteCore.id, blackCore.id];

    function StringTransform(x) { //edit this function to find other things on board too, like pawns.
                    
                    if ( x == "Joan" ) { return Joan }; 
                    
                    if ( x == "Ima" ) { return Ima }; 
                                        
                    if ( x == "Steph" ) { return Steph }; 

                    if ( x == "whiteCore" ) { return whiteCore }; 
                                        
                    if ( x == "blackCore" ) { return blackCore };



                };

    function findpiece(x) { for (t = 0; t < turnstile.length; t++) { if (StringTransform(turnstile[t]).pos == x) { return StringTransform(turnstile[t]) } } }; 


var PieceinQ;
     
    if ( document.getElementsByClassName("target").length > 0 ) {
    
   for (z = 0; z < 4; z++) {    

    for (y = 0; y < 4; y++) {

      for (x = 0; x < 4; x++) {

        for (n = 0; n < document.getElementsByClassName("target").length; n++) {
            
          if (findpiece(Number(document.getElementsByClassName("target")[n].id)) !== undefined) {
              
              
              
              //check and draw for any statuses here
              
              
              
              
              PieceinQ = findpiece(Number(document.getElementsByClassName("target")[n].id));


    
              
                var c=document.getElementById(PieceinQ.pos);
                var ctx=c.getContext("2d");
                var img=document.getElementById(PieceinQ.bpic);
                ctx.globalAlpha = 1.0;
                if ( PieceinQ.id == "whiteCore" || PieceinQ.id == "blackCore" ) { ctx.clearRect(0,0,50,50); }
                ctx.drawImage(img,0,0);
                ctx.beginPath();
                ctx.strokeStyle="#FF0000";
                ctx.lineWidth=2;
                ctx.moveTo(1,50);
                ctx.lineTo(1,50 - (50 * (PieceinQ.hp / PieceinQ.maxhp)));
                ctx.stroke();
                                      
                ctx.beginPath();
                ctx.strokeStyle="#3366FF";
                ctx.lineWidth=2;
                ctx.moveTo(49,50);
                ctx.lineTo(49,50 - (50 * (PieceinQ.mp / PieceinQ.maxmp)));
                ctx.stroke();
              
              
              OccupyCanvas(PieceinQ.pos);
              
              
              
          } else {
        
          TurnCanvasOn(Number(document.getElementsByClassName("target")[n].id));

        }       }      }      }   };
          
    
    
} };



function OccupyCanvas(x) {
      document.getElementById(x).className = 'occupied';
};

function TurnCanvasOff(x, y) {  
    if (y == 0) {
      document.getElementById(x).className = 'pit' };
    if (y == 1) {
      document.getElementById(x).className = 'wall' };
};

function TurnCanvasOn(x) {
      ClearBoard(x);
      document.getElementById(x).className = 'on';
};


function place(x, person) {
    person.pos = x;
    var c=document.getElementById(x);
    var ctx=c.getContext("2d");
    var img=document.getElementById(person.bpic);
    if (person.id == "whiteCore" || person.id == "blackCore") { ctx.clearRect(0,0,50,50); }
    ctx.globalAlpha = 1.0;
    ctx.drawImage(img,0,0);
    ctx.beginPath();
    ctx.strokeStyle="#FF0000";
    ctx.lineWidth=2;
    ctx.moveTo(1,50);
    ctx.lineTo(1,50 - (50 * (person.hp/person.maxhp)));
    ctx.stroke();
                                      
    ctx.beginPath();
    ctx.strokeStyle="#3366FF";
    ctx.lineWidth=2;
    ctx.moveTo(49,50);
    ctx.lineTo(49,50 - (50 * (person.mp/person.maxmp)));
    ctx.stroke();
    
    OccupyCanvas(x); 
    
                                  };


var SelectedHeroNumber;

function DrawPicture(x, y, a, b) {
    
    var c=document.getElementById(x);
    var ctx=c.getContext("2d");
    var img=document.getElementById(y);
    if (a === undefined) { a = 0 };
    if (b === undefined) { b = 0 };
    ctx.drawImage(img,a,b); }

function SelectSquare(p) { if ( IsSearching == true ) { return }; var HeroArray = ["filler", Joan, Ima, Steph]

                if (SelectedHeroNumber !== undefined) {

                    var SelectedHeroNumberArray = ["filler","JoanP1","ImaP1","StephP1"];

                    var canvas = document.getElementById('SelectPic'+SelectedHeroNumber);
                    var context = canvas.getContext('2d');
                    context.clearRect(0,0,150,150);
                    DrawPicture('SelectPic'+SelectedHeroNumber,SelectedHeroNumberArray[SelectedHeroNumber]);

                }

                yourHero = HeroArray[p];

                SelectedHeroNumber = p;
                var which = 'SelectPic'+p;
                var canvas = document.getElementById(which);
                var context = canvas.getContext('2d');
                context.strokeStyle="blue";
                context.lineWidth = 6;
                context.rect(0,0,150,150);
                context.stroke(); 

                var TipArray = ["Tip: Stay on your respawn square to regain health & mana rapidly.","Tip: Each time you die, your respawn timer increases by 3 seconds.","Tip: Movement has a cooldown of 1 square per second.","Tip: You can't move onto your enemy's respawn square.","Tip: Specials that target squares can be canceled by tapping your hero again."];
                var Tip = Math.round(Math.random() * (TipArray.length - 1));

                if ( p == 1 ) { var c = document.getElementById("HeroInfo");
                var ctx = c.getContext('2d');
                ctx.clearRect(0,0,800,300);
                ctx.font="25px Georgia";
                ctx.fillStyle="white";
                ctx.fillText("Joan: Powerful holy warrior.",50,50);
                ctx.fillText("Special ability Crusader boosts her movement speed.",50,100);
                ctx.fillText("Tap repeatedly on a distant square to charge at your enemies.",50,150);
                ctx.fillText("--Ω--",380,200);
                ctx.font="20px Georgia";
                ctx.fillText(TipArray[Tip],50,250);



                };

                if ( p == 2 ) { var c = document.getElementById("HeroInfo");
                var ctx = c.getContext('2d');
                ctx.clearRect(0,0,800,300);
                ctx.font="25px Georgia";
                ctx.fillStyle="white";
                ctx.fillText("Ima: Renegade rogue.",50,50);
                ctx.fillText("Special ability is a crossbow with a range of 3.",50,100);
                ctx.fillText("Click a targeted square to shoot a powerful bolt.",50,150);
                ctx.fillText("--Ω--",380,200);
                ctx.font="20px Georgia";
                ctx.fillText(TipArray[Tip],50,250);

                };

                if ( p == 3 ) { var c = document.getElementById("HeroInfo");
                var ctx = c.getContext('2d');
                ctx.clearRect(0,0,800,300);
                ctx.font="25px Georgia";
                ctx.fillStyle="white";
                ctx.fillText("Steph: Loose cannon mage.",50,50);
                ctx.fillText("Special ability targets all squares in her column & row.",50,100);
                ctx.fillText("Click a targeted square to scorch an enemy with fire.",50,150);
                ctx.fillText("--Ω--",380,200);
                ctx.font="20px Georgia";
                ctx.fillText(TipArray[Tip],50,250);

                };



            };



var IsSearching = false;
var GameFound = false;

function GoToGame(x) { 


        var locality = "/board";
        locality = locality.concat(String(x));

                window.location.href = locality;

                };


function DuelMatchMaker() {


    if ( IsSearching == true ) { return }; 

    if ( yourHero === undefined ) { document.getElementById("frontText").innerHTML = "please select a hero."; return }

    IsSearching = true;

    var RepeatSearch;

    RepeatSearch=window.setInterval(function(){Timer()},2000); 



    function Timer() { if (IsSearching == false) { clearInterval(RepeatSearch); 

                                                        if ( GameFound == false ) { CancelDuelSearch() } 

                                                        else { GoToGame(1) }

                                                        return }; 



        console.log("you are searching for a duel.");

       
   

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    
        if ( xmlhttp.responseText == '{"account":false}' ) { if ( IsSearching == true ) {
        document.getElementById("frontText").innerHTML = "searching... <button type='button' onclick='CancelDuelSearch()'>Cancel Search</button>"; }

   



    } else { document.getElementById("frontText").innerHTML = "Match found!"; IsSearching = false; GameFound = true;









                    }


    }
  }
xmlhttp.open("POST","/makematch",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("character=" + yourHero.id);



}  Timer() };


function CancelDuelSearch() { 



    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {

        if ( xmlhttp.responseText == '{"account":true}' ) {

        IsSearching = false;
    
        document.getElementById("frontText").innerHTML = "Search canceled.";

        setTimeout(function(){ ShowRecord() }, 2000);

         }

        else 

        { DuelMatchMaker() }


    }
  }
xmlhttp.open("GET","/cancelsearch",true);
xmlhttp.send();


 };



function LeaveGame() {

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function() {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {

    theparse = JSON.parse(xmlhttp.responseText);

    if ( theparse.gameOver == "true" || theparse.gameOver == "nogame" ) { location.reload() };

    } };

xmlhttp.open("GET","/endgame",true);
xmlhttp.send();

}


 