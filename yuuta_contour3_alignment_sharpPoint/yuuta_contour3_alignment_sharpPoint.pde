PVector [] sharpPoint = new PVector[6];
PVector [] sharpPoint2 = new PVector[6];
void setup(){
  size(512,512);
  for(int i=0; i<6; i++){
    sharpPoint[i] = new PVector(random(512), random(512));
  }
  alignment();
}

void alignment(){
  for(int i=0; i<6; i++){
    float x = sharpPoint[i].x, y = sharpPoint[i].y;
    int nearestX=0, nearestY=0;
    for(int xx=0; xx<=16; xx++){
      if(abs(xx*32-x)<abs(nearestX-x)) nearestX = xx*32;
    }
    for(int yy=0; yy<=16; yy++){
      if(abs(yy*32-y)<abs(nearestY-y)) nearestY = yy*32;
    }
    sharpPoint2[i] = new PVector(nearestX, nearestY);
  }
}

void draw(){
  background(#FFFFF2);
  stroke(128);
  noFill();
  for(int i=0; i<16; i++){
    for(int j=0; j<16; j++){
      noFill();
      rect(j*32, i*32, 32, 32); //baseplate grid
    }
  }  
  for(int i=0; i<6; i++){
    fill(255,0,0);
    ellipse(sharpPoint[i].x, sharpPoint[i].y, 15, 15);
  }
  for(int i=0; i<6; i++){
    fill(#F58F40);
    ellipse(sharpPoint2[i].x, sharpPoint2[i].y, 15, 15);    
  }
}
