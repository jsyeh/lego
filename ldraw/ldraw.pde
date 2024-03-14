float s = 8;
ArrayList<PVector[]> pts = new ArrayList<PVector[]>();
ArrayList<Integer> colors = new ArrayList<Integer>(); //改放真的色彩值，不放CODE index
ArrayList<Integer> current_color = new ArrayList<Integer>();
color [] table = new color[256];//改大一點，但又不能太大
void myReadDat(String filename){
  String filename2 = "";
  for(int i=0; i<filename.length(); i++){
    if(filename.charAt(i)=='\\') filename2 += '/';
    else filename2 += filename.charAt(i);
  }
  println(filename2);
  String [] lines = loadStrings(filename2);
  for(String line : lines){
    String [] a = split(line, " ");
    if(a[0].equals("2")||a[0].equals("3")||a[0].equals("4")){
      PVector[] pt = new PVector[int(a[0])];
      for(int i=0; i<int(a[0]); i++){
        pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
      }
      pts.add(pt);
      if(int(a[1])==16) colors.add(current_color.get(current_color.size()-1));
      else colors.add(table[int(a[1])]); //不放 CODE index，改放 color 值
      //colors.add(int(a[1]));
    } else if(a[0].equals("1")) {
      float [] m = new float[12];
      for(int i=0; i<12; i++) m[i] = float(a[2+i]);
      int prev = pts.size(); //讀入更多檔案之前

      if(int(a[1])==16) current_color.add(current_color.get(current_color.size()-1));
      else current_color.add(table[int(a[1])]); //push 顏色
      myReadDat(a[14]); //讀入新檔案
      current_color.remove(current_color.size()-1); //pop 顏色
      
      int after = pts.size(); //讀入更多檔案之後
      for(int i=prev; i<after; i++){
        PVector [] now = pts.get(i);
        for(PVector p : now){
          float x2 = m[3]*p.x + m[4]*p.y + m[5]*p.z + m[0];
          float y2 = m[6]*p.x + m[7]*p.y + m[8]*p.z + m[1];
          float z2 = m[9]*p.x + m[10]*p.y + m[11]*p.z + m[2];
          p.x = x2; 
          p.y = y2;
          p.z = z2;
        }
      }
    }
  }
}
void setup(){
  size(500,500,P3D);
  current_color.add(#FFFF80);
  table[0] = #000000;
  table[16] = #FFFF80;
  table[24] = #7F7F7F;
  table[32] = #000000;
  //myReadDat("stud4.dat");
  myReadDat("3626cp01.dat");
}
void mouseDragged(){
  rotY += mouseX - pmouseX;
  rotX -= mouseY - pmouseY;
}
float rotX = 0, rotY = 180;
void draw(){
  lights();
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  //rotateX(radians(frameCount));
  for(int i=0; i<pts.size(); i++){
  //for(PVector [] pt : pts){
    PVector[] pt = pts.get(i);
    color c = colors.get(i); //直接放 color 色彩，不再放 CODE index
    if(pt.length==2){
      beginShape(LINES);
      stroke(c); //改用正確的色彩
    } else if(pt.length==3 || pt.length==4) {
      beginShape();
      noStroke();
      fill(c);
    }
    for(PVector p : pt){
      vertex(p.x * s, p.y * s, p.z * s);
    }
    if(pt.length==2) endShape();
    else if(pt.length==3 || pt.length==4) endShape(CLOSE);
  }
}
