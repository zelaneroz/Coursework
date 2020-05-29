/** A class to represent a rectangle */
public class Rectangle extends Polygon {
  
  /* store the length */
  private double length;
  
  /* store the width */
  private double width;
  
  /** A constructor to create the rectangle with a width and length */
  public Rectangle(double width, double length) {
    super(4);
    this.width = width;
    this.length = length;
  }
  
  /** Gets the length of the rectangle */
  public double getLength() {
    return length;
  }
  
  /** Changes the length of the rectangle */
  public void setLength(double length) {
    this.length = length;
  }
  
  /** Gets the width of the rectangle */
  public double getWidth() {
    return width;
  }
  
  /** Changes the width of the rectangle */
  public void setWidth(double width) {
    this.width = width;
  }
  
  /** Returns the perimeter of the rectangle */
  @Override
  public double perimeter() {
    return 2 * (getLength() + getWidth());
  }
  
  /** Returns the area of a rectangle */
  @Override
  public double area() {
    return getLength() * getWidth();
  }
  
  /** Double the length of rectangle */
  public void doubleLength() {
    setLength(getLength() * 2);
  }
}