float s = 8;
ArrayList<PVector[]> pts = new ArrayList<PVector[]>();
ArrayList<Integer> colors = new ArrayList<Integer>(); //改放真的色彩值，不放CODE index
ArrayList<Integer> current_color = new ArrayList<Integer>(); //現在的色彩
ArrayList<Integer> complement_color = new ArrayList<Integer>(); //現在的色彩，對應的互補色
color [] table = new color[256];//主要的色彩(面） TODO:改大一點，但又不能太大
color [] table2 = new color[256];//互補色（edge）的色彩
String[] myLoadStrings(String filename){ 
  File file = new File(dataPath(filename));
  if(!file.exists()) return null;
  else return loadStrings(filename);
} //使用我的 myLoadStrings()減少 loadStrings()的錯誤訊息
void myReadDat(String filename){
  String filename2 = "";
  for(int i=0; i<filename.length(); i++){
    if(filename.charAt(i)=='\\') filename2 += '/';
    else filename2 += filename.charAt(i);
  }
  String [] lines = myLoadStrings("parts/" + filename2);
  //if(lines==null) {lines = myLoadStrings("p/48/" + filename2);} //先不要管精細的部分
  if(lines==null) {lines = myLoadStrings("p/" + filename2);}
  if(lines==null) {lines = myLoadStrings("models/" + filename2);}
  
  for(String line : lines){
    String [] a = split(line, " ");
    if(a[0].equals("2")||a[0].equals("3")||a[0].equals("4")||a[0].equals("5")){
      int ptN = int(a[0]);
      PVector[] pt = new PVector[ptN]; //不是很好的寫法，還是準備了2,3,4,5個頂點，但5只用前4個
      for(int i=0; i<ptN; i++){
        if(ptN==5 && i==4){//特別針對輔助線 Line Type 5 其實只有 4 個頂點
          pt[i] = new PVector(); //無用的點
        }else{ //有用的點
          pt[i] = new PVector( float(a[2+i*3]), float(a[2+i*3+1]), float(a[2+i*3+2]) );
        }
      }
      pts.add(pt);
      if(int(a[1])==16){ //主要色
        colors.add(current_color.get(current_color.size()-1));
      }else if(int(a[1])==24){ //edge 互補色
        colors.add(complement_color.get(complement_color.size()-1));
      }
      else colors.add(table[int(a[1])]); //不放 CODE index，改放 color 值
    } else if(a[0].equals("1")) {
      float [] m = new float[12];
      for(int i=0; i<12; i++) m[i] = float(a[2+i]);
      int prev = pts.size(); //讀入更多檔案之前

      if(int(a[1])==16){
        current_color.add(current_color.get(current_color.size()-1));
        complement_color.add(complement_color.get(complement_color.size()-1));
      } else {
        current_color.add(table[int(a[1])]); //push 顏色
        complement_color.add(table[int(a[1])]);
      }
      myReadDat(a[14]); //讀入新檔案
      current_color.remove(current_color.size()-1); //pop 顏色
      complement_color.remove(complement_color.size()-1); 
      
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
  complement_color.add(#333333);
  table[0] = #000000;
  table[16] = #FFFF80;
  table[24] = #7F7F7F;
  table[32] = #000000;
  table2[0] = #333333;
  table2[16] = #333333;
  table2[24] = #333333;
  table2[32] = #333333;
  //myReadDat("stud4.dat");
  //myReadDat("3626cp01.dat");
  //myReadDat("3626bph9.dat");
  myReadDat("3626cpb9.dat");
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
    if(pt.length==2){ //請不要在這裡處理 Line Type 5
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
  
  //要計算 Line Type 5 輔助線，需找出 modelview matrix, camerea matrix, projection matrix
  // 幸運找到 printMatrix()
  // 再找到 getMatrix((PMatrix2D) null).print() 再猜到 getMatrix((PMatrix3D) null).print() 
  // 後來找到 printMatrix() 相似的 printCamera() printProjection()
  // 最後發現 PGraphicsOpenGL.java 有 modelview, camera, projection
  // 再找到 PApplet 裡有 PGraihcs g 結案
  PGraphics3D g = (PGraphics3D) this.g;
  //g.modelview.print(); //等價於 printMatrix();
  //g.camera.print(); //等價於 printCamera();
  //g.projection.print(); //等價於 prointProjection();
  //g.projmodelview.print();

  //想要畫 Line Type 5 Optional Line 輔助線(有時畫、有時不畫)
  for(int i=0; i<pts.size(); i++){
    PVector[] pt = pts.get(i);
    color c = colors.get(i); //直接放 color 色彩，不再放 CODE index
    if(pt.length==5){ //Line Type 5 只有前4個有效的頂點 點1 點2 輔助1 輔助2
      strokeWeight(1);
      strokeCap(ROUND);
      strokeJoin(ROUND);
      beginShape(LINES);
      stroke(c); //改用正確的色彩
      if(checkType5matrix(pt)){
        //line(pt[0].x, pt[0].y, pt[0].z, pt[1].x, pt[1].y, pt[1].z);
        for(int k=0; k<2; k++){ //只有前面2個頂點要畫
          PVector p = pt[k];
          vertex(p.x * s, p.y * s, p.z * s);
        }
      }
      endShape();
    }
  }
}
PVector myMult(PMatrix3D m, PVector p){
  PVector ans = new PVector();
  m.mult(p, ans);
  return ans;
}
boolean checkType5matrix(PVector [] p){
  PVector [] p2 = new PVector[4];
  PGraphics3D g = (PGraphics3D) this.g;
  for(int i=0; i<4; i++){
    p2[i] = myMult(g.projmodelview, p[i]);
  }
  return checkType5(p2);
}
boolean checkType5(PVector [] p){ //input是2D
  float x1 = p[0].x, y1 = p[0].y;
  float x2 = p[1].x, y2 = p[1].y;
  float a = -(y2-y1), b = (x2-x1), c = -y1 * (x2-x1) + x1 *  (y2-y1);
  // Step02-2 另外2點是控制點(代入方程式，看是否同向)
  return (a * p[2].x + b * p[2].y + c) * (a * p[3].x + b * p[3].y + c) >= 0;
}
