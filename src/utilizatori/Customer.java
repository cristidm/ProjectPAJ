package utilizatori;

import utilizatori.Address;

public class Customer{


	private int strId;
	private String strPassword;
	private String strEmail;
	private String strNume;
	private String strPrenume;
	private String strPhone;
	private Address shippingAddress;
	private Address billingAddress;
	
	//constructori
	public Customer() {
		this.strId = 0;
		this.strPassword = "";
		this.strEmail = "";
		this.strNume = "";
		this.strPrenume = "";
		this.strPhone = "";
		this.shippingAddress = null;
		this.billingAddress = null;
	}
	public Customer(String strEmail, String strPassword,
			String strNume, String strPrenume, String strPhone) {
		this.strPassword = strPassword;
		this.strEmail = strEmail;
		this.strNume = strNume;
		this.strPrenume = strPrenume;
		this.strPhone = strPhone;
		this.shippingAddress = null;
		this.billingAddress = null;
	}
	public Customer(int strId, String strPassword, String strEmail,
			String strNume, String strPrenume, String strPhone,
			Address shippingAddress, Address billingAddress) {
		this.strId = strId;
		this.strPassword = strPassword;
		this.strEmail = strEmail;
		this.strNume = strNume;
		this.strPrenume = strPrenume;
		this.strPhone = strPhone;
		this.shippingAddress = shippingAddress;
		this.billingAddress = billingAddress;
	}
	
	
	//setteri si getteri

	public int getStrId() {
		return strId;
	}
	public void setStrId(int strId) {
		this.strId = strId;
	}
	public String getStrPassword() {
		return strPassword;
	}
	public void setStrPassword(String strPassword) {
		this.strPassword = strPassword;
	}
	public String getStrEmail() {
		return strEmail;
	}
	public void setStrEmail(String strEmail) {
		this.strEmail = strEmail;
	}
	public String getStrNume() {
		return strNume;
	}
	public void setStrNume(String strNume) {
		this.strNume = strNume;
	}
	public String getStrPrenume() {
		return strPrenume;
	}
	public void setStrPrenume(String strPrenume) {
		this.strPrenume = strPrenume;
	}
	public String getStrPhone() {
		return strPhone;
	}
	public void setStrPhone(String strPhone) {
		this.strPhone = strPhone;
	}
	public Address getShippingAddress() {
		return shippingAddress;
	}
	public void setShippingAddress(Address shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	public Address getBillingAddress() {
		return billingAddress;
	}
	public void setBillingAddress(Address billingAddress) {
		this.billingAddress = billingAddress;
	}

	
}
