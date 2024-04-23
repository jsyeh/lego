// Step01 先畫出線、點、互動界面
PVector [] p = new PVector[4];

void setup(){
  size(500, 500);
  p[0] = new PVector(250, 50);
  p[1] = new PVector(250,450);
  p[2] = new PVector(450, 100);
  p[3] = new PVector(0 ,0);
}

void draw(){
  background(#FFFFF2);
  p[3].x = mouseX;
  p[3].y = mouseY;
  ellipse(p[2].x, p[2].y, 10, 10); //兩個點 固定點
  ellipse(p[3].x, p[3].y, 10, 10); //兩個點 移動點
  line(p[0].x, p[0].y, p[1].x, p[1].y); // Line Type 5: Optional Line
}
