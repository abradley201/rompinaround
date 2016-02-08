var e; var hi;
    
var Square = 50; 

var highestSquare;

var atoms = []; 


function CreateContent(x, y, z, c) {
    
    contentwidth = x;
    contentheight = y;
    
    if ( document.getElementById("content") !== null ) { return };
 
    
    document.getElementById('container').style.height = c

    
    var div = document.createElement('div');
    div.id = "content";
    div.className = "content";
    div.style.display = "block";
    div.style.width = x.toString() + "px";
    div.style.height = y.toString() + "px";
    div.style.backgroundColor = z;
    document.getElementById('container').appendChild(div);

      
    };
    

function CreateBoard(top, left, w, h) {
    
    var boardwidth = w * Square + w * 2;
    var boardheight = h * Square + h * 2;
    
    if ( document.getElementById("board") !== null ) { return };
    
    var div = document.createElement('div');
    div.setAttribute("align", "center");
    div.id = "board";
    div.className = "board";
    div.style.display = "block";
    div.style.top = top.toString() + "px";
    div.style.left = left.toString() + "px";
    div.style.width = boardwidth.toString() + "px";
    div.style.height = boardheight.toString() + "px";
    document.getElementById('content').appendChild(div);

    var z = w * h;
       
    for (m=0;m>=-3000;m--) { var canv = document.createElement('canvas');
              canv.id = m;
              canv.className = "off";
              canv.height = 0;
              canv.width = 0;
              canv.style.visibility = "hidden";
              canv.style.display = "none";
              document.getElementById('board').appendChild(canv) };
       
    for (r=z+(h-1)*2+1;r<=z+(h-1)*2+3000;r++) { var canv = document.createElement('canvas');
              canv.id = r;
              canv.className = "off";
              canv.height = 0;
              canv.width = 0;
              canv.style.visibility = "hidden";
              canv.style.display = "none";
              document.getElementById('board').appendChild(canv) };
  
              
    for (n=1;n<=z+(h-1)*2;n++) {
        
      for (p=1;p<=h;p++) {
        var skip = w + 1;
        if ( n == skip * p + p - 1 ) { 
            
            var canv = document.createElement('canvas');
              canv.id = n;
              canv.className = "off";
              canv.height = 0;
              canv.width = 0;
              canv.style.visibility = "hidden";
              canv.style.display = "none";
              document.getElementById('board').appendChild(canv);
            var canv = document.createElement('canvas');
              canv.id = n+1;
              canv.className = "off";
              canv.height = 0;
              canv.width = 0;
              canv.style.visibility = "hidden";
              canv.style.display = "none";
              document.getElementById('board').appendChild(canv);

            n = n+2 } };
        
    var canv = document.createElement('canvas');
      canv.id = n;
      canv.className = "on";
      canv.height = Square;
      canv.width = Square; 
      var clickvalue;  
      clickvalue = "here("+n+")";
      canv.setAttribute("onClick",clickvalue);
      document.getElementById('board').appendChild(canv); } 
    
    
    e = w + 2; atoms = [e, -e, 1, -1]; hi = h; highestSquare = ( e - 2 ) * hi + 2 * hi - 2;


    var headerDiv = document.createElement('div');
    headerDiv.id = "header";
    headerDiv.className = "header";
    headerDiv.style.display = "block";
    document.getElementById('container').appendChild(headerDiv);
    
    var UI = document.createElement('canvas');
    UI.id = "UI";
    UI.className = "UI";
    UI.width = window.innerWidth;
    UI.height = 150;
    document.getElementById('header').appendChild(UI);
    

};



