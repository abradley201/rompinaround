


function ClearUI() { if (yourHero === undefined) { return }
        
     var ClearWidth = window.innerWidth;             
     
    var c=document.getElementById("UI");
    var ctx=c.getContext("2d");
    ctx.clearRect(0,0,ClearWidth,150);
    DrawPicture("UI", yourHero.ppic);

    if (yourHero.allies == "white") { 

        ctx.fillStyle = "white";
        ctx.fillRect(5, 125, 20, 20);

    };

    if (yourHero.allies == "black") { 

        ctx.fillStyle = "black";
        ctx.fillRect(5, 125, 20, 20);

    };

    if (yourHero.hp == 0) { 

        DrawPicture("UI", "cross");
        ctx.fillStyle = "red";
        ctx.font = "30px Arial";
        ctx.fillText("Reviving...",5,50);

    };
    
};



function HPMPbars() { if (yourHero === undefined) { return }
    
    var HPMultiplier = yourHero.hp / yourHero.maxhp;
    var MPMultiplier = yourHero.mp / yourHero.maxmp;

    var c=document.getElementById("UI");
    var ctx=c.getContext("2d");
    
    ctx.beginPath();
    ctx.strokeStyle="#FF0000";
    ctx.rect(160,10,window.innerWidth/8,25);
    ctx.stroke();
    
    ctx.beginPath();
    ctx.strokeStyle="#3366FF";
    ctx.rect(160,85,window.innerWidth/8,25);
    ctx.stroke();
    
    ctx.beginPath();
    ctx.fillStyle="#FF0000";
    ctx.fillRect(160,10,HPMultiplier * window.innerWidth/8,25);
    
    ctx.font = "20px Georgia";
    ctx.fillText(yourHero.hp + " / " + yourHero.maxhp, 125 + window.innerWidth/16, 60);
    
    ctx.beginPath();
    ctx.fillStyle="#3366FF";
    ctx.fillRect(160,85,MPMultiplier * window.innerWidth/8,25); 
    
    ctx.font = "20px Georgia";
    ctx.fillText(yourHero.mp + " / " + yourHero.maxmp, 125 + window.innerWidth/16, 140);
        

};

