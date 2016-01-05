package actions;

public class Item {

	private String isbn;
	private String title;
	private String  author;
	private String volume;
	private String publisher;
	private int yearPublished;
	private double price;
	private int quantity;
	
	public Item() {
		this.isbn = "";
		this.title = "";
		this.author = "";
		this.volume = "";
		this.publisher = "";
		this.yearPublished = 0;
		this.price = 0;
		this.quantity = 0;
	}
	public Item(String isbn, String title, String author, String volume,
			String publisher, int yearPublished, double price) {
		this.isbn = isbn;
		this.title = title;
		this.author = author;
		this.volume = volume;
		this.publisher = publisher;
		this.yearPublished = yearPublished;
		this.price = price;
	}
	public Item(String isbn, String title, String author, String volume,
			String publisher, int yearPublished, double price, int quantity) {
		this.isbn = isbn;
		this.title = title;
		this.author = author;
		this.volume = volume;
		this.publisher = publisher;
		this.yearPublished = yearPublished;
		this.price = price;
		this.quantity = quantity;
	}
	
	
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getVolume() {
		return volume;
	}
	public void setVolume(String volume) {
		this.volume = volume;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public int getYearPublished() {
		return yearPublished;
	}
	public void setYearPublished(int yearPublished) {
		this.yearPublished = yearPublished;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
}
