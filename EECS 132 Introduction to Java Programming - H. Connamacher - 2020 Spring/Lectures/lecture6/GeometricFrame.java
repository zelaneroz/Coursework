import javax.swing.JFrame;

/* This class does geometric stuff in a JFrame */
public class GeometricFrame extends JFrame {
  
  /* Transpose the height and width of the JFrame.
   * The return type is "void" because no value is returned */
  public void transpose() {
    this.setSize(this.getHeight(), this.getWidth());
  }
  
  /* Return true if this window has the same area as the input window */
  public boolean isSameArea(JFrame window) {
    int myArea = this.getWidth() * this.getHeight();
    int windowArea = window.getWidth() * window.getHeight();
    return (myArea == windowArea);
  }
}