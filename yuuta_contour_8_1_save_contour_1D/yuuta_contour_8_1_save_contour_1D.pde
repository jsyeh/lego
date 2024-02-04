ArrayList<PVector> contour = new ArrayList<PVector>();

void setup(){
  size(512,512);
}

void draw(){
  background(#FFFFF2);
  for(PVector p : contour){
    ellipse(p.x, p.y, 3, 3);
  }
}

void mouseDragged(){
  contour.add( new PVector(100, mouseY) );
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
  }
}
