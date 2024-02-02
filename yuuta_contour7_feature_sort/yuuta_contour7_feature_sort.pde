ArrayList<PVector> contour = new ArrayList<PVector>();
void setup(){
  size(512,512);
}
void draw(){
  background(#FFFFF2);
  stroke(128);
  strokeWeight(1);
  for(int xx=0; xx<=16; xx++){
    line(xx*32, 0, xx*32, 512);
    line(0, xx*32, 512, xx*32);
  }
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
  for(Integer i : verticalEnd){
    PVector p = contour.get(i);
    fill(0,0,255);
    stroke(0);
    strokeWeight(1);
    ellipse(p.x, p.y, 10, 10);
  }
  for(Integer i : horizonEnd){
    PVector p = contour.get(i);
    fill(0,0,255);
    stroke(0);
    strokeWeight(1);
    ellipse(p.x, p.y, 10, 10);
  }
  for(PVector p : grey){
    fill(200);
    stroke(0);
    strokeWeight(1);
    ellipse(p.x, p.y, 10, 10);
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
    boolean startH = false, startV = false;
    for(int i=0; i<contour.size()-1; i++){
      PVector prev = contour.get(i), next = contour.get(i+1);
      float dx = prev.x - next.x, dy = prev.y - next.y;
      if(abs(dx)>abs(dy)*4){ //現在是了
        horizon.add(i);
        if(startH==false) horizonEnd.add(i);
        startH = true;
      }else{ //現在又不是了
        if(startH==true) horizonEnd.add(i);
        startH = false;
      }
      if(i==contour.size()-2 && startH==true) horizonEnd.add(i+1);
      
      if(abs(dy)>abs(dx)*4){
        vertical.add(i);
        if(startV==false) verticalEnd.add(i);
        startV = true;
      }else{
        if(startV==true) verticalEnd.add(i);
        startV = false;
      }
      if(i==contour.size()-2 && startV==true) verticalEnd.add(i+1);
    }
  }else if(key=='p'){
    for(int i=0; i<contour.size()-2; i++){
      PVector p0 = contour.get(i), p1 = contour.get(i+1), p2 = contour.get(i+2);
      PVector v1 = PVector.sub(p1,p0), v2 = PVector.sub(p2,p1);
      if( degrees(PVector.angleBetween(v1, v2)) > 50 ){
        sharpPoint.add(i+1);
      }
    }
  }else if(key=='g'){
    for(Integer i : sharpPoint){
      findNearest(i);
    }
    for(Integer i : horizonEnd){
      findNearest(i);
    }
    for(Integer i : verticalEnd){
      findNearest(i);
    }
    for(int i=0; i<greyI.size(); i++){
      for(int j=i+1; j<greyI.size(); j++){
        if(greyI.get(i)>greyI.get(j)){
          int temp = greyI.get(i);
          greyI.set(i, greyI.get(j));
          greyI.set(j, temp);
          PVector tempv = grey.get(i);
          grey.set(i, grey.get(j));
          grey.set(j, tempv);
        }
      }
    }
    for(Integer i : greyI){
      print(i + " ");
    }
  }
}
void findNearest(int i){
  PVector prev = contour.get(i);
  PVector ans = new PVector(0,0);
  for(int xx=0; xx<=16; xx++){
    if(abs(xx*32-prev.x)<abs(ans.x-prev.x)) ans.x = xx*32;
  }
  for(int yy=0; yy<=16; yy++){
    if(abs(yy*32-prev.y)<abs(ans.y-prev.y)) ans.y = yy*32;
  }
  grey.add(ans);  
  greyI.add(i);
}
ArrayList<Integer> greyI = new ArrayList<Integer>();
ArrayList<PVector> grey = new ArrayList<PVector>();
ArrayList<Integer> horizon = new ArrayList<Integer>();
ArrayList<Integer> vertical = new ArrayList<Integer>();
ArrayList<Integer> horizonEnd = new ArrayList<Integer>();
ArrayList<Integer> verticalEnd = new ArrayList<Integer>();
ArrayList<Integer> sharpPoint = new ArrayList<Integer>();
