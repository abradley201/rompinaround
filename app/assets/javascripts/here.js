	 
	 var command = "nothing";


	 var optionsEU = [];
     var optionsED = [];
     var options1R = []; 
     var options1L = [];
     var optionsDGLTR = [];
     var optionsDGLTL = [];
     var optionsDGLBR = [];
     var optionsDGLBL = []; //USED FOR DETERMINING ROWS, COLUMNS, AND DIAGONALS.


     function ClmNumber(a) {
    
    if (document.getElementById(a).className == "off") { return "not on board" };
    
    var column = [a];
   
    for ( n=1; n<=e-2; n++ ) {  
         if (document.getElementById( a - ( e * n ) ).className !== "off") { 
         column.push( a - ( e * n ) ) } 
         if (document.getElementById( a - ( e * n ) ).className == "off") { break } }
    column.sort(function(l, p){return l-p}); 
    
    return column[0];
    
	};


	function RowNumber(a) {
    
      if (document.getElementById(a).className == "off") { return "not on board" };
    
      var row = [a];

      for ( n=1; n<=e-2; n++ ) {  
          if (document.getElementById( a - ( 1 * n ) ).className !== "off") { 
          row.push( a - ( 1 * n ) ) } 
          if (document.getElementById( a - ( 1 * n ) ).className == "off") { break } }
      row.sort(function(l, p){return l-p}); 
      
      return ( ( (row[0] - 1) / e ) + 1 );   
    
	};


function blankClick(x) {

	var y = yourHero.pos;

	if ( x == y ) { return };


    if ( RowNumber(x) == RowNumber(y) ) { 

    	var z = x - y;

    	if ( z > 0 ) { command = "d"; commander(); } else { command = "a"; commander(); }

    	return;

	}

	if ( ClmNumber(x) == ClmNumber(y) ) { 

		var z = x - y;

    	if ( z > 0 ) { command = "s"; commander(); } else { command = "w"; commander(); }

    	return;

	}

};


//here(x) is a function that is called when a square is clicked.


function here(x) {   console.log(x); 

	if ( document.getElementById(x).className == "target" ) {


		commander(x);


	} else { blankClick(x) }
                  
                  
          
    
 
 };  


    