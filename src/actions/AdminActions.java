package actions;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import database.Configuration;
import database.Database;
import utilizatori.Admin;
import utilizatori.Customer;

public class AdminActions {
	private Database db;
	
	public AdminActions(){
		db = new Database(Configuration.driverName, Configuration.connURL, Configuration.userName, Configuration.password);
		db.DBManager();
		db.SetConnection();
	}
	
	public Admin loadAdmin(String email){
		Admin admin = null;
		//System.out.println("Trying to load admin with email = "+email);
		db.beginTransaction();
		try{
			String sqlQuery = "Select * from admin where email='"+email+"'";
			ResultSet rs = db.getResultSet(sqlQuery);
			if (rs.next()){
				admin = new Admin(rs.getInt("adminID"),rs.getString("password"),
						rs.getString("email"),rs.getString("lastName"),
						rs.getString("firstName"));
			}
		}
		catch (Exception e) {
		}
		return admin;
	}
	
	//modifica parola
	public void modificaParola(String email, String newPass)
	{
		db.beginTransaction();
		try{
			String updateQuery = "Update admin set password = '"+ newPass + "' where email = '"+ email +"';";
			db.modifyTabel(updateQuery);
		}
		catch (Exception e) {
			//e.printStackTrace();
		}
	}
	
	//modifica numele
	public void modificaNume(String email, String nume)
	{
		db.beginTransaction();
		try{
			String updateQuery = "Update admin set lastName = '"+ nume + "' where email = '"+ email +"';";
			db.modifyTabel(updateQuery);
		}
		catch (Exception e) {
			//e.printStackTrace();
		}
	}
	
	//modifica prenumele
	public void modificaPrenume(String email, String prenume)
	{
		db.beginTransaction();
		try{
			String updateQuery = "Update admin set firstName = '"+ prenume + "' where email = '"+ email +"';";
			db.modifyTabel(updateQuery);
		}
		catch (Exception e) {
			//e.printStackTrace();
		}
	}
	
	
	public void addItem (Item i){
		db.beginTransaction();
		try{
			String insertQuery = "Insert into item(title,author,volume,publisher,yearPublished,ISBN,price, quantity) values ('"+i.getTitle()+"', '" + i.getAuthor() +"', '" + i.getVolume() +
					"', '" + i.getPublisher()+"', '" + i.getYearPublished()+"', '" + i.getIsbn()+"', '" + i.getPrice() +"',"+i.getQuantity()+")";
			db.modifyTabel(insertQuery);
		}
		catch (Exception e) {
		}
	}
	
	
	public void deleteItem (String isbn){
		db.beginTransaction();
		try{
			String deleteQuery = "Delete from item where ISBN = '"+ isbn +"'";
			db.modifyTabel(deleteQuery);
		}
		catch (Exception e) {
		}
	}
	
	public void editItem (String isbn, String p, String q){
		db.beginTransaction();
		int price,quant;
		String editQuery = null;
		try{
			if(p!="" && q!="")
			{
				price = Integer.parseInt(p);
				quant = Integer.parseInt(q);
				editQuery = "UPDATE item SET price = "+ price +", quantity = "+ quant +" WHERE ISBN = "+ isbn +"";
			}
			else
				if(p!="" && q=="")
				{
					price = Integer.parseInt(p);
					editQuery = "UPDATE item SET price = "+ price +" WHERE ISBN = "+ isbn +"";
				}
				else
					if(p=="" && q!="")
					{
						quant = Integer.parseInt(q);
						editQuery = "UPDATE item SET quantity = "+ quant +" WHERE ISBN = "+ isbn +"";
					}
			db.modifyTabel(editQuery);
		}
		catch (Exception e) {
		}
	}
	
	public Vector<Item> loadItems(){
		Vector<Item> vst = new Vector<Item>();
		Item st = new Item();
		
		String sqlQuery = "Select * from Item";
		
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
	
		 try {
			while(rs.next()){
				st = new Item(rs.getString("isbn"), rs.getString("title"), rs.getString("author"), rs.getString("volume"), rs.getString("publisher"), rs.getInt("yearPublished"),rs.getDouble("price"),rs.getInt("quantity"));
				vst.addElement(st);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		 return vst;
	}
	
	public Vector<Customer> loadCustomers(){
		Vector<Customer> vst = new Vector<Customer>();
		Customer st = new Customer();
		
		String sqlQuery = "Select * from customer";
		
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
	
		 try {
			while(rs.next()){
				st = new Customer(rs.getString("email"), rs.getString("password"), rs.getString("lastName"), rs.getString("firstName"), rs.getString("phone"));
				vst.addElement(st);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		 return vst;
	}
	
	

	public void close(){
		db.CloseConnection();
	}

}
