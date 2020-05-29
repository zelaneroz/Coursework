/** A class that represents the game Chutes and Ladders */
public class ChutesAndLadders {
  
  /** represents the game board.  Each entry indicates where you jump to if you land here */
  private int[] board;
  
  /** represents the players, the value of the player is the square the player is on */
  private int[] players;
    
  /** Create and initialize the game 
    * @param numPlayers the number of players playing the game
    */
  public ChutesAndLadders(int numPlayers) {
    board = new int[101];
    
    for (int i = 1; i <= 100; i++) 
      board[i] = i;
    
    /** Create the ladders */
    board[1]  = 38;
    board[5]  = 14;
    board[9]  = 31;
    board[21] = 42;
    board[36] = 45;
    board[28] = 84;
    board[71] = 91;
    board[80] = 100;
    
    /** Create the chutes */
    board[98] = 78;
    board[95] = 75;
    board[87] = 24;
    board[49] = 11;
    board[62] = 19;
    
    /** Create the players, each starts off the board */
    players = new int[numPlayers];
    for (int i = 0; i < numPlayers; i++)
      players[i] = 0;
    
  }
  
  /**
   * Determines if a player wins the game
   * @param currentPlayer the player we are checking
   * @param players an array of all the players
   * @param board the gameboard
   * @return true if the current player is on the last square of the board
   */
  public static boolean isWinner(int currentPlayer, int[] players, int[] board) {
    return (players[currentPlayer] == board.length - 1);
  }
  
  /**
   * Returns the player that is the next one to play
   * @param currentPlayer the player that just finished taking a turn
   * @param players the array of all the players
   */
  public static int nextPlayer(int currentPlayer, int[] players) {
    return (currentPlayer + 1) % players.length;
  }
  
  /**
   * Move a player
   * @param currentPlayer the player to move
   * @param dieRoll the amount to move
   * @param players the list of players
   * @param board the game board
   * @return the new location for the player
   */
  public static int movePlayer(int currentPlayer, int dieRoll, int[] players, int[] board) {
    try {
      return board[players[currentPlayer] + dieRoll];
    }
    catch (ArrayIndexOutOfBoundsException e) {   // the roll went past 100
    }  // the player does not move
    return players[currentPlayer];
  }

  /**
   * play the game
   * @return the player that wins the game
   */
  public int playGame() {
    int currentPlayer = 0;
    Die d = new Die();
    
    // in a real game we probably do not want a look.  Instead we will have the game wait
    // for a button click or other action to indicate that a player is making a move
    while (!isWinner(currentPlayer, players, board)) {
      players[currentPlayer] = movePlayer(currentPlayer, d.roll(), players, board);
      currentPlayer = nextPlayer(currentPlayer, players);
    }
    return currentPlayer;
  }
  
  /**
   * Launch and play the Chutes and Ladders Game
   * @param the command line argument is how many players are to play the game.  The default is 4.
   */
  public static void main(String[] args) {
    int numPlayers;
    
    // get # of players from the command line arguments
    try {
      numPlayers = Integer.parseInt(args[0]);
    }
    catch (Exception e) {               // maybe print an error if the data is bad?
      numPlayers = 4;
    }
    
    // play the game and report the winner
    ChutesAndLadders game = new ChutesAndLadders(numPlayers);
    int winner = game.playGame();
    System.out.println("Player " + (winner + 1) + " won the game");
  }
}