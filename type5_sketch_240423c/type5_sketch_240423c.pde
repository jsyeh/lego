// 如何把 3D 變成 2D?
// 先了解matrix矩陣: modelview 矩陣 (不用再管 camera矩陣，因它只受 camera()==gluLookAt()影響)
// modelview 矩陣 減一半，所以正中心的點，會得到 0 
//   x*1 再減一半，y*1 再減一半，z*1 再減sqrt(3)
PVector [] p = new PVector[4];
void setup(){
  size(300,300, P3D);
  p[0] = new PVector(250, 50);
  p[1] = new PVector(250,450);
  p[2] = new PVector(450, 100);
  p[3] = new PVector(0 ,0);
  PGraphics3D g = (PGraphics3D) this.g;
  //g.modelview.print();
  //g.camera.print();
  //不做任何 translate() rotate() scale() 時 camera==modelview
  g.projection.print(); //預設的矩陣
  // sqrt(3)是 1.7321
  // x*sqrt(3), y*-sqrt(3), z*??  
}

void draw(){
  background(#FFFFF2);
  ellipse(100,100, 10,10);
}

void mousePressed(){ //再印一次 projection matrix 以確認 default 值是它沒錯
  // https://processing.org/reference/perspective_.html
  // The default values are: perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0) 
  // where cameraZ is ((height/2.0) / tan(PI*60.0/360.0))
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0);
  // 張角60度，長寬比，近的、遠的
  PGraphics3D g = (PGraphics3D) this.g;
  g.modelview.print();
  g.projection.print();
  g.projmodelview.print(); //再印一次
}
