<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*,java.util.*,database.*,actions.*,utilizatori.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Online Book Store</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
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
            <li><a href="customers.jsp" class="current">Customers</a></li>
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
            <li><a href="login.jsp">Login</a></li>  
			<%} %>
    	</ul>
    </div> <!-- end of menu -->
    
    <div id="templatemo_header">
    </div> <!-- end of header -->
    
    <div id="templatemo_content">
    	
        
        
        <div id="templatemo_content_right">
		<%if(session.getAttribute("userSession")==null){
		%>
        <p>Please login </p>
        <%}else if(session.getAttribute("admin")=="da"){ 
        	AdminActions aa = new AdminActions();
        	String username = session.getAttribute("userSession").toString();
        	Vector<Customer> vc = aa.loadCustomers();
        %>
			
			
				<h1>Customer list</h1>
		<%for(int i= 0; i<vc.size() ;i++)
				{%>
			<table cellspacing="30">
				
				
				<!--<tr>
					<td class="camp">Customer ID </td>
					<td class="valoare"><%out.print(vc.get(i).getStrId());%></td>
				</tr>-->
				<tr>
					<td class="camp">Customer Name </td>
					<td class="valoare"><%out.print(vc.get(i).getStrNume()+"  "+vc.get(i).getStrPrenume());%></td>
				</tr>
				<tr>
					<td class="camp">Customer Email </td>
					<td class="valoare"><%out.print(vc.get(i).getStrEmail());%></td>
				</tr>
				<tr>
					<td class="camp">Customer Phone </td>
					<td class="valoare"><%out.print(vc.get(i).getStrPhone());%></td>
				</tr>
			<!--	<tr>
					<td class="camp">Customer Billing Adress </td>
					<td class="valoare"><%out.print(vc.get(i).getBillingAddress());%></td>
				</tr>
				<tr>
					<td class="camp">Customer Shipping Adress </td>
					<td class="valoare"><%out.print(vc.get(i).getShippingAddress());%></td>
				</tr>-->
				</table>
			<%}}%>
            <div class="cleaner_with_height">&nbsp;</div>
            
            

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