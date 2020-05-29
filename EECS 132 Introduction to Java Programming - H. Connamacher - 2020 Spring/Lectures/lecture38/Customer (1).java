import java.util.Optional;
import java.util.function.Function;

/** A customer can have up to 3 utilities.
  * This is an example of "wrapping" objects in an Optional object so that we 
  * do not have to directly test for null.
  */
public class Customer {
  
  private Optional<Utility> gas      = Optional.empty();
  private Optional<Utility> water    = Optional.empty();
  private Optional<Utility> electric = Optional.empty();
  
  public Optional<Utility> getGas() {
    return gas;
  }
  
  public Optional<Utility> getWater() {
    return water;
  }
  
  public Optional<Utility> getElectric() {
    return electric;
  }
  
  public void setGas(Utility u) {
    gas = Optional.ofNullable(u);
  }
  
  public void setElectric(Utility u) {
    electric = Optional.ofNullable(u);
  }
  
  public void setWater(Utility u) {
    water = Optional.ofNullable(u);
  }
  
  /** total the balance of each utility, using Optional so we don't have to test for null
    */
  public double getTotal() {
    double total = 0;
    Function<Utility, Double> getBalance = u -> u.getBalance();

    // here is an example of using the "andThen" to tack functions on functions
    // in this example, it gets the balance, subrtracts 1, and then doubles the value
    // total += getGas().map(getBalance.andThen(v -> v - 1).andThen(v -> v * 2)).orElse(0.0);
    
    total += getGas()     .map(getBalance).orElse(0.0);
    total += getElectric().map(getBalance).orElse(0.0);
    total += getWater()   .map(getBalance).orElse(0.0);
    
    return total;
  }
  
  /**
   * Adds an amount to each utilitie's balance, if the utility exists.
   * An example using Optional with a lambda shortcut.
   */
  public void payAll(double amount) {
    getGas()     .ifPresent(u -> u.updateBalance(amount));
    getElectric().ifPresent(u -> u.updateBalance(amount));
    getWater()   .ifPresent(u -> u.updateBalance(amount));
  }
}
    