<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*,java.util.*,database.*,actions.*"%>

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
			<li><a href="index.jsp" class="current">Home</a></li>
            <li><a href="search.jsp">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>     
            <li><a href="customers.jsp">Customers</a></li>
            <li><a href="items.jsp">Items</a></li>
            <li><a href="myaccount.jsp">My account</a></li>       
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else if(session.getAttribute("customer")=="da"){%>
			<li><a href="index.jsp" class="current">Home</a></li>
            <li><a href="search.jsp">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>  
            <li><a href="myaccount.jsp">My account</a></li>  
            <li><a href="cart.jsp">Cart</a></li>          
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else{%>
			<li><a href="index.jsp" class="current">Home</a></li>
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
        	
        	<%
        		GuestActions ga = new GuestActions();
        		Vector<Item> items = ga.loadItems();
        		ga.close();
        		for(int i=0; i<items.size(); i++){
        			%>
        			<div class="templatemo_product_box">
	            	<h1><%=items.get(i).getTitle() %>  <span>(by <%=items.get(i).getAuthor() %>)</span></h1>
			   	    <img src="images/<%=items.get(i).getIsbn()%>.jpg" alt="image" />
	                <div class="product_info">
	                	<p>
	                		Publisher: <%=items.get(i).getPublisher() %><br/>
	                		Year published: <%=items.get(i).getYearPublished() %><br/>
	                		Volume: <%=items.get(i).getVolume() %><br/>
	                		ISBN: <%=items.get(i).getIsbn() %><br/>
	                	 </p>
	                  <h3>$<%=items.get(i).getPrice() %></h3>
	                  <%if(session.getAttribute("customer")=="da"){ %>
	                  	<div class="buy_now_button"><a href="cart.jsp?addproduct=<%=items.get(i).getIsbn() %>">Buy Now</a></div>
	                  <%} %>
	                </div>
	                <div class="cleaner">&nbsp;</div>
		            </div>
		            
		            <div class="cleaner_with_width">&nbsp;</div>
		            <%  i++;
		            	if(i<=items.size()){%>
		            		<div class="templatemo_product_box">
			            	<h1><%=items.get(i).getTitle() %>  <span>(by <%=items.get(i).getAuthor() %>)</span></h1>
				       	    <img src="images/<%=items.get(i).getIsbn()%>.jpg" alt="image" />
				                <div class="product_info">
				                	<p>
				                		Publisher: <%=items.get(i).getPublisher() %><br/>
				                		Year published: <%=items.get(i).getYearPublished() %><br/>
				                		Volume: <%=items.get(i).getVolume() %><br/>
				                		ISBN: <%=items.get(i).getIsbn() %><br/>
				                	 </p>
				                  <h3>$<%=items.get(i).getPrice() %></h3>
				                  <%if(session.getAttribute("customer")=="da"){ %>
				                  	<div class="buy_now_button"><a href="cart.jsp?addproduct=<%=items.get(i).getIsbn() %>">Buy Now</a></div>
				                  <%} %>
				                </div>
				                <div class="cleaner">&nbsp;</div>
				            </div>
				            
				            <div class="cleaner_with_height">&nbsp;</div>
		            	<%} %>
        			<%
        		}
        	%>
        
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