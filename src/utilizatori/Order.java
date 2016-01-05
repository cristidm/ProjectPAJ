package utilizatori;

import java.sql.Date;
import java.util.ArrayList;

import actions.Item;

public class Order {
	private int orderID;
	private int customerID;
	private Date orderDate;
	private double total;
	private String status;
	private ArrayList<Item> items;
	
	public Order() {
		this.orderID = -1;
		this.customerID = -1;
		this.orderDate = null;
		this.total = 0;
		this.status = "";
		this.items = null;
	}
	
	public Order(int orderID, int customerID, Date orderDate, double total,
			String status) {
		this.orderID = orderID;
		this.customerID = customerID;
		this.orderDate = orderDate;
		this.total = total;
		this.status = status;
		this.items = null;
	}
	
	public Order(int orderID, int customerID, Date orderDate, double total,
			String status, ArrayList<Item> items) {
		this.orderID = orderID;
		this.customerID = customerID;
		this.orderDate = orderDate;
		this.total = total;
		this.status = status;
		this.items = items;
	}

	
	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public int getCustomerID() {
		return customerID;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public ArrayList<Item> getItems() {
		return items;
	}

	public void setItems(ArrayList<Item> items) {
		this.items = items;
	}
	

}
