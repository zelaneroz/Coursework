import java.util.NoSuchElementException;

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
  
  /** Remove the first element from the linked list
    * @return  thie first element of the list
    * @throws NoSuchElementException if the list is empty
    */
  public T removeFromFront() throws NoSuchElementException {
    if (isEmpty()) {
      throw new NoSuchElementException();
    }
    else {
      T save = getFirstNode().getElement();
      setFirstNode(getFirstNode().getNext());
      return save;
    }
  }
  
  /**
   * Return the number of elements stored in the linked list
   * @return the number of elements in the list
   */
  public int length() {
    LLNode<T> nodeptr = getFirstNode();
    int count = 0;   // count stores the number of nodes visited so far
    while (nodeptr != null) {
      nodeptr = nodeptr.getNext();
      count++;
    }
    return count;
  }
  
  
  
  
  
  
  
  
}