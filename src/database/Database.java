package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Database {

  private String DBDriver;
  private String connString;
  private String DBUser;
  private String DBPassword;
  private Connection DBConn;
  private Statement stmt;
  

  public Database() {

	    DBDriver = "";
	    connString = "";
	    DBUser = "";
	    DBPassword = "";
	  }  
  /** Constructor
  *
  *  @param strDBDriver the name of the database driver
  *  @param strConn the connection string to the database
  *  @param strDBUser the name of the user that connects to the database
  *  @param strDBPassword the password of the user that connects to the database
  */
  public Database(String strDBDriver, String strConn, String strDBUser, String strDBPassword){

    DBDriver = strDBDriver;
    connString = strConn;
    DBUser = strDBUser;
    DBPassword = strDBPassword;
  }
  /**Accessor for the database driver
   * Returns the name of the database driver.    
   * @return the name of the database driver.
   
   */
 public String getDBDriver(){
  return DBDriver;
 }
 /**
  * Accessor for the connection string of the database
  * @return the connection string of the database.
  */
 public String getDBName(){
  return connString;
 }
 /**
  * Accessor for the username of the database
  * @return the username of the database.
  */
 public String getDBUser(){
  return DBUser;
 }
 /**
  * Accessor for the user password of the database
  * @return the user password of the database.
  */
 public String getDBPassword(){
  return DBPassword;
 }
 /**
  * Mutator
  * Sets the name of the database driver.  
  * @param strDBDriver the name of the database driver
  */
  public void setDBDriver(String strDBDriver){
   DBDriver = strDBDriver;
  }
  /**
   * Mutator
   * Sets the connection string of the database.  
   * @param strConn the name of the database driver.
     
   */
  public void setDBName(String strConn){
	  connString = strConn;
  }
  /**
   * Mutator
   * Sets the name of the database username.  
   * @param strDBUser the name of the database username.
     
   */
  public void setDBUser(String strDBUser){
   DBUser = strDBUser;
  }
  /**
   * Mutator
   * Sets the name of the database user password.  
   * @param strDBPassword the name of the database user password.
     
   */
  public void setDBPassword(String strDBPassword){
   DBPassword = strDBPassword;
  }

 /**
  * Load the database driver into memory.   
  * @return
  */
  public boolean DBManager(){
    try{
      Class.forName(DBDriver);
       }
    catch(ClassNotFoundException e) {
                        e.printStackTrace();
                        System.out.println("Eroare incarcare driver!\n" + e);
                        return false;
                }
    return true;
  }
  /**
   * Perform the connection to the database and create the statement object
   * @return 
   * @see Connection
   * @see Statement
   */
  public boolean SetConnection(){

    try{
       DBConn = DriverManager.getConnection(connString,DBUser,DBPassword);
       stmt = DBConn.createStatement();
       
    return true;
    }
    catch(SQLException e){
      e.printStackTrace();
      return false;
    }

  }
  
  public void beginTransaction(){
	  
	  try {
		DBConn.setAutoCommit(false);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  }
  public void endTransaction(){
	  
	  try {
		DBConn.commit();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  
  }
  public boolean CloseConnection(){
    try{
      stmt.close();
      DBConn.close();
      return true;
  }
  catch(SQLException e){
    e.printStackTrace();
    return false;
  }
  }
  /**
   * Returns a ResultSet object of a database table.  
   * The string argument must specify the query on the desired database table. 
   * <p>
   * @param  strQuery  the query obtained from the database.
   * @return the resultSet object of a database table.
   * @see ResultSet
   */
 
  public ResultSet getResultSet(String strQuery){

    try{
      ResultSet r = stmt.executeQuery(strQuery);
      return r;
    }
    catch(SQLException e){
      e.printStackTrace();
      return null;
    }
  }

  public ResultSet getResultSet(String strQuery, Statement stmt){

	    try{
	      stmt = DBConn.createStatement();
	      ResultSet r = stmt.executeQuery(strQuery);
	      return r;
	    }
	    catch(SQLException e){
	      e.printStackTrace();
	      return null;
	    }
	    
	  }
  public int getLastId(){
	  int autoIncKeyFromFunc = -1;
	  ResultSet rs = null;
	  try{
	    rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");

	    if (rs.next()) {
	        autoIncKeyFromFunc = rs.getInt(1);
	    } 
	    
	  }
	  catch(SQLException e) {System.out.println(e.getMessage());}
	  
	  return autoIncKeyFromFunc ;
  }

/**Perform operations of Insert and Update into the database
 * @param strSQL the sql command to be executed
 */
  public boolean modifyTabel(String strSQL)
  {
	  try {
		  stmt.executeUpdate(strSQL);
		  DBConn.commit();
		  return true;
	  }
	  catch(SQLException e) {
		  //e.printStackTrace();
		  return false;  
	   }

  }


}
