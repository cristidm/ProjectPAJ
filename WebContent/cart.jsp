<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*,java.util.*,database.*,actions.*, utilizatori.*"%>

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
            <li><a href="customers.jsp">Customers</a></li>
            <li><a href="items.jsp">Items</a></li>
            <li><a href="myaccount.jsp">My account</a></li>       
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else if(session.getAttribute("customer")=="da"){%>
			<li><a href="index.jsp">Home</a></li>
            <li><a href="search.jsp">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>  
            <li><a href="myaccount.jsp">My account</a></li>  
            <li><a href="cart.jsp" class="current">Cart</a></li>          
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

			<h1>My cart</h1>
			<%
	 		if(session.getAttribute("userSession")==null){
			%>
			 	<p>Please login </p>
			<%}else if(session.getAttribute("customer")=="da"){ 
				CustomerActions is = new CustomerActions();
				String username = session.getAttribute("userSession").toString();
				Customer st = is.loadCustomer(username);
				if(request.getParameter("addproduct")!=null){
					is.addItemToCart(st.getStrId(), request.getParameter("addproduct"));
					response.sendRedirect("cart.jsp");
				}
				if(request.getParameterValues("bQuantity")!=null){
					int quantity = Integer.parseInt(request.getParameter("iQuantity"));
					String isbn = request.getParameter("isbn");
					is.updateCart(st.getStrId(), isbn, quantity);
					response.sendRedirect("cart.jsp");
				}
				if(request.getParameterValues("bDelete")!=null){
					String isbn = request.getParameter("isbn");
					System.out.println("Delete item, isbn="+isbn);
					is.deleteFromCart(st.getStrId(), isbn);
					response.sendRedirect("cart.jsp");
				}
				if(request.getParameterValues("bOrder")!=null){
					is.makeOrder(st.getStrId());
					response.sendRedirect("myaccount.jsp#myorders");
				}
				Vector<Item> cartItems = is.loadCartItems(st.getStrId());
				if(cartItems.size() == 0){%>
					<p>Your cart is empty</p>
				<%}else{%>
					<table cellspacing="10">
					<tr>
						<th>ISBN</th>
						<th>Title</th>
						<th>Author</th>
						<th>price</th>
						<th>quantity</th>
						<th></th>
					</tr>
					<%for(int i=0;i<cartItems.size();i++){%>
					<tr>
						<td><%=cartItems.get(i).getIsbn() %></td>
						<td><%=cartItems.get(i).getTitle() %></td>
						<td><%=cartItems.get(i).getAuthor() %></td>
						<td><%=cartItems.get(i).getPrice()%></td>
						<td>
							<form action="cart.jsp?isbn=<%=cartItems.get(i).getIsbn() %>" method="post" name="mCart<%=i %>" >
								<input type="text"  name = "iQuantity" value = "<%=cartItems.get(i).getQuantity() %>"  />
								<input type = "submit" name = "bQuantity" value = "Update quantity!"  style="background-color:black; color:white; padding:3px 15px"/>
								<input type = "submit" name = "bDelete" value = "Delete from cart"  style="background-color:black; color:white; padding:3px 15px"/>
							</form>
						</td>
					</tr>
					<%}%>
					<tr>
						<td colspan="4"></td>
						<td>
							<form action="cart.jsp" method="post" name="fOrder" >
								<input type = "submit" name = "bOrder" value = "Finalyze order"  style="background-color:black; color:white; padding:3px 15px"/>
							</form>
						</td>
					</tr>
					</table>
				<%}
			}%>
				
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