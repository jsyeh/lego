ArrayList<PVector> contour = new ArrayList<PVector>();
ArrayList<PVector> contour2 = new ArrayList<PVector>();
PVector [] P = new PVector[4];
PVector [] V = new PVector[4];
void setup(){
  size(512, 512);
}
void draw(){
  background(#FFFFF2);
  for(int i=0; i<contour.size()-1; i++){
    PVector prev = contour.get(i), next = contour.get(i+1);
    line(prev.x, prev.y, next.x, next.y);
    ellipse(prev.x, prev.y, 3, 3);
  }
  for(int i=0; i<contour2.size()-1; i++){
    PVector prev = contour2.get(i), next = contour2.get(i+1);
    line(prev.x, prev.y, next.x, next.y);
    ellipse(prev.x, prev.y, 3, 3);
  }
  for(PVector p : contour2){
    ellipse(p.x, p.y, 15, 15);
  }
  for(int i=0; i<4; i++){
    if(P[i]!=null) ellipse(P[i].x, P[i].y, 15, 15);
  }
}
void mousePressed(){
  if(mouseButton==RIGHT){
    if(contour.size()>0) {
      P[0] = contour.get(0); 
      P[1] = contour.get(contour.size()-1);
      V[0] = PVector.sub(P[1],P[0]); //從P0到P1的向量，是座標軸
      V[1] = new PVector(V[0].y, -V[0].x); //垂直的另一個向量，也是座標軸
      for(PVector p : contour) contour2.add(p.copy()); //建出contour2
    }
    P[2] = new PVector(mouseX, mouseY);
    P[3] = new PVector(mouseX, mouseY);
  }
}
void mouseDragged(){
  println(mouseButton);
  if(mouseButton==LEFT) contour.add(new PVector(mouseX, mouseY));
  else if(mouseButton==RIGHT){
    P[3].x = mouseX; 
    P[3].y = mouseY;
    V[2] = PVector.sub(P[3],P[2]);
    V[3] = new PVector(V[2].y, -V[2].x);
    for(int i=0; i<contour2.size(); i++){
      PVector oldPos = contour.get(i);
      PVector r1r2 = getRatio(oldPos, P[0], V[0], V[1]);
      //PVector newPos = P[2] + r1r2.x *V[2] + r1r2.y * V[3]
      PVector newPos = PVector.add(PVector.mult(V[2],r1r2.x),PVector.mult(V[3],r1r2.y));
      contour2.set(i, PVector.add(P[2], newPos));
    }
  } 
}
PVector getRatio(PVector p, PVector Orig, PVector axis1, PVector axis2){
  PVector diff = PVector.sub(p, Orig);
  float r1 = PVector.dot(diff, axis1)/axis1.magSq();
  float r2 = PVector.dot(diff, axis2)/axis2.magSq();
  return new PVector(r1,r2);
}
