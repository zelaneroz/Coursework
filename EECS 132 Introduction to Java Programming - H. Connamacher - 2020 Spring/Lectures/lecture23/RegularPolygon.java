/** An interface to indicate what shapes are regular polygons and to
  * provide the formula for calculating the area
  */
public interface RegularPolygon {
  
  /** Returns the number of angles of the polygon */
  int getNumberAngles();
  
  /** Returns the length of a side */
  double getSideLength();
  
  /** One way to implement the area of a regular polygon code in an interface:
    * As a static method
    * area = 1/4 (numAngles) * (sideLength)^2 * cot(pi/numAngles)
    */
  public static double areaOfRegularPolygon(RegularPolygon p) {
    return (p.getNumberAngles() * p.getSideLength() * p.getSideLength()) /
           (4 * Math.tan(Math.PI / p.getNumberAngles()));
  }
  
  /** A second way to implement the area of a regular polygon code in an interface:
    * As the default body for an abstract instance method
    * area = 1/4 (numAngles) * (sideLength)^2 * cot(pi/numAngles)
    */
  default double areaOfRegularPolygon() {
    return (this.getNumberAngles() * this.getSideLength() * this.getSideLength()) /
           (4 * Math.tan(Math.PI / this.getNumberAngles()));
  }
}