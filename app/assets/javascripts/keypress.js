

var command = "nothing";
var message;

function google(evt){ 
                     
    var key = (typeof evt.which != "undefined") ? evt.which : event.keyCode;
                     
    if (String.fromCharCode(key)=="-"){ var counter = 1; while (counter <= highestSquare) { document.getElementById(counter).style.borderWidth="0px"; counter++ } }   
                     
    if (String.fromCharCode(key)=="="){ var counter = 1; while (counter <= highestSquare) { document.getElementById(counter).style.borderWidth="1px"; counter++ } }
                     
    if (String.fromCharCode(key)=="w"){ 

                                        if ( document.getElementsByClassName("target").length > 0 ) { sheath() };

    									command = "w";

                                        commander();

    									 }
                     
    if (String.fromCharCode(key)=="a"){ 

                                        if ( document.getElementsByClassName("target").length > 0 ) { sheath() };

    									command = "a";

                                        commander();

    									 }

    if (String.fromCharCode(key)=="s"){ 

                                        if ( document.getElementsByClassName("target").length > 0 ) { sheath() }

    									command = "s";

                                        commander();

    									 }
                     
    if (String.fromCharCode(key)=="d"){ 

                                        if ( document.getElementsByClassName("target").length > 0 ) { sheath() }

    									command = "d";

                                        commander();

    									 }

    if (String.fromCharCode(key)=="1"){ 

                                        command = "1";

                                        attack();

                                         }
                     
                     
                     
}


function ShouldRedrawCore(x) {

    if ( x == "white" ) {  var whiteCoreHP;


                                var xmlhttp = new XMLHttpRequest();
                                    xmlhttp.onreadystatechange=function()

                                        {
                                if (xmlhttp.readyState==4 && xmlhttp.status==200)
                                        {

                                        var theparse;

                                        theparse = JSON.parse(xmlhttp.responseText);

                                        whiteCoreHP = theparse.whiteCoreHP;

                                        if ( whiteCore.hp !== whiteCoreHP && whiteCore !== undefined ) { whiteCore['hp'] = whiteCoreHP; place(whiteCore.pos,whiteCore) } 


                                        }
                                    }
                                    xmlhttp.open("GET","/whiteCore",true);
                                    xmlhttp.send();



    } else { var blackCoreHP;


                                var xmlhttp = new XMLHttpRequest();
                                    xmlhttp.onreadystatechange=function()

                                        {
                                if (xmlhttp.readyState==4 && xmlhttp.status==200)
                                        {

                                        var theparse;

                                        theparse = JSON.parse(xmlhttp.responseText);

                                        blackCoreHP = theparse.blackCoreHP;

                                        if ( blackCore.hp !== blackCoreHP && blackCore !== undefined ) { blackCore['hp'] = blackCoreHP; place(blackCore.pos,blackCore) } 


                                        }
                                    }
                                    xmlhttp.open("GET","/blackCore",true);
                                    xmlhttp.send();


     }


};


function Pulsate() { 


    var RepeatCommands;

    RepeatCommands=window.setInterval(function(){Timer()},1000); 


    function Timer() { 


    	
        var theparse;
   

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    { theparse = JSON.parse(xmlhttp.responseText);

    if (yourHero.pos != theparse.yourPos) { TurnCanvasOn(yourHero.pos) };
    if (enemyHero.pos != theparse.enemyPos) { TurnCanvasOn(enemyHero.pos) };

     
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

    place(yourHero.pos, yourHero);  
    if (document.getElementById(enemyHero.pos).className !== "target") { place(enemyHero.pos, enemyHero) }; 

    if (document.getElementById(whiteCore.pos).className !== "target") { ShouldRedrawCore("white") }
    if (document.getElementById(blackCore.pos).className !== "target") { ShouldRedrawCore("black") }


	        ClearUI();
            HPMPbars();

            if ( enemyHero.hp == 0 ) { alert("VICTORY!") };
            if ( yourHero.hp == 0 ) { alert("DEFEAT") };

    }
  }

xmlhttp.open("GET","/pacemaker",true);
xmlhttp.send();



}  Timer() };



function commander(x) { 

        if (command == "w") {message = "↑"};
        if (command == "s") {message = "↓"};
        if (command == "a") {message = "←"};
        if (command == "d") {message = "→"};
        if (command.slice(0,1) == "1") {message = "⚔"};


    var c=document.getElementById("UI");
        var ctx=c.getContext("2d");
                
        
            ClearUI();
            HPMPbars();
            ctx.fillStyle="white";
            ctx.font = "50px Arial";
            ctx.fillText(message,window.innerWidth / 2 + 10,85);


        var theparse;
   

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    { theparse = JSON.parse(xmlhttp.responseText);


    if (yourHero.pos != theparse.yourPos) { TurnCanvasOn(yourHero.pos) };
    if (enemyHero.pos != theparse.enemyPos) { TurnCanvasOn(enemyHero.pos) };
     
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

    place(yourHero.pos, yourHero);  
    place(enemyHero.pos, enemyHero); 


    if ( whiteCore.pos == x || blackCore.pos == x ) { 

        var c=document.getElementById(x);
        var ctx=c.getContext("2d");
        ctx.clearRect(0,0,50,50); 

            place(whiteCore.pos,whiteCore); place(blackCore.pos,blackCore); }

    
            ClearUI();
            HPMPbars();

    if ( document.getElementsByClassName("target").length > 0 ) { sheath() };


    if ( enemyHero.hp == 0 ) { alert("VICTORY!") };
    if ( yourHero.hp == 0 ) { alert("DEFEAT") };




    }
  }

    if (x !== undefined && command.indexOf(".") === -1) { command = command + "." + x }

    xmlhttp.open("POST","/command",true);
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.send("command=" + command);
}








