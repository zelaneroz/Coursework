/* An hourly employee is an employee that gets paid by the hour */
public class HourlyEmployee extends Employee {
  
  // Store the amount earned per hour
  private double hourlyRate;
  
  // Store the number of hours worked
  private double hoursWorked;
  
  /* The constructor requires that we specify the name for the hourly employee */
  public HourlyEmployee(String name) {
    super(name);
  }
  
  /* Get the amount earned per hour */
  public void setHourlyRate(double hourlyRate) {
    this.hourlyRate = hourlyRate;
  }
  
  /* Set the number of hours worked */
  public void setHoursWorked(double hoursWorked) {
    this.hoursWorked = hoursWorked;
  }
  
  /* Get the number of hours worked */
  public double getHoursWorked() {
    return hoursWorked;
  }
  
  /* Get the amount earned per hour */
  public double getHourlyRate() {
    return hourlyRate;
  }
  
  /* Change how salary works so that the amount "earned" by an hourly employee
   * is the amount of hours worked times the amount paid per hour
   */
  public double getSalary() {
    return getHourlyRate() * getHoursWorked();
  }
}