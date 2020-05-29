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
}