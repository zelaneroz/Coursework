/**
 * The node of a linked list
 */
public class LLNode<T> {
  /** the element stored in the node */
  private T element;
  
  /** a reference to the next node of the list */
  private LLNode<T> next;
  
  /**
   * the constructor
   * @param element  the element to store in the node
   * @param next  a reference to the next node of the list 
   */
  public LLNode(T element, LLNode<T> next) {
    this.element = element;
    this.next = next;
  }
  
  /**
   * Returns the next node of the list
   * @return the next node of the list
   */
  public LLNode<T> getNext() {
    return next;
  }
  
  /**
   * Changes the node that comes after this node in the list
   * @param next  the node that should come after this node in the list.  It can be null.
   */
  public void setNext(LLNode<T> next) {
    this.next = next;
  }
  
  /**
   * Returns the element stored in the node
   * @return the element stored in the node
   */
  public T getElement() {
    return element;
  }
  
  /**
   * Changes the element stored in the node
   * @param element the new element to store in the node
   */
  public void setElement(T element) {
    this.element = element;
  }
}
