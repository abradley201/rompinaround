

var command = "nothing";
var target = "none";

//game updates only when both players have inputted a move, which is stored in database under action

function google(evt){ 
                     
    var key = (typeof evt.which != "undefined") ? evt.which : event.keyCode;
                     
    if (String.fromCharCode(key)=="-"){ var counter = 1; while (counter <= highestSquare) { document.getElementById(counter).style.borderWidth="0px"; counter++ } }   
                     
    if (String.fromCharCode(key)=="="){ var counter = 1; while (counter <= highestSquare) { document.getElementById(counter).style.borderWidth="1px"; counter++ } }
                     
    if (String.fromCharCode(key)=="w"){ 

    									command = "w";

    									 }
                     
    if (String.fromCharCode(key)=="a"){ 

    									command = "a";

    									 }

    if (String.fromCharCode(key)=="s"){ 

    									command = "s";

    									 }
                     
    if (String.fromCharCode(key)=="d"){ 

    									command = "d";

    									 }
                                       
                     
                     
                     
}



function SendCommand() { PaceCoolDown();


    var RepeatCommands;

    RepeatCommands=window.setInterval(function(){Timer()},1000); 


    function Timer() { if (counter != 0) { return };

    	var YouMoving = false;
    	var EnemyMoving = false;
        var theparse;
   

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    { theparse = JSON.parse(xmlhttp.responseText);

    if (yourHero.pos != theparse.yourPos) { YouMoving = true; TurnCanvasOn(yourHero.pos) };
    if (enemyHero.pos != theparse.enemyPos) { EnemyMoving = true; TurnCanvasOn(enemyHero.pos) };

     
        yourHero['hp'] = Number(theparse.yourHp);
        yourHero['maxhp'] = Number(theparse.yourMaxhp);
        yourHero['shield'] = Number(theparse.yourShield);
        yourHero['mp'] = Number(theparse.yourMp);
        yourHero['maxmp'] = Number(theparse.yourMaxmp);
        yourHero['pos'] = Number(theparse.yourPos);
        yourHero['kills'] = Number(theparse.yourKills);
        yourHero['deaths'] = Number(theparse.yourDeaths);
        yourHero['status'] = theparse.yourStatus;
        yourHero['exp'] = Number(theparse.yourExp);
        yourHero['allies'] = theparse.yourAllies;
        yourHero['action'] = theparse.yourAction;

        enemyHero['hp'] = Number(theparse.enemyHp);
        enemyHero['maxhp'] = Number(theparse.enemyMaxhp);
        enemyHero['shield'] = Number(theparse.enemyShield);
        enemyHero['mp'] = Number(theparse.enemyMp);
        enemyHero['maxmp'] = Number(theparse.enemyMaxmp);
        enemyHero['pos'] = Number(theparse.enemyPos);
        enemyHero['kills'] = Number(theparse.enemyKills);
        enemyHero['deaths'] = Number(theparse.enemyDeaths);
        enemyHero['status'] = theparse.enemyStatus;
        enemyHero['exp'] = Number(theparse.enemyExp);
        enemyHero['allies'] = theparse.enemyAllies;
        enemyHero['action'] = theparse.enemyAction;

    if ( YouMoving == true ) { place(yourHero.pos, yourHero) }
    if ( EnemyMoving == true ) { place(enemyHero.pos, enemyHero) }

    command = "nothing";
	

    }
  }

xmlhttp.open("POST","/pacemaker",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("command=" + command + "&" + "target=" + target);



}  Timer() };




