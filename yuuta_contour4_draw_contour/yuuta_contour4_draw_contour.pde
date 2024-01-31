ArrayList<PVector> contour = new ArrayList<PVector>();
void setup(){
  size(512,512);
}
void draw(){
  background(#FFFFF2);
  for(int i=0; i<contour.size()-1; i++){
    PVector prev = contour.get(i), next = contour.get(i+1);
    line(prev.x, prev.y, next.x, next.y);
  }
  for(PVector p : contour){
    fill(128);
    ellipse(p.x, p.y, 3, 3);
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
  }
}
