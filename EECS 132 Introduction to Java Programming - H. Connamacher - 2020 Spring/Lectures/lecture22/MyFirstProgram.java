/** Our first stand-alone program. */
public class MyFirstProgram {
  
  /* The main method to launch the program */
  public static void main(String[] args) {
    // In here we do what we would do in the interactions pane
    // to run the program.  Maybe we print a message:
    System.out.println("I am alive");
    
    // Print out the command line arguments
    System.out.println("The command line arguments are:");
    for (int i = 0; i < args.length; i++) 
      System.out.println(args[i]);
  }
}
