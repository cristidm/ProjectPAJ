package utilizatori;

public class Address {
	
	private int addressId;
	private String street;
	private int number;
	private String city;
	private String country;
	private String postalCode;
	
	public Address(){
		this.addressId = -1;
		this.street = "";
		this.number = -1;
		this.city = "";
		this.country = "";
		this.postalCode = "";
	}
	
	public Address(int addressId, String street, int number, String city,
			String country, String postalCode) {
		this.addressId = addressId;
		this.street = street;
		this.number = number;
		this.city = city;
		this.country = country;
		this.postalCode = postalCode;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	
	
	
}
