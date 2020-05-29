/** A program that averages numbers a user inputs from the command line */
public class Averager {
  
  /**
   * Takes strings that represents numbers and returns their average
   * @param values  strings representing numbers
   * @return the average of the input values
   * @throws ArithmeticException if there are no numbers to average
   */
  public static double average(String... values) {
    double sum = 0;
    int count = 0;
    for (int i = 0; i < values.length; i++) {
      try {
        sum += Integer.parseInt(values[i]);
        count++;
      }
      catch (NumberFormatException e) {
        try {                                                    // an example of try within a catch
          sum += (int)(Double.parseDouble(values[i]) +  0.5);    // but probably would want to just do Double.parseDouble
          count++;                                               // initially and not Integer.parseInt
        }
        catch (NumberFormatException e2) {                       // if the value is not a number, skip it
        }
      }
    }
    
    if (count == 0)                                              // we are going to throw an exception if there is a divide by 0
      throw new ArithmeticException();
    
    return sum / count;
  }
  
  /**
   * The main method to run the program
   * @param args  the command arguments are numbers that we are to average
   */
  public static void main(String[] args) {
    try {
      double avg = average(args);
      System.out.println("The average of the input is " + avg);
    }
    catch (ArithmeticException e) {
      System.out.println("You did not enter any numbers");
    }

  }
}