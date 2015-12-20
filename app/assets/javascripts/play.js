
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


//make core a a piece



    var yourHero;


function ClearBoard(x, y) {
    var c=document.getElementById(x);
    var ctx=c.getContext("2d");
    ctx.clearRect(0, 0, 80, 80); 
    if (y === undefined) {y = 1};
    ctx.globalAlpha = y;

};

function TargetCanvas(x, color) {
    
       var c=document.getElementById(x);
       var ctx=c.getContext("2d");

        
       if ( color == "a" ) { 
    
       ctx.globalAlpha = 0.3;
       ctx.fillStyle="#DF013A";
       ctx.fillRect(0, 0, 50, 50)  }
    
    
    
    
    document.getElementById(x).className = 'target' 
  
};


var ValidTargetSquares = ['on','occupied'];


function attack() {
        
    
    function AC(x) {

    var AttackSquares = [yourHero.pos + 1, yourHero.pos - 1, yourHero.pos + e, yourHero.pos - e]
    return AttackSquares[x];
    
    }; 
    
    var z = 0;
    
    while ( z < 4 ) {
        
        
    if (ValidTargetSquares.indexOf(document.getElementById(AC(z)).className) > -1) { TargetCanvas(AC(z),"a") } 
        

    z++ }
    

    
};

function sheath() { //make white and black core as pieces, then add them to turnstile

    var turnstile = [yourHero.id, enemyHero.id];

    function StringTransform(x) { //edit this function to find other things on board too, like cores.
                    
                    if ( x == "Joan" ) { return Joan }; 
                    
                    if ( x == "Ima" ) { return Ima }; 
                                        
                    if ( x == "Steph" ) { return Steph }; };

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
                context.stroke(); }



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
    
        document.getElementById("frontText").innerHTML = "Search canceled."; }

        else 

        { DuelMatchMaker() }


    }
  }
xmlhttp.open("GET","/cancelsearch",true);
xmlhttp.send();




 }


 