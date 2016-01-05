<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*,database.*,actions.*"%>

<%
	String eroare = "";

	if ((request.getParameter("username") != null) && (request.getParameter("pass") != null)
	&& (request.getParameter("username") != "") && (request.getParameter("pass") != "")) {
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");
		Login lg = new Login();
		String rang = lg.loginUser(username, pass);
		lg.close();
		if ("customer".equals(rang)) {
			session.setAttribute("userSession", username);
			session.setAttribute("passSession", pass);
			session.setAttribute("customer","da" );
			response.sendRedirect("index.jsp");
		} else if ("admin".equals(rang)) {
			session.setAttribute("userSession", username);
			session.setAttribute("passSession", pass);
			session.setAttribute("admin","da" );
			response.sendRedirect("index.jsp");
		} else {
			eroare = "Wrong e-mail or password!";
		}

	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Online Book Store</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	function validate(){
		if(document.login.username.value == "" ||
				document.login.pass.value == ""){
			document.getElementById("alert").innerHTML = '* Required';
			return false;
		}
		return true;
	}
</script>

</head>
<body>
<!--  Free CSS Templates from www.templatemo.com -->
<div id="templatemo_container">
	<div id="templatemo_menu">
    	<ul>
    		<%if (session.getAttribute("admin")=="da"){ %>
			<li><a href="index.jsp">Home</a></li>
            <li><a href="search.jsp">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>     
            <li><a href="customers.jsp">Customers</a></li>
            <li><a href="items.jsp">Items</a></li>
            <li><a href="myaccount.jsp">My account</a></li>       
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else if(session.getAttribute("customer")=="da"){%>
			<li><a href="index.jsp">Home</a></li>
            <li><a href="search.jsp">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>  
            <li><a href="myaccount.jsp">My account</a></li>  
            <li><a href="cart.jsp">Cart</a></li>          
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else{%>
			<li><a href="index.jsp">Home</a></li>
            <li><a href="search.jsp">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>  
            <li><a href="register.jsp">Register</a></li>            
            <li><a href="login.jsp" class="current">Login</a></li>  
			<%} %>
    	</ul>
    </div> <!-- end of menu -->
    
    <div id="templatemo_header">
    </div> <!-- end of header -->
    
    <div id="templatemo_content">
    	
        
        
        <div id="templatemo_content_right">
        	<div class="templatemo_box">
        	<h1>Please fill in your login information</h1>
        	<form name="login" action="login.jsp" method="post">
		<table cellspacing="30">
			<tr>
				<td>* Email </td>
				<td><input type="text" name="username"/></td>
			</tr>
			<tr>
				<td>* Password </td>
				<td><input type="password" name="pass"/></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Login" onclick="return validate()" style="background-color:black; color:white; padding:3px 15px"/></td>
			</tr>
		</table>
		<table>
			<tr>
				<td id="alert" style="color:red;"><%=eroare%></td>
			</tr>
		</table>
	</form>
</div>
        </div> <!-- end of content right -->
    
    	<div class="cleaner_with_height">&nbsp;</div>
    </div> <!-- end of content -->
    
    <div id="templatemo_footer">
    
	       Copyright 

	</div> 
    <!-- end of footer -->
<!--  Free CSS Template www.templatemo.com -->
</div> <!-- end of container -->
</body>
</html>