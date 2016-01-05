package actions;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.Configuration;
import database.Database;

public class Register {
	private Database db;
	public Register(){
		db = new Database(Configuration.driverName, Configuration.connURL, Configuration.userName, Configuration.password);
		db.DBManager();
		db.SetConnection();
	}
	
	public boolean registerUser(String strEmail, String strPassword,
			String strNume, String strPrenume, String strPhone){
		
		String strQuery = "Select * from customer where email = '"+strEmail+ "'";	
		ResultSet rs = db.getResultSet(strQuery);
		try{
			if (rs.next()) {
				return false;
			}
		}
		catch(SQLException e){
			System.out.println("Eroare la inregistrare!");
			//e.getMessage();
		}
		try{
			String insertQuery = "Insert into customer(password, firstName, lastName, phone, email) values ('"+strPassword+"', '"+ strPrenume+"', '"+strNume+"', '"+ strPhone+"', '"+strEmail+ "')";
			db.modifyTabel(insertQuery);
		}
		catch (Exception e) {
			return false;
		}
		return true;
	}
	
	public void close(){
		db.CloseConnection();
	}
	
}
