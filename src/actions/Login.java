package actions;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.Configuration;
import database.Database;

public class Login {
	private Database db;

	public Login(){
		db = new Database(Configuration.driverName, Configuration.connURL, Configuration.userName, Configuration.password);
		db.DBManager();
		db.SetConnection();
	}
	
	public String loginUser(String email, String userPass){
		String user = "nu exista";
		Boolean gasit = false;
		String strQuery = "Select * from admin where email = '"+email+ "' and password = '"+userPass+"'";	
		ResultSet rs = db.getResultSet(strQuery);
		try{
			if (rs.next()) {
				user = "admin";
				gasit = true;
			}
		}
		catch(SQLException e){
			System.out.println("Eroare la logare!");
			//e.getMessage();
		}
		if(!gasit){
			String selectQuery = "Select * from customer where email = '"+email+ "' and password = '"+userPass+"'";
			ResultSet rs2 = db.getResultSet(selectQuery);
			try{
				if (rs2.next()) {
					user = "customer";
					gasit = true;
				}
			}
			catch(SQLException e){
				System.out.println("Eroare la logare!");
				//e.getMessage();
			}
		}
		return user;
	}
	
	public void close(){
		db.CloseConnection();
	}
	
}
