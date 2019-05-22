import java.util.*;
BufferedReader reader;

public class Model
{
  //public float[][] v;
  private String line;
  //private List<Float> vX = new ArrayList<Float>();
  //private List<Float> vY = new ArrayList<Float>();
  //private List<Float> vZ = new ArrayList<Float>();
  private List<Vec3iCoord> Vscreen = new ArrayList<Vec3iCoord>();
  private List<Vec3f> Vworld = new ArrayList<Vec3f>();

  //private List<Integer> f1 = new ArrayList<Integer>();
  //private List<Integer> f2 = new ArrayList<Integer>();
  //private List<Integer> f3 = new ArrayList<Integer>();
  private List<Vec3iFace> F = new ArrayList<Vec3iFace>();

  //public float getvX(int n) { return vX.get(n); }
  //public float getvY(int n) { return vY.get(n); }
  //public float getvZ(int n) { return vZ.get(n); }
  public Vec3iCoord getVtxS(int n) { return Vscreen.get(n); }
  public Vec3f getVtxW(int n) { return Vworld.get(n); }
  public int getVtxCount() { return Vscreen.size(); }
  
  //public int getf1(int n) { return f1.get(n); }
  //public int getf2(int n) { return f2.get(n); }
  //public int getf3(int n) { return f3.get(n); }
  public Vec3iFace getFace(int n) { return F.get(n); }
  public int getFaceCount() { return F.size(); }


  private int v = 0;
  private int f = 0;
  
  Model(String fileName)
  {
    reader = createReader(fileName);
    line = "";
    
    while(line != null)
    {
      try { line = reader.readLine(); }
      catch (IOException e) { e.printStackTrace(); line = null; }
      if (line == null) { noLoop(); }
      else
      {
        // Parsing vertexes
        if (match(line, "v ") != null)
        {
          String vertex[] = line.split(" ");
          //vX.add(Float.parseFloat(vertex[1]));
          //vY.add(Float.parseFloat(vertex[2]));
          //vZ.add(Float.parseFloat(vertex[3]));
          Vworld.add(new Vec3f(Float.parseFloat(vertex[1]), 
                               Float.parseFloat(vertex[2]), 
                               Float.parseFloat(vertex[3])));
          Vscreen.add(new Vec3iCoord(Math.round((Float.parseFloat(vertex[1]) + 1) * width / 2), 
                                     Math.round((Float.parseFloat(vertex[2]) + 1) * height / 2), 
                                     Math.round((Float.parseFloat(vertex[3]) + 1) * 255 / 2)));
          //println("Xw is " + (Vworld.get(v).x * width / 2) + ", Yw is " + Vworld.get(v).y + ", Zw is " + Vworld.get(v).z);
          //println("Xs is " + Vscreen.get(v).x + ", Ys is " + Vscreen.get(v).y + ", Zs is " + Vscreen.get(v).z);

          v++;
        }
        // Parsing faces
        if (match(line, "f ") != null)
        {
          String faces[] = line.split(" ");
          //f1.add(Integer.parseInt(faces[1].split("/")[0]));
          //f2.add(Integer.parseInt(faces[2].split("/")[0]));
          //f3.add(Integer.parseInt(faces[3].split("/")[0]));
          F.add(new Vec3iFace(Integer.parseInt(faces[1].split("/")[0]),
                              Integer.parseInt(faces[2].split("/")[0]),
                              Integer.parseInt(faces[3].split("/")[0])));
          //println("F1 is " + F.get(f).face1 + ", F2 is " + F.get(f).face2 + ", F3 is " + F.get(f).face3);
          f++;
        }
      }
    }
  }
  

}
