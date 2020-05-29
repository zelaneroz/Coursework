/** An implementation of a Square */
public class Square1 extends Rectangle implements RegularPolygon {
  
  /** A constructor that creates a square of a specific size */
  public Square1(double sideLength) {
    super(sideLength, sideLength);  // we set the length equal to the width
  }
  
  /** Change the length of a square, it also changes the width */
  @Override
  public void setLength(double length) {
    super.setLength(length);
    super.setWidth(length);
  }
  
  /** Change the width of a square, it also changes the length */
  @Override
  public void setWidth(double width) {
    super.setLength(width);
    super.setWidth(width);
  }
  
  /** Returns the side length, required by RegularPolygon */
  public double getSideLength() {
    return getLength();
  }
}