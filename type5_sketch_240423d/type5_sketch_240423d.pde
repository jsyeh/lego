// Step04 在什麼都不懂的情況下，試試看「矩陣乘向量」位置對不對

// Step02 2點得直線方程式，另外2點是控制點(代入方程式，看是否同向)
// Step02-1 2點得直線方程式
// 兩點的直線方程式 (y – y1)/(x – x1) = (y2 – y1)/(x2 – x1)
// 變數(x,y) 在線上，兩端點是常數(x1,y1) (x2,y2)
// (x,y) - (x1,y1) ~= (x2,y2) - (x1,y1) 斜率相同
// (y-y1) / (x-x1) == (y2-y1) / (x2-x1)
// (y-y1) * (x2-x1) == (y2-y1) * (x-x1) ==> ax + by + c = 0
// (y-y1) * (x2-x1) - (y2-y1) * (x-x1) == 0
//  -(y2-y1) * x  +  (x2-x1) * y  +  -y1 * (x2-x1) + x1 * (y2-y1) == 0
PVector [] p = new PVector[4];
boolean checkType5(PVector [] p){ //input是2D
  float x1 = p[0].x, y1 = p[0].y;
  float x2 = p[1].x, y2 = p[1].y;
  float a = -(y2-y1), b = (x2-x1), c = -y1 * (x2-x1) + x1 *  (y2-y1);
  // Step02-2 另外2點是控制點(代入方程式，看是否同向)
  return (a * p[2].x + b * p[2].y + c) * (a * p[3].x + b * p[3].y + c) >= 0;
}

void setup(){
  size(500 ,500, P3D);
  p[0] = new PVector(250, 50);
  p[1] = new PVector(250,450);
  p[2] = new PVector(450, 100);
  p[3] = new PVector(0 ,0);
  
}

void draw(){
  background(#FFFFF2);
  p[3].x = mouseX;
  p[3].y = mouseY;
  stroke(0);
  ellipse(p[2].x, p[2].y, 10, 10); //兩個點 固定點
  ellipse(p[3].x, p[3].y, 10, 10); //兩個點 移動點
  if(checkType5(p)) stroke(255,0,0); // 同向，就線線
  else stroke(200); // 不同向，就不要畫，用淡淡的灰線
  line(p[0].x, p[0].y, p[1].x, p[1].y); // Line Type 5: Optional Line
}


void mousePressed(){
  PGraphics3D g = (PGraphics3D) this.g;
  g.projmodelview.print(); //再印一次
  printMatrix();
  PMatrix3D m = g.projmodelview;
  for(int i=0; i<4; i++){
    //p[i]
  }
}
