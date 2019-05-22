Model head;
RasterTrigon trigon;
//int depth = 255;

void setup()
{
  size(800, 800);
  background(color(0, 255, 0));
  trigon = new RasterTrigon();
  head = new Model("african_head.obj");


}

void draw()
{
  int r, g, b;
  Vec3f light_dir = new Vec3f(0, 0, 1);
  
  int zbuffer[] = new int[width * height];
  for (int i = 0; i < width * height; i++) { zbuffer[i] = java.lang.Integer.MIN_VALUE; }
  
  for (int i = 0; i < head.getFaceCount(); i++) 
  {
    Vec3i p0 = new Vec3i(width - head.getVtxS(head.getFace(i).face1 - 1).x, height - head.getVtxS(head.getFace(i).face1 - 1).y, head.getVtxS(head.getFace(i).face1 - 1).z);
    Vec3i p1 = new Vec3i(width - head.getVtxS(head.getFace(i).face2 - 1).x, height - head.getVtxS(head.getFace(i).face2 - 1).y, head.getVtxS(head.getFace(i).face2 - 1).z);
    Vec3i p2 = new Vec3i(width - head.getVtxS(head.getFace(i).face3 - 1).x, height - head.getVtxS(head.getFace(i).face3 - 1).y, head.getVtxS(head.getFace(i).face3 - 1).z);
                
    Vec3f A = Vec3f.minus(head.getVtxW(head.getFace(i).face2 - 1), head.getVtxW(head.getFace(i).face1 - 1));
    Vec3f B = Vec3f.minus(head.getVtxW(head.getFace(i).face3 - 1), head.getVtxW(head.getFace(i).face1 - 1));                    
    Vec3f C = Vec3f.crossProduct(A, B);
    Vec3f N = C.normalize();
    float intensity  = Vec3f.scalar(N, light_dir);
    
    r = Math.round(255 * intensity);
    g = Math.round(255 * intensity);
    b = Math.round(255 * intensity);
    if (intensity > 0)
      trigon.plotTriangle(p0, p1, p2, color(r, g, b), zbuffer);
      //trigon.plot(p0, p1, p2, color(r, g, b), zbuffer);


  }
  println("enddraw");
}
