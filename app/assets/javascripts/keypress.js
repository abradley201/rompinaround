




function google(evt){ 
                     
    var key = (typeof evt.which != "undefined") ? evt.which : event.keyCode;
                     
    if (String.fromCharCode(key)=="-"){ var counter = 1; while (counter <= highestSquare) { document.getElementById(counter).style.borderWidth="0px"; counter++ } }   
                     
    if (String.fromCharCode(key)=="="){ var counter = 1; while (counter <= highestSquare) { document.getElementById(counter).style.borderWidth="1px"; counter++ } }
                     
    if (String.fromCharCode(key)=="w"){ Move("w"); }
                     
    if (String.fromCharCode(key)=="a"){ Move("a"); }

    if (String.fromCharCode(key)=="s"){ Move("s"); }
                     
    if (String.fromCharCode(key)=="d"){ Move("d"); }
                                       
                     
                     
                     
}

function Move(x) { 

	if ( x == "w" )  {

		if ( document.getElementById(yourHero.pos - e) == "on" ) {

			//TurnCanvasOn(yourHero.pos);
			//place(yourHero.)


		}


	 };

	if ( x == "a" )  { };

	if ( x == "s" )  { };

	if ( x == "d" )  { };



};



