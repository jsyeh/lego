float s = 100;
ArrayList<PVector[]> pts = new ArrayList<PVector[]>();
void myReadDat(String filename){
  String [] lines = loadStrings(filename);
  for(String line : lines){
    String [] a = split(line, " ");
    if(a[0].equals("2")){
      PVector[] pt = new PVector[2];
      for(int i=0; i<2; i++){
        pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      }
      pts.add(pt);
    }else if(a[0].equals("3")){
      PVector[] pt = new PVector[3];
      for(int i=0; i<3; i++){
        pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      }
      pts.add(pt);
    }else if(a[0].equals("4")){
      PVector[] pt = new PVector[4];
      for(int i=0; i<4; i++){
        pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      }
      pts.add(pt);
    }else if(a[0].equals("5")){ //輔助線 Optional line 只在邊界時畫
      for(int i=0; i<4; i++){
        PVector p = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      }//先不用它，因不知道是否在邊界、是否要畫
    }  
  }
}
void setup(){
  size(500,500,P3D);
  myReadDat("4-4edge.dat");
  myReadDat("4-4disc.dat");
  myReadDat("4-4cyli.dat");
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateX(radians(frameCount));
  for(PVector [] pt : pts){
    if(pt.length==2) beginShape(LINES);
    else if(pt.length==3 || pt.length==4) beginShape();
    for(PVector p : pt){
      vertex(p.x * s, p.y * s, p.z * s);
    }
    if(pt.length==2) endShape();
    else if(pt.length==3 || pt.length==4) endShape(CLOSE);
  }
}
