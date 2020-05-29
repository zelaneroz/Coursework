import java.util.Iterator;

/** An example of using the forEachReamining function of iterator with a lambda shortcut */
public class EmployeeStuff {
  
  /** Give every employee in the list a raise of "raise" dollars per hour 
    * @param list the list of hourly employees
    * @param raise the amount to increase the pay of each employee
    */
  public void giveRaise(LinkedList<HourlyEmployee> list, double raise) {
    list.iterator().forEachRemaining(e -> e.setHourlyRate(e.getHourlyRate() + raise));
  }
}