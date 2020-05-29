/** Another possible implementation of a square */
public class Square2 extends Rectangle {
  
  /** Create a square with a side length */
  public Square2(double sideLength) {  
    super(sideLength, 0);              // we are using just the width for the side length
  }
  
  /** Set the length of a square (it also sets the width) */
  @Override
  public void setLength(double length) {
    setWidth(length);
  }
  
  /** Get the length of a square (which is always equal to the width) */
  @Override
  public double getLength() {
    return getWidth();
  }
}