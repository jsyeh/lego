ArrayList<PVector> contour = new ArrayList<PVector>();
ArrayList<PVector> contour2 = new ArrayList<PVector>();
PVector [] P = new PVector[4]; //P[0], P[1], P[2], P[3]

void setup(){
  size(512,512);
}

void draw(){
  background(#FFFFF2);
  for(PVector p : contour){
    ellipse(p.x, p.y, 3, 3);
  }
  for(PVector p : contour2){
    ellipse(p.x, p.y, 3, 3);
  }
  if(P[0]!=null) ellipse(P[0].x, P[0].y, 10, 10);
  if(P[1]!=null) ellipse(P[1].x, P[1].y, 10, 10);
  if(P[2]!=null) ellipse(P[2].x, P[2].y, 10, 10);
  if(P[3]!=null) ellipse(P[3].x, P[3].y, 10, 10);
}

void mousePressed(){
  if(mouseButton==RIGHT){
    P[2] = new PVector(mouseX, mouseY);
    P[3] = new PVector(mouseX, mouseY);
    for(PVector p : contour){
      contour2.add( new PVector() );
    }
  }
}

void mouseDragged(){
  if(mouseButton==LEFT){ contour.add( new PVector(100, mouseY) ); }
  if(mouseButton==RIGHT){
    P[3].x = mouseX; P[3].y = mouseY;
    PVector oldV = PVector.sub(P[1],P[0]), newV = PVector.sub(P[3],P[2]);
    for(int i=0; i<contour.size(); i++){
      PVector oldP = contour.get(i), newP = contour.get(i);
      PVector oldvv = PVector.sub(oldP,P[0]);
      float ratio = PVector.dot(oldV, oldvv)/ oldV.magSq();
      println(ratio);
      contour2.get(i).x = P[2].x + ratio*newV.x;
      contour2.get(i).y = P[2].y + ratio*newV.y;
    }
  }
}

void keyPressed(){
  if(key=='s') {
    String [] lines = new String[contour.size()];
    for(int i=0; i<contour.size(); i++){
      PVector p = contour.get(i);
      lines[i] = p.x + " " + p.y;
    }
    saveStrings("contour.txt", lines);
  }else if(key=='r') {
    String [] lines = loadStrings("contour.txt");
    for(String line : lines){
      String [] xy = split(line, ' ');
      contour.add( new PVector( float(xy[0]), float(xy[1]) ) );
    }
    P[0] = contour.get(0);
    P[1] = contour.get(contour.size()-1);
  }
}
