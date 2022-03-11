import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_MINES = 40;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public int NUM_SAFE = (NUM_ROWS*NUM_COLS)-NUM_MINES;
public boolean over = false;
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  setMines();
}
public void setMines()
{
  for (int i = 0; i < NUM_MINES; i++) { // there are currently 15 mines
    int rowm = (int)(Math.random()*NUM_ROWS);
    int colm = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[rowm][colm])) {
      mines.add(buttons[rowm][colm]);
      //System.out.print(rowm + " "); //This says where the rows of the mines are
      //System.out.println(colm);     //This says where the cols of the mines are
    } else i--;
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{  
  int count = 0;
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if (buttons[r][c].isClicked()==true) {
        count++;
      }
    }
  }
  if (count == (NUM_ROWS*NUM_COLS)-NUM_MINES)
    return true;
  //if all spaces that is not a mine is clicked return true
  return false;
}
public void displayLosingMessage()
{
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if (buttons[r][c].isClicked()==false) {
        buttons[r][c].mousePressed();
      }
      buttons[0][0].setLabel("F");
      buttons[0][1].setLabel("A");
      buttons[0][2].setLabel("I");
      buttons[0][3].setLabel("L");
    }
  }
}
public void displayWinningMessage()
{

  buttons[0][0].setLabel("W");
  buttons[0][1].setLabel("I");
  buttons[0][2].setLabel("N");
  buttons[0][3].setLabel("N");
  buttons[0][4].setLabel("E");
  buttons[0][5].setLabel("R");
}
public boolean isValid(int r, int c)
{
  if (r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
    return true;
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row, col) == true) {
    if (isValid(row-1, col-1) == true) {
      if (mines.contains(buttons[row-1][col-1])) {
        numMines++;
      }
    }
    if (isValid(row-1, col) == true) {
      if (mines.contains(buttons[row-1][col])) {
        numMines++;
      }
    }
    if (isValid(row-1, col+1) == true) {
      if (mines.contains(buttons[row-1][col+1])) {
        numMines++;
      }
    }
    if (isValid(row, col-1) == true) {
      if (mines.contains(buttons[row][col-1])) {
        numMines++;
      }
    }
    if (isValid(row, col+1) == true) {
      if (mines.contains(buttons[row][col+1])) {
        numMines++;
      }
    }
    if (isValid(row+1, col-1) == true) {
      if (mines.contains(buttons[row+1][col-1])) {
        numMines++;
      }
    }
    if (isValid(row+1, col) == true) {
      if (mines.contains(buttons[row+1][col])) {
        numMines++;
      }
    }
    if (isValid(row+1, col+1) == true) {
      if (mines.contains(buttons[row+1][col+1])) {
        numMines++;
      }
    }
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    if (mouseButton == LEFT) {
      if (clicked==false) {
        NUM_SAFE--;
      }
      clicked =true;
    }
    if (mouseButton == RIGHT) {
      flagged=!flagged;
      if (flagged==false)
        clicked = false;
    } else if (mines.contains(this)) {
      over = true;
      displayLosingMessage();
    } else if (countMines(myRow, myCol) > 0) {
      setLabel(countMines(myRow, myCol));
    } else {
      if (isValid(myRow-1, myCol-1) && buttons[myRow-1][myCol-1].clicked==false) {
        buttons[myRow-1][myCol-1].mousePressed();
      }
      if (isValid(myRow-1, myCol) && buttons[myRow-1][myCol].clicked==false) {
        buttons[myRow-1][myCol].mousePressed();
      }
      if (isValid(myRow-1, myCol+1) && buttons[myRow-1][myCol+1].clicked==false) {
        buttons[myRow-1][myCol+1].mousePressed();
      }
      if (isValid(myRow, myCol-1) && buttons[myRow][myCol-1].clicked==false) {
        buttons[myRow][myCol-1].mousePressed();
      }
      if (isValid(myRow, myCol+1) && buttons[myRow][myCol+1].clicked==false) {
        buttons[myRow][myCol+1].mousePressed();
      }
      if (isValid(myRow+1, myCol-1) && buttons[myRow+1][myCol-1].clicked==false) {
        buttons[myRow+1][myCol-1].mousePressed();
      }
      if (isValid(myRow+1, myCol) && buttons[myRow+1][myCol].clicked==false) {
        buttons[myRow+1][myCol].mousePressed();
      }
      if (isValid(myRow+1, myCol+1) && buttons[myRow+1][myCol+1].clicked==false) {
        buttons[myRow+1][myCol+1].mousePressed();
      }
    }
  }
  public void draw () 
  {  
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
    //System.out.print(NUM_SAFE);
    //System.out.print(" ");
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
  public boolean isClicked() {
    return clicked;
  }
}
