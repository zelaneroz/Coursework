/** A class to implement a hexagon: a 6 sided regular polygon */
public class Hexagon extends Polygon implements RegularPolygon {
   
  // stores the length of a side
  private double sideLength;
  
  /** The constructor to create the hexagon with a specified length */
  public Hexagon(double sideLength) {
    super(6);
    this.sideLength = sideLength;
  }
  
  /** Return the perimeter of the hexagon */
  @Override
  public double perimeter() {
    return getSideLength() * getNumberAngles();
  }
  
  /** Return the area of the hexagon */
  @Override
  public double area() {
    return areaOfRegularPolygon();
    // return RegularPolygon.areaOfRegularPolygon(this);
  }
  
  /** Return the length of a side of the hexagon */
  @Override
  public double getSideLength() {
    return sideLength;
  }
  
  /** Change the length of a side of a hexagon */
  public void setSideLength(double sideLength) {
    this.sideLength = sideLength;
  }
}