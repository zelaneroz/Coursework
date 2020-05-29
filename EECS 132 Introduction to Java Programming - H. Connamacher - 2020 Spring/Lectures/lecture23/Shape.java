/** A type to represent a generic shape */
public abstract class Shape {
  
  /** returns the area of the shape */
  public abstract double area();
  
  /** returns the perimeter of the shape */
  public abstract double perimeter();
  
  /** compare the area of this shape to the input shape */
  public boolean isLargerThan(Shape s) {
    return this.area() > s.area();
  }
  
}