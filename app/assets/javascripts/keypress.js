


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

    if (String.fromCharCode(key)=="q"){ if ( yourHero.hp > 0 && IsGameOver == false ) {

                                        command = "1";

                                        attack(); }

                                         }

    if (String.fromCharCode(key)=="e"){ if ( yourHero.hp > 0 && IsGameOver == false ) {

                                        command = "e";

                                        if (yourHero.id == "Joan") { commander(); }

                                        if (yourHero.id == "Ima") { crossbow(); }

                                        if (yourHero.id == "Steph") { holyexplosion(); }

                                         }

                                         }
                                    
                     
};

var IsGameOver = false;


function Pulsate() { 


    var RepeatCommands;

    RepeatCommands=window.setInterval(function(){Timer()},1000); 


    function Timer() { 


    	
        var theparse; var whiteCoreHP; var blackCoreHP; var whiteRespawnSquare; var blackRespawnSquare;
   

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    { theparse = JSON.parse(xmlhttp.responseText);

        if ( theparse.gameOver == "true" ) { return };


    if (yourHero.pos != theparse.yourPos) { TurnCanvasOn(yourHero.pos) };
    if (enemyHero.pos != theparse.enemyPos) { TurnCanvasOn(enemyHero.pos) };


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


    place(yourHero.pos, yourHero);
    if (yourHero.id != enemyHero.id){  
    if (document.getElementById(enemyHero.pos).className == "target") { place(enemyHero.pos, enemyHero); TargetCanvas(enemyHero.pos,TargetColor) } else { place(enemyHero.pos, enemyHero) } };

    whiteCoreHP = theparse.whiteCoreHP;
    blackCoreHP = theparse.blackCoreHP;

    whiteRespawnSquare = theparse.whiteRespawnSquare;
    blackRespawnSquare = theparse.blackRespawnSquare;

    if ( whiteRespawnSquare != 0 && document.getElementById(whiteRespawnSquare).className == "on" ) {

        var c=document.getElementById(whiteRespawnSquare);
        var ctx=c.getContext("2d");
        ctx.fillStyle="white";
        ctx.fillRect(0,0,50,50);

     };

    if ( blackRespawnSquare != 0 && document.getElementById(blackRespawnSquare).className == "on" ) {

        var c=document.getElementById(blackRespawnSquare);
        var ctx=c.getContext("2d");
        ctx.fillStyle="black";
        ctx.fillRect(0,0,50,50);

     };

    if (document.getElementById(whiteCore.pos).className == "target") { if ( whiteCore.hp !== whiteCoreHP && whiteCore !== undefined ) { whiteCore['hp'] = whiteCoreHP; place(whiteCore.pos,whiteCore); TargetCanvas(whiteCore.pos,TargetColor) } } else { if ( whiteCore.hp !== whiteCoreHP && whiteCore !== undefined ) { whiteCore['hp'] = whiteCoreHP; place(whiteCore.pos,whiteCore) } }
    if (document.getElementById(blackCore.pos).className == "target") { if ( blackCore.hp !== blackCoreHP && blackCore !== undefined ) { blackCore['hp'] = blackCoreHP; place(blackCore.pos,blackCore); TargetCanvas(blackCore.pos,TargetColor) } } else { if ( blackCore.hp !== blackCoreHP && blackCore !== undefined ) { blackCore['hp'] = blackCoreHP; place(blackCore.pos,blackCore) } }


	        ClearUI();
            HPMPbars();


            if ( enemyHero.hp == 0 && enemyHero.id != yourHero.id ) {

                var c=document.getElementById(enemyHero.pos);
                var ctx=c.getContext("2d");
                var img=document.getElementById("cross");
                ctx.drawImage(img,10,10);

             };
            if ( yourHero.hp == 0 ) {

                var c=document.getElementById(yourHero.pos);
                var ctx=c.getContext("2d");
                var img=document.getElementById("cross");
                ctx.drawImage(img,10,10);

             };


        if ( theparse.gameOver == "whiteWins" ) {

            IsGameOver = true; 

            blackCore['hp'] = 0;

            place(blackCore.pos,blackCore);

            clearInterval(RepeatCommands);

            if ( yourHero.allies == "white" ) { setTimeout(function(){ alert("Victory!! YES!"); }, 1000); } else { setTimeout(function(){ alert("Oh...defeat."); }, 1000); }

            var xmlhttpo = new XMLHttpRequest();
            xmlhttpo.onreadystatechange=function() {
            if (xmlhttpo.readyState==4 && xmlhttpo.status==200)
            { theparse = JSON.parse(xmlhttpo.responseText);
            if ( theparse.gameOver == "true" && yourHero.allies == "white" ) { setTimeout(function(){ document.getElementById("header").innerHTML = "<center><button type='button' onclick='LeaveGame()'>Leave</button><br><br><h2>VICTORY!</h2></center>"; }, 1500); }
            if ( theparse.gameOver == "true" && yourHero.allies == "black" ) { setTimeout(function(){ document.getElementById("header").innerHTML = "<center><button type='button' onclick='LeaveGame()'>Leave</button><br><br><h2>Defeat</h2></center>"; }, 1500); }
            } };

            xmlhttpo.open("GET","/endgameButton",true);
            xmlhttpo.send();

        };

        if ( theparse.gameOver == "blackWins" ) {

            IsGameOver = true; 

            whiteCore['hp'] = 0;

            place(whiteCore.pos,whiteCore); 

            clearInterval(RepeatCommands);

            if ( yourHero.allies == "black" ) { setTimeout(function(){ alert("Victory!! YES!"); }, 1000); } else { setTimeout(function(){ alert("Oh...defeat."); }, 1000); }

            var xmlhttpo = new XMLHttpRequest();
            xmlhttpo.onreadystatechange=function() {
            if (xmlhttpo.readyState==4 && xmlhttpo.status==200)
            { theparse = JSON.parse(xmlhttpo.responseText);
            if ( theparse.gameOver == "true" && yourHero.allies == "black" ) { setTimeout(function(){ document.getElementById("header").innerHTML = "<center><button type='button' onclick='LeaveGame()'>Leave</button><br><br><h2>VICTORY!</h2></center>"; }, 1500); }
            if ( theparse.gameOver == "true" && yourHero.allies == "white" ) { setTimeout(function(){ document.getElementById("header").innerHTML = "<center><button type='button' onclick='LeaveGame()'>Leave</button><br><br><h2>Defeat</h2></center>"; }, 1500); }
            } };

            xmlhttpo.open("GET","/endgameButton",true);
            xmlhttpo.send();

        };

    }
  }

xmlhttp.open("GET","/pacemaker",true);
xmlhttp.send();



}  Timer() };


var LastCommandAttempt = 0;

function commander(x) {  if (IsGameOver == true) { return }; 

        var d = new Date();
        var n = d.getTime();

        if (n - LastCommandAttempt < 300) { return };

        LastCommandAttempt = n;

        if (command == "w") {message = "↑"};
        if (command == "s") {message = "↓"};
        if (command == "a") {message = "←"};
        if (command == "d") {message = "→"};
        if (command == "e") {

            if (yourHero.id == "Joan" && yourHero.mp < 60) { message = "60mp" }

            else if (yourHero.id == "Ima" && yourHero.mp < 70) { message = "70mp" }

            else if (yourHero.id == "Steph" && yourHero.mp < 40) { message = "40mp" }

            else { message = "☄" } };

        if (command.slice(0,1) == "1") {message = "⚔"};


        var c=document.getElementById("UI");
        var ctx=c.getContext("2d");
                
        
            ClearUI();
            HPMPbars();
            ctx.fillStyle="white";
            ctx.font = "50px Arial";
            ctx.fillText(message,window.innerWidth / 2 + 10,85);


        if (message.length != 1) { return }


        var theparse;
   

    var xmlhttp = new XMLHttpRequest();
   xmlhttp.onreadystatechange=function()

  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    { theparse = JSON.parse(xmlhttp.responseText);

        if ( theparse.gameOver == "true" ) { return };

    if (yourHero.pos != theparse.yourPos) { TurnCanvasOn(yourHero.pos) };
    if (enemyHero.pos != theparse.enemyPos) { TurnCanvasOn(enemyHero.pos) };
     

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

       
      if (yourHero.status.indexOf('†') === -1) { place(yourHero.pos, yourHero) };
      if (enemyHero.status.indexOf('†') === -1 && enemyHero.id != yourHero.id) { place(enemyHero.pos, enemyHero) };


    if ( whiteCore.pos == x || blackCore.pos == x ) { 

        var c=document.getElementById(x);
        var ctx=c.getContext("2d");
        ctx.clearRect(0,0,50,50); 

            place(whiteCore.pos,whiteCore); place(blackCore.pos,blackCore); }

    
            ClearUI();
            HPMPbars();

    if ( document.getElementsByClassName("target").length > 0 ) { sheath() };



    }
  }

    if (x !== undefined && command.indexOf(".") === -1) { command = command + "." + x }

    xmlhttp.open("POST","/command",true);
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.send("command=" + command);
}








