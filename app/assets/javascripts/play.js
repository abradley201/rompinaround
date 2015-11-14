
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


    var yourHero;



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

