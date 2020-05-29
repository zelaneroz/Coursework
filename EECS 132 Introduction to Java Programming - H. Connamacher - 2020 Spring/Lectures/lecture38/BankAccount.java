/**
 * A class to simulate a bank account.  An example of threads.
 */
public class BankAccount {
  private static final int initialAmount = 1000;         // the initial balance of the account
  private int balance = initialAmount;                   // the current balance of the account
  private int totalDeposits = 0;                         // the total amount deposited
  private int totalWithdraws = 0;                        // the total amount withdrawn
  
  /**
   * deposit money in the account
   * @param amount the amount to deposit
   */
  public void deposit (int amount) {
    balance += amount;                    // modify the balance
    totalDeposits += amount;
  }
  
  /**
   * withdraw money from the account
   * @param amount the amount to withdraw
   */
  public void withdraw (int amount) {
    balance -= amount;                   // modify the balance
    totalWithdraws += amount;
  }
  
  /**
   * do a whole bunch of small deposits
   */
  public void doDeposits() {
    for (int i = 0; i < 1000000; i++) {
      deposit((int)(Math.random() * 10)+1);
    }
  }
  
  /**
   * do a whole bunch of small withdraws
   */
  public void doWithdraws() {
    for (int i = 0; i < 1000000; i++) {
      withdraw((int)(Math.random() * 10)+1);
    }
  }
  
  /**
   * Prints what the balance is and what it should be.
   */
  public void checkBalance() {
    System.out.println("Final balance: " + balance);
    System.out.println("Initial " + initialAmount + " + deposits of " + totalDeposits +
                       " - withdraws of " + totalWithdraws + " = " +
                       (initialAmount + totalDeposits - totalWithdraws));
  }
  
  /**
   * The main method to run the bank simulation.
   * @param args  the command line arguments are ignored
   */
  public static void main(String[] args) {
    BankAccount account = new BankAccount();    // create an account

    account.doDeposits();                       // do a bunch of deposits
    
    account.doWithdraws();                      // do a bunch of withdraws
    
    account.checkBalance();                     // verify the balance
  }
}
 
