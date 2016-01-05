package utilizatori;


public class Admin {
	private int adminId;
	private String strPassword;
	private String strEmail;
	private String strNume;
	private String strPrenume;
	
	public Admin() {
		this.adminId = -1;
		this.strPassword = "";
		this.strEmail = "";
		this.strNume = "";
		this.strPrenume = "";
	}
	public Admin(String email, String pass) {
		this.strEmail = email;
		this.strPassword = pass;
	}
	public Admin(int id, String pass, String email, String nume, String prenume) {
		this.adminId = id;
		this.strPassword = pass;
		this.strEmail = email;
		this.strNume = nume;
		this.strPrenume = prenume;
	}
	public int getAdminId() {
		return adminId;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
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
	
	
}

