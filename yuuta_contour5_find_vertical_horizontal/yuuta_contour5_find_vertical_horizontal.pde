ArrayList<PVector> contour = new ArrayList<PVector>();
void setup(){
  size(512,512);
}
void draw(){
  background(#FFFFF2);
  stroke(0);
  strokeWeight(1);
  for(int i=0; i<contour.size()-1; i++){
    PVector prev = contour.get(i), next = contour.get(i+1);
    line(prev.x, prev.y, next.x, next.y);
  }
  for(PVector p : contour){
    fill(128);
    ellipse(p.x, p.y, 3, 3);
  }
  for(Integer i : sharpPoint){
    PVector p = contour.get(i);
    fill(255,0,0);
    ellipse(p.x, p.y, 10, 10);
  }
  for(Integer i : horizon){
    PVector prev = contour.get(i), next = contour.get(i+1);
    stroke(0,0,255);
    strokeWeight(4);
    line(prev.x, prev.y, next.x, next.y);
  }
  for(Integer i : vertical){
    PVector prev = contour.get(i), next = contour.get(i+1);
    stroke(0,0,255);
    strokeWeight(4);
    line(prev.x, prev.y, next.x, next.y);
  }
}
void mousePressed(){
  contour.add( new PVector(mouseX, mouseY) );
}
void mouseDragged(){
  PVector prev = contour.get(contour.size()-1);
  if( dist(mouseX, mouseY, prev.x, prev.y)>10 ){
    contour.add( new PVector(mouseX, mouseY) ); 
  }
}
void keyPressed(){
  if(key=='s'){
    String [] lines = new String[contour.size()];
    for(int i=0; i<contour.size(); i++){
      PVector p = contour.get(i);
      lines[i] = p.x + " " + p.y;
    }
    saveStrings("contour.txt", lines);
  }else if(key=='r'){
    String [] lines = loadStrings("contour.txt");
    for(String line : lines){
      String [] ab = split(line, ' ');
      contour.add( new PVector(float(ab[0]), float(ab[1])) );
    }
  }else if(key=='h'){
    for(int i=0; i<contour.size()-1; i++){
      PVector prev = contour.get(i), next = contour.get(i+1);
      float dx = prev.x - next.x, dy = prev.y - next.y;
      if(abs(dx)>abs(dy)*4) horizon.add(i);
      if(abs(dy)>abs(dx)*4) vertical.add(i);
    }
  }else if(key=='p'){
    for(int i=0; i<contour.size()-2; i++){
      PVector p0 = contour.get(i), p1 = contour.get(i+1), p2 = contour.get(i+2);
      PVector v1 = PVector.sub(p1,p0), v2 = PVector.sub(p2,p1);
      if( degrees(PVector.angleBetween(v1, v2)) > 50 ){
        sharpPoint.add(i+1);
      }
    }
  }
}
ArrayList<Integer> horizon = new ArrayList<Integer>();
ArrayList<Integer> vertical = new ArrayList<Integer>();
ArrayList<Integer> sharpPoint = new ArrayList<Integer>();
