package actions;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;

import database.Configuration;
import database.Database;

public class GuestActions {

	private Database db;
	
	
	public GuestActions(){
		db = new Database(Configuration.driverName, Configuration.connURL, Configuration.userName, Configuration.password);
		db.DBManager();
		db.SetConnection();
	}
	
	public Vector<Item> loadItems(){
		Vector<Item> v = new Vector<Item>();
		Item it = new Item();
		
		String sqlQuery = "Select * from item";
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
	
		 try {
			while(rs.next()){
				it = new Item(rs.getString("isbn"),rs.getString("title"),
					rs.getString("author"),rs.getString("volume"),rs.getString("publisher"),
					rs.getInt("yearPublished"),rs.getDouble("price"));
				v.addElement(it);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		 return v;
	}
	
	public ArrayList<Item> searchByISBN(String ISBN)
	{	
		ArrayList<Item> its = new ArrayList<Item>();
		db.beginTransaction();
		String selectQuery = "Select * from item where ISBN = '"+ISBN+ "'";
		ResultSet rs = db.getResultSet(selectQuery);
		//System.out.println("ISBN "+ISBN);
		try {
			while (rs.next()){ 
				//System.out.println("found ISBN ");
				Item e = new Item(rs.getString("ISBN"),rs.getString("title"),rs.getString("author"),rs.getString("volume"),rs.getString("publisher"),rs.getInt("yearPublished"),rs.getDouble("price"));
				its.add(e);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return its;
	}
	
	public ArrayList<Item> searchByAuthor(String author)
	{	
		ArrayList<Item> its = new ArrayList<Item>();
		db.beginTransaction();
		String selectQuery = "Select * from item where author = '"+author+ "'";
		ResultSet rs = db.getResultSet(selectQuery);
		//System.out.println("author "+author);
		try {
			while (rs.next()){ 
				//System.out.println("found ISBN ");
				Item e = new Item(rs.getString("ISBN"),rs.getString("title"),rs.getString("author"),rs.getString("volume"),rs.getString("publisher"),rs.getInt("yearPublished"),rs.getDouble("price"));
				its.add(e);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return its;
	}
	
	public ArrayList<Item> searchByTitle(String title)
	{	
		ArrayList<Item> its = new ArrayList<Item>();
		db.beginTransaction();
		String selectQuery = "Select * from item where title = '"+title+ "'";
		ResultSet rs = db.getResultSet(selectQuery);
		//System.out.println("title "+title);
		try {
			while (rs.next()){ 
				//System.out.println("found ISBN ");
				Item e = new Item(rs.getString("ISBN"),rs.getString("title"),rs.getString("author"),rs.getString("volume"),rs.getString("publisher"),rs.getInt("yearPublished"),rs.getDouble("price"));
				its.add(e);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return its;
	}
	
	public void close(){
		db.CloseConnection();
	}
	

}
