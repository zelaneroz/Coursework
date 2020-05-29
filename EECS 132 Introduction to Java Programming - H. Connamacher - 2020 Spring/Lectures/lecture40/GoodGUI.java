import javafx.application.Application;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.concurrent.Task;


/**
 * An example of a good GUI.  All code to update the display is executed in the swing
 * "event dispatch thread".  All other code is executed in a different thread.  As a result,
 * the GUI will respond properly even if there is a lot of stuff being done by the program.
 */

public class GoodGUI extends Application {
  private static final int SORTSIZE = 100000;
  private int clickCount = 0;
  private int sortCount = 0;
  
  /**
   * Create a frame with two buttons.  One records how often it is clicked.  The other lauches
   * a really slow sort routine and a progress bar that tracks the sort.
   */
  public void start(Stage primaryStage) {
    Button but1 = new Button("Clicked 0 times");
    Button but2 = new Button("Start sort");
    BorderPane borderPane = new BorderPane();
    GridPane sortPanel = new GridPane();
    borderPane.setTop(but1);
    borderPane.setCenter(sortPanel);
    borderPane.setBottom(but2);
    
    // button 1 will update itself with the number of times it is clicked
    but1.setOnAction(e -> ((Button)(e.getSource())).setText("Clicked " + (++clickCount) + " times"));
    
    // button 2 will start a sort and have a progress bar track the sort
    but2.setOnAction(e -> {
        ProgressBar bar = new ProgressBar();
        sortPanel.add(new Label("Sort " + ++sortCount), 1, sortCount);
        sortPanel.add(bar, 2, sortCount);
        primaryStage.sizeToScene();
        
        // Create a Task that does the slow sort so that we move it off of the JavaFX application thread
        Task<Void> task = new Task<Void>() {
          protected Void call() throws Exception {
            int[] a = new int[SORTSIZE];
            for (int i = 0; i < a.length; i++) {
              a[i] = (int)(Math.random() * a.length);
            }
            slowSort(a);
            return null;
          }
          
          // a very slow sort.  We move it inside the Task so we can call updateProgress
          private void slowSort(int[] array) {
            // this loop is a really slow way to sort
            for (int i = 0; i < array.length - 1; i++) {
              int min = i;
              for (int j = i + 1; j < array.length; j++) {
                if (array[j] < array[min])
                  min = j;
              }
              int temp = array[i];
              array[i] = array[min];
              array[min] = temp;
              
              if (((i + 1) % 500) == 0)           // update the progress bar each 500 elements
                updateProgress(i, array.length - 1);
            }
          } 
        };
        
	// We "bind" the task's progress "property" to the progress bar's "progress" property
        // so that when task's progress field is updated, bar's progress field also changes
        bar.progressProperty().bind(task.progressProperty());
        
        // Place the task in a thread and start it
        Thread thread = new Thread(task);
        thread.start();
      });
    
    Scene scene = new Scene(borderPane);
    primaryStage.setScene(scene);
    primaryStage.show();
  }
  
  /**
   * Launches the GUI
   */
  public static void main(String[] args) {
    Application.launch(args);
  }
  
}











