	 
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





function Dgl(a) {
    
     // [a + (-1 - e), a + (1 - e), a + (1 + e), a + (-1 + e)] the diagonals
    
    if (document.getElementById(a).className == "off") { return "not on board" };
   
    var dgl = [a];
    
    for ( n=1; n<=e-2; n++ ) {
         if (document.getElementById( a + ( e * n ) + ( 1 * n ) ).className !== "off") { 
         dgl.push( a + ( e * n ) + ( 1 * n ) ) }
         if (document.getElementById( a + ( e * n ) + ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {  
         if (document.getElementById( a - ( e * n ) + ( 1 * n ) ).className !== "off") { 
         dgl.push( a - ( e * n ) + ( 1 * n ) ) }
         if (document.getElementById( a - ( e * n ) + ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {  
         if (document.getElementById( a + ( e * n ) - ( 1 * n ) ).className !== "off") { 
         dgl.push( a + ( e * n ) - ( 1 * n ) ) }
         if (document.getElementById( a + ( e * n ) - ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {
         if (document.getElementById( a - ( e * n ) - ( 1 * n ) ).className !== "off") { 
         dgl.push( a - ( e * n ) - ( 1 * n ) ) }
         if (document.getElementById( a - ( e * n ) - ( 1 * n ) ).className == "off") { break } }
    
    return dgl;
    
};


function Star(a) {
    
     if (document.getElementById(a).className == "off") { return "not on board" };
    
     optionsEU = [];
     optionsED = [];
     options1R = []; 
     options1L = [];
     optionsDGLTR = [];
     optionsDGLTL = [];
     optionsDGLBR = [];
     optionsDGLBL = [];
  
    for ( n=1; n<=hi; n++ ) {
         if (document.getElementById( a + ( e * n ) ).className !== "off") { 
         optionsED.push( a + ( e * n ) ) }
         if (document.getElementById( a + ( e * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {  
         if (document.getElementById( a - ( e * n ) ).className !== "off") { 
         optionsEU.push( a - ( e * n ) ) } 
         if (document.getElementById( a - ( e * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {
         if (document.getElementById( a + ( 1 * n ) ).className !== "off") { 
         options1R.push( a + ( 1 * n ) ) }
         if (document.getElementById( a + ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {   
         if (document.getElementById( a - ( 1 * n ) ).className !== "off") { 
         options1L.push( a - ( 1 * n ) ) } 
         if (document.getElementById( a - ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {
         if (document.getElementById( a + ( e * n ) + ( 1 * n ) ).className !== "off") { 
         optionsDGLBR.push( a + ( e * n ) + ( 1 * n ) ) }
         if (document.getElementById( a + ( e * n ) + ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {  
         if (document.getElementById( a - ( e * n ) + ( 1 * n ) ).className !== "off") { 
         optionsDGLTR.push( a - ( e * n ) + ( 1 * n ) ) }
         if (document.getElementById( a - ( e * n ) + ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {  
         if (document.getElementById( a + ( e * n ) - ( 1 * n ) ).className !== "off") { 
         optionsDGLBL.push( a + ( e * n ) - ( 1 * n ) ) }
         if (document.getElementById( a + ( e * n ) - ( 1 * n ) ).className == "off") { break } }
    for ( n=1; n<=e-2; n++ ) {
         if (document.getElementById( a - ( e * n ) - ( 1 * n ) ).className !== "off") { 
         optionsDGLTL.push( a - ( e * n ) - ( 1 * n ) ) }
         if (document.getElementById( a - ( e * n ) - ( 1 * n ) ).className == "off") { break } }
    
    var thestar = optionsEU.concat(optionsED,options1R,options1L,optionsDGLBL,optionsDGLBR,optionsDGLTR,optionsDGLTL); 
    return thestar;
    
};

function IsOnStar(a, b) { 
    
  if (document.getElementById(a).className == "off" || document.getElementById(b).className == "off") 
     { return "not on board" };
    
  if (a == b) { return "same number" };

    
     var clue = "no";
     Star(a);
                                  
       for ( m=0; m<optionsEU.length; m++ ) { if (b == optionsEU[m]) { clue = optionsEU } } 
       for ( m=0; m<optionsED.length; m++ ) { if (b == optionsED[m]) { clue = optionsED } } 
       for ( m=0; m<options1L.length; m++ ) { if (b == options1L[m]) { clue = options1L } } 
       for ( m=0; m<options1R.length; m++ ) { if (b == options1R[m]) { clue = options1R } } 
       for ( m=0; m<optionsDGLTR.length; m++ ) { if (b == optionsDGLTR[m]) { clue = optionsDGLTR } } 
       for ( m=0; m<optionsDGLTL.length; m++ ) { if (b == optionsDGLTL[m]) { clue = optionsDGLTL } } 
       for ( m=0; m<optionsDGLBR.length; m++ ) { if (b == optionsDGLBR[m]) { clue = optionsDGLBR } } 
       for ( m=0; m<optionsDGLBL.length; m++ ) { if (b == optionsDGLBL[m]) { clue = optionsDGLBL } } 
 
     return clue
     
};
   

//functions for finding and tracing shortest distance from square a to square b



//simple distance only works on squares that are within a Queen's movement of each other
function simpleDistance(a, b) { 
    
 if (document.getElementById(a).className == "off" || document.getElementById(b).className == "off") 
 { return "not on board" };
    
 if (a == b) { return [a] };

          function StarDistance(a, b) { 
    
            if (a > b) { var c = a; a = b; b = c };

               if (IsOnStar(a, b) !== "no") {
    
                   var beginning = [a];
                   var path = IsOnStar(a, b);
                   var end = [b];
                   path.sort(function(l, p){return l-p}); 
                   path.splice(path.indexOf(b), e);
                   var theway = beginning.concat(path,end);
                   return theway }
    
                else { return "off star" }

            };
    
 if (a > b) { 
     
    if (IsOnStar(a, b) !== "no") {
 
    return StarDistance(a, b).sort(function(l, p){return p-l}) } else { return "off star" } 
    
    } else { return StarDistance(a, b) }
    
};
 

//U1D stands for Using 1 Diagonal. the first move MUST be diagonal
function Distancext(a, b) {
    
 if (document.getElementById(a).className == "off" || document.getElementById(b).className == "off") 
 { return "not on board" };
    
 if (a == b) { return [a] };
 
 if (simpleDistance(a, b) instanceof Array == true)  { return simpleDistance(a, b) };
    
    
 var beginning = [a];
 var options = [];
 
        
 if ( RowNumber(a) > RowNumber(b) && ClmNumber(a) > ClmNumber(b) ) { 
 //top left quadrant
     
   for (n=1;n<=e-2;n++) {
       
     if (document.getElementById(a + ( n * (-1 - e) )).className == "off") { break } 
  
     options.push(a + ( n * (-1 - e) )) }
     
     options.sort(function(l, p){return p-l});
     
         var m = 0;
         
         var x = 0;
         
     while (m < options.length) { 
     
         if (ClmNumber(options[m]) == ClmNumber(b) || RowNumber(options[m]) == RowNumber(b)) { x = options[m] }
         
         if (x > 0) { break }
         
         else { m++ }  }   
     
         options.splice(options.indexOf(x),e);   
         
         var theway = beginning.concat(options,simpleDistance(x,b)); return theway  }

 
    
 if ( RowNumber(a) > RowNumber(b) && ClmNumber(a) < ClmNumber(b) ) {
 //top right quadrant
 
   for (n=1;n<=e-2;n++) {
       
      if (document.getElementById(a + ( n * (1 - e) )).className == "off") { break } 
  
      options.push(a + ( n * (1 - e) )) }
     
      options.sort(function(l, p){return p-l});
     
         var m = 0;
         
         var x = 0;
         
     while (m < options.length) { 
     
         if (ClmNumber(options[m]) == ClmNumber(b) || RowNumber(options[m]) == RowNumber(b)) { x = options[m] }
         
         if (x > 0) { break }
         
         else { m++ }  }   
     
         options.splice(options.indexOf(x),e);   
         
         var theway = beginning.concat(options,simpleDistance(x,b)); return theway  }
    
    
         
 if ( RowNumber(a) < RowNumber(b) && ClmNumber(a) < ClmNumber(b) ) { 
 //bottom right quadrant
     
   for (n=1;n<=e-2;n++) {
       
      if (document.getElementById(a + ( n * (1 + e) )).className == "off") { break } 
  
      options.push(a + ( n * (1 + e) )) }
     
      options.sort(function(l, p){return l-p});
     
         var m = 0;
         
         var x = 0;
         
     while (m < options.length) { 
     
         if (ClmNumber(options[m]) == ClmNumber(b) || RowNumber(options[m]) == RowNumber(b)) { x = options[m] }
         
         if (x > 0) { break }
         
         else { m++ }  }   
     
         options.splice(options.indexOf(x),e);   
         
         var theway = beginning.concat(options,simpleDistance(x,b)); return theway  }
    
    

 if ( RowNumber(a) < RowNumber(b) && ClmNumber(a) > ClmNumber(b) ) {
 //bottom left quadrant
     
   for (n=1;n<=e-2;n++) {
       
      if (document.getElementById(a + ( n * (-1 + e) )).className == "off") { break } 
  
      options.push(a + ( n * (-1 + e) )) }
     
      options.sort(function(l, p){return l-p});
     
         var m = 0;
         
         var x = 0;
         
     while (m < options.length) { 
     
         if (ClmNumber(options[m]) == ClmNumber(b) || RowNumber(options[m]) == RowNumber(b)) { x = options[m] }
         
         if (x > 0) { break }
         
         else { m++ }  }   
     
         options.splice(options.indexOf(x),e);   
         
         var theway = beginning.concat(options,simpleDistance(x,b)); return theway  }
    
  
};


//uses 1 diagonal, but first move is NOT the diagonal. 
function Distancetx(a, b) { 
    
    if (document.getElementById(a).className == "off" || document.getElementById(b).className == "off") 
    { return "not on board" };
    
    if (a == b) { return [a] };
 
    if (simpleDistance(a, b) instanceof Array == true)  { return simpleDistance(a, b) };
    
    var beginning = [a];
    
    var m = 0;
    
    var n = 0;
    
    var x = 0;
    
    
  if ( RowNumber(a) > RowNumber(b) && ClmNumber(a) > ClmNumber(b) ) {
            //top left quadrant
         
         
         Star(a); var column = optionsEU; var row = options1L;
         
         
         
         while ( m < column.length ) { 
             
             if (IsOnStar(column[m],b) == optionsDGLTL) { x = column[m] }
                                           
             if (x > 0) { break }
                                     
             else ( m++ )  }
         
         
         
         while ( n < row.length ) { 
             
             if (IsOnStar(row[n],b) == optionsDGLTL) { x = row[n] }
                                           
             if (x > 0) { break }
         
             else ( n++ )  }
         
         
         
         if (ClmNumber(x) == ClmNumber(a)) {
    
         column.splice(column.indexOf(x),e);   
         
         var theway = beginning.concat(column,simpleDistance(x,b)); return theway  }
         
    
         if (RowNumber(x) == RowNumber(a)) {
    
         row.splice(row.indexOf(x),e);   
         
         var theway = beginning.concat(row,simpleDistance(x,b)); return theway  }   }
    
    
  if ( RowNumber(a) > RowNumber(b) && ClmNumber(a) < ClmNumber(b) ) {
            //top right quadrant
         
         
         Star(a); var column = optionsEU; var row = options1R;
         
         
         
         while ( m < column.length ) { 
             
             if (IsOnStar(column[m],b) == optionsDGLTR) { x = column[m] }
                                           
             if (x > 0) { break }
                                     
             else ( m++ )  }
         
         
         
         while ( n < row.length ) { 
             
             if (IsOnStar(row[n],b) == optionsDGLTR) { x = row[n] }
                                           
             if (x > 0) { break }
         
             else ( n++ )  }
         
         
         
         if (ClmNumber(x) == ClmNumber(a)) {
    
         column.splice(column.indexOf(x),e);   
         
         var theway = beginning.concat(column,simpleDistance(x,b)); return theway  }
         
    
         if (RowNumber(x) == RowNumber(a)) {
    
         row.splice(row.indexOf(x),e);   
         
         var theway = beginning.concat(row,simpleDistance(x,b)); return theway  }   }
    
    
  if ( RowNumber(a) < RowNumber(b) && ClmNumber(a) < ClmNumber(b) ) { 
            //bottom right quadrant
         
         
         Star(a); var column = optionsED; var row = options1R;
         
         
         
         while ( m < column.length ) { 
             
             if (IsOnStar(column[m],b) == optionsDGLBR) { x = column[m] }
                                           
             if (x > 0) { break }
                                     
             else ( m++ )  }
         
         
         
         while ( n < row.length ) { 
             
             if (IsOnStar(row[n],b) == optionsDGLBR) { x = row[n] }
                                           
             if (x > 0) { break }
         
             else ( n++ )  }
         
         
         
         if (ClmNumber(x) == ClmNumber(a)) {
    
         column.splice(column.indexOf(x),e);   
         
         var theway = beginning.concat(column,simpleDistance(x,b)); return theway  }
         
    
         if (RowNumber(x) == RowNumber(a)) {
    
         row.splice(row.indexOf(x),e);   
         
         var theway = beginning.concat(row,simpleDistance(x,b)); return theway  }   }
    
    
  if ( RowNumber(a) < RowNumber(b) && ClmNumber(a) > ClmNumber(b) ) {
            //bottom left quadrant
         
         Star(a); var column = optionsED; var row = options1L;
         
         
         
         while ( m < column.length ) { 
             
             if (IsOnStar(column[m],b) == optionsDGLBL) { x = column[m] }
                                           
             if (x > 0) { break }
                                     
             else ( m++ )  }
         
         
         
         while ( n < row.length ) { 
             
             if (IsOnStar(row[n],b) == optionsDGLBL) { x = row[n] }
                                           
             if (x > 0) { break }
         
             else ( n++ )  }
         
         
         
         if (ClmNumber(x) == ClmNumber(a)) {
    
         column.splice(column.indexOf(x),e);   
         
         var theway = beginning.concat(column,simpleDistance(x,b)); return theway  }
         
    
         if (RowNumber(x) == RowNumber(a)) {
    
         row.splice(row.indexOf(x),e);   
         
         var theway = beginning.concat(row,simpleDistance(x,b)); return theway  }  }  
  
};




function blankClick(x) {

	var y = yourHero.pos;

	if ( x == y ) { return };


    if ( RowNumber(x) == RowNumber(y) ) { 

    	var z = x - y;

    	if ( z > 0 ) { command = "d"; commander(); } else { command = "a"; commander(); }

    	return;

	       };

	   if ( ClmNumber(x) == ClmNumber(y) ) { 

		  var z = x - y;

    	if ( z > 0 ) { command = "s"; commander(); } else { command = "w"; commander(); }

    	return;

	       };



  var w = Distancetx(y,x)[0];



    if ( RowNumber(w) == RowNumber(y) ) { 

      var z = w - y;

      if ( z > 0 ) { command = "d"; commander(); } else { command = "a"; commander(); }

      return;

          };

    if ( ClmNumber(w) == ClmNumber(y) ) { 

      var z = w - y;

      if ( z > 0 ) { command = "s"; commander(); } else { command = "w"; commander(); }

      return;

          };

  

};




//here(x) is a function that is called when a square is clicked.
function here(x) {   console.log(x); 

	if ( document.getElementById(x).className == "target" ) {


		commander(x);


	} else {



		if ( document.getElementById(x).className == "occupied" ) { 

				command = "1"; commander(x); 


						} else { 


					blankClick(x) } }
                  
                  
 
 };  


    