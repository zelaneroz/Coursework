/* A class that represents an employee.
 * 
 * Employees have names, numbers, and salaries
 */
public class Employee {
  // remember the employee name
  private String name;
  
  // remember the employee number
  private final int number;
  
  // store the employee salary
  private double salary;
  
  // store the last employee number used as a class field
  private static int lastEmployeeNumber = 0;
  
  /* A constructor to create an employee with a name */
  public Employee(String name) {
    this.name = name;
    this.number = Employee.lastEmployeeNumber + 1;
    lastEmployeeNumber = number;
  }
  
  /* A constructor to create an employee with a name and salary and a number */
  public Employee(String name, double salary, int number) {
    this.name = name;
    this.number = number;
    this.salary = salary;
    if (this.number > lastEmployeeNumber)
      lastEmployeeNumber = number;
  }
  
  /* Retrieve the name of the employee */
  public String getName() {
    return name;
  }
  
  /* Change the name of the employee */
  public void setName(String name) {
    this.name = name;
  }
  
  /* Retrieve the employee number */
  public int getNumber() {
    return number;
  }
  
  /* Retrieve the employee salary */
  public double getSalary() {
    return salary;
  }
  
  /* Change the salary for the employee */
  public void setSalary(double salary) {
    this.salary = salary;
  }
  
  /* Do I earn more than the input employee ? */
  public boolean earnsMoreThan(Employee e) {
    return this.getSalary() > e.getSalary();
  }
  
  /* Change the inherited method so that the default string representation
   * of an employee is the employee number, name, and salary
   */
  @Override
  public String toString() {
    return this.getNumber() + ": " + this.getName() + " earns " + this.getSalary();
  }
  
  /* Change the inherited method so that two employees are considered the same if 
   * they have the same employee number
   */
  @Override
  public boolean equals(Object o) {
    if (o instanceof Employee) {
      Employee e = (Employee)o;
      return this.getNumber() == e.getNumber();
    }
    else
      return false;
  }
}