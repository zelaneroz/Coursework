import java.util.NoSuchElementException;
import java.util.Iterator;

/** An example of a linked list using a static nested class for the nodes */
public class List1<T> implements Iterable<T> {

  // the first node of the linked list
  private Node<T> firstNode;
  
  /** Create an empty linked list */
  public List1() {
    firstNode = null;
  }
  
  /** 
   * returns the first node of the list
   * @return the first node of the list
   */
  protected Node<T> getFirstNode() {
    return firstNode;
  }
  
  /**
   * sets a new first node of the list
   * @param node the node that is now the start of the linked list
   */
  protected void setFirstNode(Node<T> node) {
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
    setFirstNode(new Node<T>(element, getFirstNode()));
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
    Node<T> nodeptr = getFirstNode();
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
    Node<T> nodeptr = getFirstNode();
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
    // create an anonymous class that implements the Iterator interface
    return new Iterator<T>() {
      
      private Node<T> nodeptr = List1.this.getFirstNode();
      
      public boolean hasNext() {
        return nodeptr != null;
      }
      
      public T next() {
        if (!hasNext())
          throw new NoSuchElementException();
        
        T element = nodeptr.getElement();
        nodeptr = nodeptr.getNext();
        return element;
      }
    };
  }
  
  
  /** 
   * Print the contents of the input linked list (a static method)
   * An example of a static method declaring a generic.
   * @param list a linked list
   */
  public static <S> void printList(List1<S> list) {
    Node<S> nodeptr = list.getFirstNode();
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
  public static void printList2(List1<?> list) {
    Node<?> nodeptr = list.getFirstNode();
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
  public static <S extends Comparable<? super S>> void insertInOrder(S element, List1<S> list) {
    // 2 cases, the element goes in the front of the list, the element does not go in the front
    if (list.isEmpty() || element.compareTo(list.getFirstNode().getElement()) <= 0) {
      list.addToFront(element);
    }
    else {
      // loop to find the place where we add element
      Node<S> nodeptr = list.getFirstNode();
      while (nodeptr.getNext() != null && nodeptr.getNext().getElement().compareTo(element) < 0) {
        nodeptr = nodeptr.getNext();
      }
      // we stop when either we are at the end, or the next node is larger than the element
      nodeptr.setNext(new Node<S>(element, nodeptr.getNext()));
    }
    
  }
  
  /** A nested class (static) for the nodes of the linked list
    * A static element does not get the generic of the containing class
    */
  private static class Node<T> {
    private T element;
    private Node<T> next;
    
    /**
     * the constructor
     * @param element  the element to store in the node
     * @param next  a reference to the next node of the list 
     */
    public Node(T element, Node<T> next) {
      this.element = element;
      this.next = next;
    }
    
    /**
     * Returns the next node of the list
     * @return the next node of the list
     */
    public Node<T> getNext() {
      return next;
    }
    
    /**
     * Changes the node that comes after this node in the list
     * @param next  the node that should come after this node in the list.  It can be null.
     */
    public void setNext(Node<T> next) {
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
  
  
}