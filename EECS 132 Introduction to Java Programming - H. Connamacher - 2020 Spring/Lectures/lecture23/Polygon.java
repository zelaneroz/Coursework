/** A class to represent a polygon */
public abstract class Polygon extends Shape {
  
  /* store the number of angles in the polygon */
  private int numAngles;
  
  /** A constructor to set the number of angles */
  public Polygon(int numAngles) {
    this.numAngles = numAngles;
  }
  
  /** Return the number of angles */
  public int getNumberAngles() {
    return numAngles;
  }
}