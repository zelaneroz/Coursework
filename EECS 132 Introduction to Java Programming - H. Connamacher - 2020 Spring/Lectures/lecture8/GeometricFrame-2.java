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
  
  /* Scale the window size by a scaling factor */
  public void scale(double factor) {
    int newWidth  = (int)(this.getWidth() * factor);
    int newHeight = (int)(this.getHeight() * factor);
    this.setSize(newWidth, newHeight);
  }
  
  /* A field to remember the original window title */
  private String originalTitle = "";
  
  /* A field to remember if the size is on the title */
  private boolean isSizeOnTitle = false;
  
  /* Place the size of the window, in text, on the title bar */
  public void showSizeOnTitle(boolean show) {
    if (show)
      super.setTitle(this.originalTitle + " (" + this.getWidth() + ", " + this.getHeight() + ")"); // put the size on the title
    else
      super.setTitle(this.originalTitle); // remove the size from the title
    this.isSizeOnTitle = show;
  }
  
  /* Change the setSize method to have it also change the size displayed
   * on the title */
  public void setSize(int width, int height) {
    super.setSize(width, height);
    this.showSizeOnTitle(this.isSizeOnTitle);
  }
  
  /* Change the setTitle method to have it store the original title */
  public void setTitle(String title) {
    this.originalTitle = title;
    this.showSizeOnTitle(this.isSizeOnTitle);
  }
}