void setup() {
  size(500, 500, P3D);
  //printMatrix();
  //getMatrix((PMatrix3D) null).print();
  PGraphics3D g = (PGraphics3D) this.g;
  g.modelview.print();
  g.camera.print();
  g.projection.print();
}
void draw(){
  background(255);
  pushMatrix();
    translate(width/2, height/2);
    rotateY(radians(frameCount));
    //noFill();
    stroke(0);
    box(200);
    pushMatrix();
      translate(100,100,100);
      lights(); noStroke(); fill(255); sphere(10);
    popMatrix();
    PVector c = updatePos(new PVector(100,100,100));
    println(c);
  popMatrix();
  
  pushMatrix();
    translate(-c.x/c.z*500, -c.y/c.z*500);//, c.z);
    //translate(-c.x, -c.y);
    noStroke();
    fill(255);
    lights();
    sphere(10);
  popMatrix();
  
}
PVector updatePos(PVector p){
  PGraphics3D g = (PGraphics3D) this.g;
  PMatrix3D now = new PMatrix3D();
  now.set(g.modelview);
  g.modelview.print();
  g.camera.print();
  g.projection.print();
  now.apply(g.projection);
//  now.set(g.projection);
//  now.apply(g.modelview);
  float [] p2 = {p.x, p.y, p.z, 1};
  float [] p3 = new float[4];
  float [] p4 = now.mult(p2,p3);
  return new PVector(p4[0]/p4[3], p4[1]/p4[3], p4[2]/p4[3]);
  //return now.mult(p, new PVector());
}
