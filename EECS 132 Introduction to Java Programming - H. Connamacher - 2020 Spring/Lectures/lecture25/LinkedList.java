/** the linked list class as an abstract data type */
public class LinkedList<T> {
  
  // the first node of the linked list
  private LLNode<T> firstNode;
  
  /** Create an empty linked list */
  public LinkedList() {
    firstNode = null;
  }
  
  /** 
   * returns the first node of the list
   * @return the first node of the list
   */
  protected LLNode<T> getFirstNode() {
    return firstNode;
  }
  
  /**
   * sets a new first node of the list
   * @param node the node that is now the start of the linked list
   */
  protected void setFirstNode(LLNode<T> node) {
    firstNode = node;
  }
  
  /** Is the linked list empty?
    * @return true if the linked list is empty
    */
  public boolean isEmpty() {
    return getFirstNode() == null; 
  }
  
  /** Add an element to the front of the linked list 
    * @param element the element to add
    */
  public void addToFront(T element) {
    setFirstNode(new LLNode<T>(element, getFirstNode()));
  }
}