


function ClearUI() { if (SelectedHero === undefined) { return }
        
     var ClearWidth = window.innerWidth;             
     
    var c=document.getElementById("UI");
    var ctx=c.getContext("2d");
    ctx.clearRect(0,0,ClearWidth,150);
    DrawPicture("UI", SelectedHero.ppic);
                    
      ctx.beginPath();
      ctx.moveTo(window.innerWidth/2, 0);
      ctx.lineTo(window.innerWidth/2, 150);
      ctx.lineWidth = 2;
      ctx.strokeStyle = 'grey';
      ctx.stroke();
    
};



function HPMPbars() { if (SelectedHero === undefined) { return }
    
    var HPMultiplier = SelectedHero.hp / SelectedHero.maxhp;
    var MPMultiplier = SelectedHero.mp / SelectedHero.maxmp;

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
    ctx.fillText(SelectedHero.hp + " / " + SelectedHero.maxhp, 125 + window.innerWidth/16, 60);
    
    ctx.beginPath();
    ctx.fillStyle="#3366FF";
    ctx.fillRect(160,85,MPMultiplier * window.innerWidth/8,25); 
    
    ctx.font = "20px Georgia";
    ctx.fillText(SelectedHero.mp + " / " + SelectedHero.maxmp, 125 + window.innerWidth/16, 140);
        

};



