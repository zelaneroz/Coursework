public class MyFirstClass extends Object {
  
  // this field will have a separate copy for each instance
  public int myInstanceField = 10;
  
  // this is a class field, one copy all instances share
  public static int myClassField = 1;
  
  public static int average(int x, int y) {
    int value = (x + y) / 2;
    return value;
  }
}
