import java.util.NoSuchElementException;
import java.util.Iterator;

/** the linked list class as an abstract data type */
public class LinkedList<T> implements Iterable<T> {
  
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
  
  /**
   * Print the contents of the linked list
   */
  public void printList() {
    LLNode<T> nodeptr = getFirstNode();
    while (nodeptr != null) {
      System.out.print(nodeptr.getElement() + " ");
      nodeptr = nodeptr.getNext();
    }
    System.out.println();
  }
  
  /**
   * Return an iterator for this linked list
   * @return an iterator for the list
   */
  public Iterator<T> iterator() {
    return new LinkedListIterator<T>(getFirstNode());
  }
  
  
  /** 
   * Print the contents of the input linked list (a static method)
   * An example of a static method declaring a generic.
   * @param list a linked list
   */
  public static <S> void printList(LinkedList<S> list) {
    LLNode<S> nodeptr = list.getFirstNode();
    while (nodeptr != null) {
      System.out.print(nodeptr.getElement() + " ");
      nodeptr = nodeptr.getNext();
    }
    System.out.println();
  }
  
  /** 
   * Print the contents of the input linked list (a static method)
   * An example of the generic type wildcard
   * @param list a linked list
   */
  public static void printList2(LinkedList<?> list) {
    LLNode<?> nodeptr = list.getFirstNode();
    while (nodeptr != null) {
      System.out.print(nodeptr.getElement() + " ");
      nodeptr = nodeptr.getNext();
    }
    System.out.println();
  }
  
  
  /**
   * Inserts an element into a list that is already in sorted order
   * @param element  the element we are inserting
   * @param list  the list we are inserting the element into, the list's elements are already sorted
   */
  public static <S extends Comparable<? super S>> void insertInOrder(S element, LinkedList<S> list) {
    // 2 cases, the element goes in the front of the list, the element does not go in the front
    if (list.isEmpty() || element.compareTo(list.getFirstNode().getElement()) <= 0) {
      list.addToFront(element);
    }
    else {
      // loop to find the place where we add element
      LLNode<S> nodeptr = list.getFirstNode();
      while (nodeptr.getNext() != null && nodeptr.getNext().getElement().compareTo(element) < 0) {
        nodeptr = nodeptr.getNext();
      }
      // we stop when either we are at the end, or the next node is larger than the element
      nodeptr.setNext(new LLNode<S>(element, nodeptr.getNext()));
    }
    
  }
}