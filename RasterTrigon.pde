class RasterTrigon
{ 
  void plotTriangle(Vec3i t0, Vec3i t1, Vec3i t2, color c, int zbuffer[])
  {
    if (t0.y == t1.y && t0.y == t2.y) return; //<>//
    
    if (t0.y>t1.y) t1 = swap(t0, t0 = t1);
    if (t0.y>t2.y) t2 = swap(t0, t0 = t2);
    if (t1.y>t2.y) t2 = swap(t1, t1 = t2);
    
    int total_height = t2.y - t0.y;
    for (int i = 0; i < total_height; i++)
    {
      boolean second_half = i > t1.y - t0.y || t1.y == t0.y;
      int segment_height = second_half ? t2.y - t1.y
                                       : t1.y - t0.y;
      float alpha = (float)i / total_height;
      float beta  = (float)(i - (second_half ? t1.y - t0.y : 0)) / segment_height;
      Vec3i A =               Vec3i.plus(Vec3i.mul(Vec3i.minus(t2, t0), alpha), t0);
      Vec3i B = second_half ? Vec3i.plus(Vec3i.mul(Vec3i.minus(t2, t1), beta), t1)
                            : Vec3i.plus(Vec3i.mul(Vec3i.minus(t1, t0), beta), t0);
      if (A.x>B.x) B = swap(A, A = B);
      for (int j = A.x; j < B.x; j++) 
      { 
        float phi = B.x == A.x ? 1. 
                               : (float)(j - A.x) / (float)(B.x - A.x);
        Vec3i P = Vec3i.plus(Vec3i.mul(Vec3i.minus(B, A), phi), A);
        
        int idx = P.x + P.y * width;
        if (zbuffer[idx] < P.z)
        {
          zbuffer[idx] = P.z;
          set(P.x, P.y, c);
        }
      }
    }
  }


  
    
  private Vec2i swap(Vec2i a, Vec2i b) { return a; } // usage: y = swap(x, x=y);
  private Vec3i swap(Vec3i a, Vec3i b) { return a; } // usage: y = swap(x, x=y);

}
    
