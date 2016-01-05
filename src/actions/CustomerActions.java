package actions;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;

import database.Configuration;
import database.Database;
import utilizatori.Address;
import utilizatori.Customer;
import utilizatori.Order;

public class CustomerActions {
	private Database db;
	
	
	public CustomerActions(){
		db = new Database(Configuration.driverName, Configuration.connURL, Configuration.userName, Configuration.password);
		db.DBManager();
		db.SetConnection();
	}

	
	public Customer loadCustomer(String email){
		Customer st =null;
		db.beginTransaction();
		try{
			String selectQuery = "Select * from customer where email = '"+email+ "'";
			ResultSet rs = db.getResultSet(selectQuery);
			//System.out.println("email "+email);
			try{
				if (rs.next()){
					//System.out.println("found customer ");
					
					st = new Customer(rs.getInt("customerID"), rs.getString("password"), rs.getString("email"), rs.getString("lastName"), rs.getString("firstName"), rs.getString("phone"), null, null);
					//System.out.println("cust pass "+st.getStrPassword());
					int sa = rs.getInt("shippingAddressID");
					int ba = rs.getInt("billingAddressID");
					Address shippingAddress = null;
					try {
						String sqlQuery2 = "Select * from address where addressID='"+sa+"'";
						ResultSet rs2 = db.getResultSet(sqlQuery2);
						if (rs2.next()){
							shippingAddress = new Address(rs2.getInt("addressID"), rs2.getString("street"), rs2.getInt("nr"), rs2.getString("city"), rs2.getString("country"), rs2.getString("postalCode"));
							st.setShippingAddress(shippingAddress);
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					Address billingAddress = null;
					try {
						String sqlQuery3 = "Select * from address where addressID='"+ba+"'";
						ResultSet rs3 = db.getResultSet(sqlQuery3);
						if (rs3.next()){
							billingAddress = new Address(rs3.getInt("addressID"), rs3.getString("street"), rs3.getInt("nr"), rs3.getString("city"), rs3.getString("country"), rs3.getString("postalCode"));
							st.setBillingAddress(billingAddress);
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
			} catch (SQLException e) {
				//e.printStackTrace();
			}
		}
		catch (Exception e) {
		}
		return st;
	}
	
	
	public void modificaParola(String email, String newPass)
	{
		db.beginTransaction();
		try{
			String updateQuery = "Update customer set password = '"+ newPass + "' where email = '"+ email +"'";
			db.modifyTabel(updateQuery);
		}
		catch (Exception e) {
		}
	}
	
	
	public void modificaNume(String email, String nume)
	{
		db.beginTransaction();
		try{
			String updateQuery = "Update customer set lastName = '"+ nume + "' where email = '"+ email +"';";
			db.modifyTabel(updateQuery);
		}
		catch (Exception e) {
			//e.printStackTrace();
		}
	}
	
	
	public void modificaPrenume(String email, String prenume)
	{
		db.beginTransaction();
		try{
			String updateQuery = "Update customer set firstName = '"+ prenume + "' where email = '"+ email +"';";
			db.modifyTabel(updateQuery);
		}
		catch (Exception e) {
			//e.printStackTrace();
		}
	}
	
	/**
	 * returneaza un vector ce contine cartile salvate in cosul de cumparaturi
	 */
	public Vector<Item> loadCartItems(int customerID){
		 Vector<Item> vItems = new Vector<Item>();
		 Item item = new Item();
		 //incarcam cartile din cos, deocamdata fara numarul de exemplare dorite
		 String sqlQuery = "Select * from item where ISBN in (Select itemISBN from shoppingcart where customerID='"+customerID+"')";
		 Statement stmt = null;
		 ResultSet rs = db.getResultSet(sqlQuery, stmt);
		 try {
			while(rs.next()){//cat timp mai exista carti in cos
				//apelam constructorul pentru urmatoarea carte
				item = new Item(rs.getString("ISBN"), rs.getString("title"), rs.getString("author"), rs.getString("volume"), rs.getString("publisher"), rs.getInt("yearPublished"), rs.getDouble("price"));
				//adaugam cartea in vector
				//numarul de exemplare va fi 0 in acest moment, il vom modifica mai tarziu 
				vItems.addElement(item);
			}
		 } catch (SQLException e) {
		 }
		 //actualizam numarul de exemplare
		 for(int i=0;i<vItems.size();i++){
			 sqlQuery = "Select quantity from shoppingcart where itemISBN='"+vItems.get(i).getIsbn()+"'";
			 stmt = null;
			 rs = db.getResultSet(sqlQuery, stmt);
			 try {
				if(rs.next()){
					vItems.get(i).setQuantity(rs.getInt("quantity"));
				}
			 } catch (SQLException e) {
			 }
		 }
		 return vItems;
	}
	
	/**
	 * returneaza numarul de produse din cosul de cumparaturi
	 */
	/*public int loadNrOfCartItems(int customerID){
		String sqlQuery = "Select count(*) as nr from shoppingcart where customerID='"+customerID+"'";
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
		 try {
			if(rs.next()){
				return rs.getInt("nr");
			}
		} catch (SQLException e) {
		}
		 return 0;
	}*/
	
	/**
	 * returneaza un vector ce contine lista de comenzi efectuate
	 */
	public Vector<Order> loadOrders(int customerID){
		Vector<Order> vOrders = new Vector<Order>();
		Order order;

		//incarcam din baza de date informatiile despre toate comenzile efectuate,
		//exceptand cartile comandate
		String sqlQuery = "SELECT * FROM `order` WHERE customerID="+customerID+"";
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
		try {
			while(rs.next()){
				//System.out.println("has order");
				order = new Order(rs.getInt("orderID"), rs.getInt("customerID"), rs.getDate("orderDate"), rs.getDouble("totalPrice"), rs.getString("status"));
				vOrders.addElement(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//obtinem cartile cumparate la fiecare comanda
		for(int i=0;i<vOrders.size();i++){
			sqlQuery = "Select * from item where ISBN in (Select itemISBN from order_item where orderID="+vOrders.get(i).getOrderID()+")";
			stmt = null;
			rs = db.getResultSet(sqlQuery, stmt);
		
			ArrayList<Item> items=new ArrayList<Item>();
			try {
				while(rs.next()){//adaugam cartile in vector
					Item item = new Item(rs.getString("ISBN"), rs.getString("title"), rs.getString("author"), rs.getString("volume"), rs.getString("publisher"), rs.getInt("yearPublished"), rs.getDouble("price"));
					items.add(item);
				}
				//adaugam lista de carti la comanda
				vOrders.get(i).setItems(items);
			} catch (SQLException e) {
			}
		}
		//actualizam cantitatea
		for(int i=0;i<vOrders.size();i++){
			ArrayList<Item> items = vOrders.get(i).getItems();
			for(int j=0;j<items.size();j++){
				sqlQuery = "Select quantity from order_item where orderID="+vOrders.get(i).getOrderID()+" and itemISBN='"+items.get(j).getIsbn()+"'";
				stmt = null;
				rs = db.getResultSet(sqlQuery, stmt);
				try {
					while(rs.next()){
						vOrders.get(i).getItems().get(j).setQuantity(rs.getInt("quantity"));
					}
				} catch (SQLException e) {
				}
			}
		}
		return vOrders;
	}
	
	/**
	 * sterge o carte din cos
	 */
	public void deleteFromCart(int customerID, String itemISBN){
		//obtinem cantitatea
		String sqlQuery = "Select quantity from shoppingcart where itemISBN='"+itemISBN+"' and customerID="+customerID;
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
		int quantity = 0;
		 try {
			 if(rs.next())
				 quantity = rs.getInt("quantity");
			//System.out.println("Quantity is "+quantity);
			//modificam numarul total de bucati disponibile din cartea respectiva
			db.beginTransaction();
			String updateQuery = "Update bookstore.item set quantity=quantity+"+quantity+" where ISBN = '"+ itemISBN + "'";
			db.modifyTabel(updateQuery);
		 } catch (SQLException e) {
			 e.printStackTrace();
		 }
		 //efectuam stergerea cartii din cosul de cumparaturi
		db.beginTransaction();
		try{
			String deleteQuery = "Delete from shoppingcart where itemISBN = '"+itemISBN+"' and customerID = "+ customerID +"";
			db.modifyTabel(deleteQuery);
		}
		catch (Exception e) {
		}
	}
	
	/**
	 * modifica numarul de exemplare dorite pt o carte
	 * */
	public void updateCart(int customerID, String itemISBN, int newQuantity){
		//obtinem cantitatea
		String sqlQuery = "Select quantity from shoppingcart where itemISBN='"+itemISBN+"'";
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
		int oldQuantity = 0;
		 try {
			oldQuantity = rs.getInt("quantity");
		 } catch (SQLException e) {
		 }
		 //verificam daca e nevoie sa facem vreo modificare
		 int updatedQ = oldQuantity - newQuantity;
		 if(updatedQ != 0){//sunt necesare modificari
			if(newQuantity == 0){//noua cantitate este 0, stergem cartea din cos
				this.deleteFromCart(customerID, itemISBN);
			}
			else{
				//actualizam nr de exemplare, atat cel global cat si cel din cos
				db.beginTransaction();
				try{
					//modificam noua cantitate in cos
					String updateQuery = "Update bookstore.shoppingcart set quantity='"+newQuantity+"' where itemISBN = '"+ itemISBN + "' and customerID = '"+ customerID +"'";
					db.modifyTabel(updateQuery);
					//modificam numarul total de bucati disponibile din cartea respectiva
					db.beginTransaction();
					if(updatedQ > 0){
						updateQuery = "Update bookstore.item set quantity=quantity+"+updatedQ+" where ISBN = '"+ itemISBN + "'";
					}
					else{
						updateQuery = "Update bookstore.item set quantity=quantity-"+updatedQ+" where ISBN = '"+ itemISBN + "'";
						}
					db.modifyTabel(updateQuery);
				}
				catch (Exception e) {
				}
			}
		 }

	}
	
	/**
	 * adauga o carte in cosul de comparaturi,
	 * respectiv mareste numarul de exemplare, 
	 * in cazul in care cartea exista deja in cos
	 */
	public void addItemToCart(int customerID, String itemISBN){
		//verificam daca aceasta carte era deja adaugata in cos
		boolean alreadyInCart = false;
		String sqlQuery = "Select quantity from shoppingcart where customerID='"+customerID+"' and itemISBN='"+itemISBN+"'";
		Statement stmt = null;
		ResultSet rs = db.getResultSet(sqlQuery, stmt);
		try {
			if(rs.next()){//cartea era in cos, trebuie doar sa mai adaugam un exemplar
				db.beginTransaction();
				try{
					String updateQuery = "Update bookstore.shoppingcart set quantity=quantity+1 where itemISBN = '"+ itemISBN + "' and customerID = '"+ customerID +"'";
					db.modifyTabel(updateQuery);
					alreadyInCart = true;
				}
				catch (Exception e) {
				}
			}
		} catch (SQLException e) {
		}
		if(!alreadyInCart){//cartea nu era in cos, o adaugam
			db.beginTransaction();
			try{
				String insertQuery = "Insert into shoppingcart(customerID,itemISBN,quantity) values ('"+customerID+"', '" + itemISBN +"', '1')";
				db.modifyTabel(insertQuery);
			}
			catch (Exception e) {
			}
		}
		//modificam numarul total de exemplare disponibile in librarie
		db.beginTransaction();
		String updateQuery = "Update bookstore.item set quantity=quantity-1 where ISBN = '"+ itemISBN + "'";
		db.modifyTabel(updateQuery);
	}
	
	/**
	 * finalizeaza comanda
	 */
	public void makeOrder(int customerID){
		db.beginTransaction();
		int orderId = 0;
		//inseram o noua inregistrare in tabela order si retinem idul in orderId
		//noua inregistrare va avea totalul 0 deocamdata, ii vom seta valoarea reala mai tarziu
		try{
			String insertQuery = "INSERT INTO `bookstore`.`order` (`orderID`, `customerID`, `orderDate`, `totalPrice`, `status`) VALUES (NULL, '"+customerID+"', CURDATE(), '0', 'new')";
			db.modifyTabel(insertQuery);
			orderId = db.getLastId();
			//System.out.println("orderId"+orderId);
		}
		catch (Exception e) {
		}
		double total = 0;
		//incarcam cartile din cos
		Vector<Item> items = this.loadCartItems(customerID);
		for(int i=0;i<items.size();i++){
			db.beginTransaction();
			try{
				//inseram cartile comandate in order_item
				String insertQuery = "Insert into order_item(orderID,itemISBN,quantity) values ("+orderId+", '"+items.get(i).getIsbn()+"', "+items.get(i).getQuantity()+")";
				db.modifyTabel(insertQuery);
				total += items.get(i).getPrice()*items.get(i).getQuantity();
				//si le stergem din shoppingcart
				String deleteQuery = "Delete from shoppingcart where itemISBN = '"+items.get(i).getIsbn()+"' and customerID = '"+ customerID +"'";
				db.modifyTabel(deleteQuery);
			}
			catch (Exception e) {
			}
		}
		//modificam in baza de date pretul total al comenzii
		try{
			//System.out.println("Total order price "+total+" orderID "+orderId);
			String updateQuery = "Update bookstore.order set totalPrice="+total+" where orderID = "+ orderId + "";
			db.modifyTabel(updateQuery);
		}
		catch (Exception e) {
		}
	}
	
	public void close(){
		db.CloseConnection();
	}
	
}
