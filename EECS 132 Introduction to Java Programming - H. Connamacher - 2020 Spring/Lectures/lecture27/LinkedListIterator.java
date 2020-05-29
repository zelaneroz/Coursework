import java.util.Iterator;

/** Creates an iterator so that code outside of the linked list can loop through the linked list */
public class LinkedListIterator<T> implements Iterator<T> {
  
  /** Stores the current position in the list of our loop */
  private LLNode<T> nodeptr;
  
  /**
   * Creates the iterator starting at the input node
   * @param firstNode the node at which our loop will start
   */
  public LinkedListIterator(LLNode<T> firstNode) {
    nodeptr = firstNode;
  }
  
  /**
   * Generalizes the loop condition for a linked list loop.
   * @return true if the loop should keep going because we are not yet at the end of the list
   */
  public boolean hasNext() {
    return nodeptr != null;
  }
  
  
  /**
   * Generalizes the increment of the loop.  This method should throw an exception if we are at the end of the loop.
   * @return the next value in the list
   */
  public T next() {
    T element = nodeptr.getElement();
    nodeptr = nodeptr.getNext();
    return element;
  }
}