ArrayList<PVector> contour = new ArrayList<PVector>();
PVector [] P = new PVector[4]; //P[0], P[1], P[2], P[3]

void setup(){
  size(512,512);
}

void draw(){
  background(#FFFFF2);
  for(PVector p : contour){
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
  }
}

void mouseDragged(){
  if(mouseButton==LEFT){ contour.add( new PVector(100, mouseY) ); }
  if(mouseButton==RIGHT){
    P[3].x = mouseX; P[3].y = mouseY;
    
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
