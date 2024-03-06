float s = 100;
size(500,500,P3D);
translate(width/2, height/2);
//rotateX(radians(90));
String [] lines = loadStrings("4-4cyli.dat");
for(String line : lines){
  String [] a = split(line, " ");
  if(a[0].equals("2")){
    beginShape(LINES);
    for(int i=0; i<2; i++){
      PVector p = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      vertex(p.x * s, p.y * s, p.z * s);
    }
    endShape();
  }else if(a[0].equals("3")){
    beginShape();
    for(int i=0; i<3; i++){
      PVector p = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      vertex(p.x * s, p.y * s, p.z * s);
    }
    endShape();
  }else if(a[0].equals("4")){
    beginShape();
    for(int i=0; i<4; i++){
      PVector p = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      vertex(p.x * s, p.y * s, p.z * s);
    }
    endShape();
  }
}
