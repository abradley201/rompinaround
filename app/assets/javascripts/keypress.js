

var command = "nothing";
var target = "none";

//change to do requests immediately at key press. also detect if nothing is done
//then update once every second

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



function SendCommand() {


    var RepeatCommands;

    RepeatCommands=window.setInterval(function(){Timer()},1000); 


    function Timer() { 

    	var YouMoving = false;
    	var EnemyMoving = false;
   

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {

    if (yourHero.pos != JSON.parse(xmlhttp.responseText).yourPos) { YouMoving = true; TurnCanvasOn(yourHero.pos) };
    if (enemyHero.pos != JSON.parse(xmlhttp.responseText).enemyPos) { EnemyMoving = true; TurnCanvasOn(enemyHero.pos) };

     
        yourHero['hp'] = Number(JSON.parse(xmlhttp.responseText).yourHp);
        yourHero['maxhp'] = Number(JSON.parse(xmlhttp.responseText).yourMaxhp);
        yourHero['shield'] = Number(JSON.parse(xmlhttp.responseText).yourShield);
        yourHero['mp'] = Number(JSON.parse(xmlhttp.responseText).yourMp);
        yourHero['maxmp'] = Number(JSON.parse(xmlhttp.responseText).yourMaxmp);
        yourHero['pos'] = Number(JSON.parse(xmlhttp.responseText).yourPos);
        yourHero['kills'] = Number(JSON.parse(xmlhttp.responseText).yourKills);
        yourHero['deaths'] = Number(JSON.parse(xmlhttp.responseText).yourDeaths);
        yourHero['status'] = JSON.parse(xmlhttp.responseText).yourStatus;
        yourHero['exp'] = Number(JSON.parse(xmlhttp.responseText).yourExp);
        yourHero['allies'] = JSON.parse(xmlhttp.responseText).yourAllies;
        yourHero['action'] = JSON.parse(xmlhttp.responseText).yourAction;

        enemyHero['hp'] = Number(JSON.parse(xmlhttp.responseText).enemyHp);
        enemyHero['maxhp'] = Number(JSON.parse(xmlhttp.responseText).enemyMaxhp);
        enemyHero['shield'] = Number(JSON.parse(xmlhttp.responseText).enemyShield);
        enemyHero['mp'] = Number(JSON.parse(xmlhttp.responseText).enemyMp);
        enemyHero['maxmp'] = Number(JSON.parse(xmlhttp.responseText).enemyMaxmp);
        enemyHero['pos'] = Number(JSON.parse(xmlhttp.responseText).enemyPos);
        enemyHero['kills'] = Number(JSON.parse(xmlhttp.responseText).enemyKills);
        enemyHero['deaths'] = Number(JSON.parse(xmlhttp.responseText).enemyDeaths);
        enemyHero['status'] = JSON.parse(xmlhttp.responseText).enemyStatus;
        enemyHero['exp'] = Number(JSON.parse(xmlhttp.responseText).enemyExp);
        enemyHero['allies'] = JSON.parse(xmlhttp.responseText).enemyAllies;
        enemyHero['action'] = JSON.parse(xmlhttp.responseText).enemyAction;

    if ( YouMoving == true ) { place(yourHero.pos, yourHero) }
    if ( EnemyMoving == true ) { place(enemyHero.pos, enemyHero) }

    command = "nothing";
	

    }
  }

xmlhttp.open("POST","/pacemaker",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("command=" + command + "&" + "target=" + target);



}  Timer() };




