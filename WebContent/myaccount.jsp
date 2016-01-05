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

<script language="javascript">

	function valideazaParola(){
		if(modifica.parola.value =="" || modifica.parola.value ==null){
			document.getElementById("alertParola").innerHTML= "<h5 class='alert'>You must fill in the password</h5>";
			return false;
		}
	}

	function valideazaNume(){
		if(modifica2.nume.value =="" || modifica2.nume.value ==null){
			document.getElementById("alertNume").innerHTML= "<h5 class='alert'>You must fill in the Last name</h5>";
			return false;
		}
	}
	function valideazaPrenume(){
		if(modifica3.prenume.value =="" || modifica3.prenume.value ==null){
			document.getElementById("alertPrenume").innerHTML= "<h5 class='alert'>You must fill in the First name</h5>";
			return false;
		}
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
            <li><a href="myaccount.jsp" class="current">My account</a></li>       
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else if(session.getAttribute("customer")=="da"){%>
			<li><a href="index.jsp">Home</a></li>
            <li><a href="search.jsp">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>  
            <li><a href="myaccount.jsp" class="current">My account</a></li>  
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
        	
        	<%
 		if(session.getAttribute("userSession")==null){
		%>
		 	<p>Please login </p>
		<%}else if(session.getAttribute("customer")=="da"){ 
			CustomerActions is = new CustomerActions();
			String username = session.getAttribute("userSession").toString();
			Customer st = is.loadCustomer(username);
			
			String parola = null;
			if(request.getParameterValues("bParola")!=null){
				parola = request.getParameterValues("parola")[0];
				is.modificaParola(st.getStrEmail(), parola);
				response.sendRedirect("myaccount.jsp");
			}
			String nume = null;
			if(request.getParameterValues("bNume")!=null){
				nume = request.getParameter("nume");
				is.modificaNume(st.getStrEmail(), nume);
				response.sendRedirect("myaccount.jsp");
			}
			String prenume = null;
			if(request.getParameterValues("bPrenume")!=null){
				prenume = request.getParameter("prenume");
				is.modificaPrenume(st.getStrEmail(), prenume);
				response.sendRedirect("myaccount.jsp");
			}
		%>
		<h1>Account details</h1>
		<table cellspacing="30"><tr>
		<td>
			<table cellspacing="10">
				<tr>
					<td class="camp">Customer ID </td>
					<td class="valoare"><%out.print(st.getStrId());%></td>
				</tr>
				<tr>
					<td class="camp">Email </td>
					<td class="valoare"><%out.print(st.getStrEmail());%></td>
				</tr>
				<tr>
					<td class="camp">Password </td>
					<td class="valoare"> <%=st.getStrPassword() %> </td>
				</tr>
				<tr>
					<td class="camp">First Name </td>
					<td class="valoare"><%=st.getStrPrenume()%></td>
				</tr>
				<tr>
					<td class="camp">Last Name </td>
					<td class="valoare"><%=st.getStrNume() %></td>
				</tr>
				<tr>
					<td class="camp">Phone </td>
					<td class="valoare"><%=st.getStrPhone() %></td>
				</tr>
				<tr>
					<td class="camp">Shipping Address </td>
					<%if(st.getBillingAddress() == null) {%>
						<td class="valoare">Not defined</td>
					<%}else{%>
						<td class="valoare">
							Street: <%=st.getShippingAddress().getStreet() %><br/>
							Number: <%=st.getShippingAddress().getNumber() %><br/>
							Postal code: <%=st.getShippingAddress().getPostalCode()%><br/>
							City: <%=st.getShippingAddress().getCity() %><br/>
							Country: <%=st.getShippingAddress().getCountry() %><br/>
						</td>
					<%}%>
				</tr>
				<tr>
					<td class="camp">Billing Address </td>
					<%if(st.getBillingAddress() == null) {%>
						<td class="valoare">Not defined</td>
					<%}else{%>
						<td class="valoare">
							Street: <%=st.getBillingAddress().getStreet() %><br/>
							Number: <%=st.getBillingAddress().getNumber() %><br/>
							Postal code: <%=st.getBillingAddress().getPostalCode()%><br/>
							City: <%=st.getBillingAddress().getCity() %><br/>
							Country: <%=st.getBillingAddress().getCountry() %><br/>
						</td>
					<%}%>
				</tr>
			</table>
		</td>
		<td>
			<h4>Modify your account settings</h4><br/>
			<form onsubmit="return valideazaParola()" action="myaccount.jsp" method="post" name="modifica" >
			    &nbsp;&nbsp;&nbsp;New password:  <input type = "text" name = "parola" />
			    <input type = "submit" name = "bParola" value = "Modify password!" onclick = "javascript:valideazaParola();" style="background-color:black; color:white; padding:3px 15px" />
			    <div id = "alertParola"></div><br/>
			</form>
			<form onsubmit="return valideazaNume()" action="myaccount.jsp" method="post" name="modifica2" >
			    &nbsp;&nbsp;&nbsp;New last name: <input type = "text" name = "nume" />
			    <input type = "submit" name = "bNume" value = "Modify last name!" onclick = "javascript:valideazaNume();" style="background-color:black; color:white; padding:3px 15px" />
			    <div id = "alertNume" class="alert"></div><br/>
			</form>
			<form onsubmit="return valideazaPrenume()" action="myaccount.jsp" method="post" name="modifica3" >
			    &nbsp;&nbsp;&nbsp;New first name: <input type = "text" name = "prenume" />
			    <input type = "submit" name = "bPrenume" value = "Modify first name!" onclick = "valideazaPrenume();" style="background-color:black; color:white; padding:3px 15px"/>
			    <div id = "alertPrenume"></div><br/>
			</form>
		</td></tr></table>
		<%
		Vector<Order> orders = is.loadOrders(st.getStrId());
		%>
		<table>
			<tr>
				<td colspan="4"><h1 id="myorders">My orders</h1></td>
			</tr>
			<%if(orders.size() == 0){ %>
				<tr>
					<td colspan="4">You haven't ordered anything yet</td>
				</tr>
			<%}else{ %>
				<tr>
					<th>Order ID</th>
					<th>Order date</th>
					<th>Total price</th>
					<th>Status</th>
				</tr>
				<%for(int i=0; i<orders.size();i++){%>
					<tr>
						<td><%=orders.get(i).getOrderID() %></td>
						<td><%=orders.get(i).getOrderDate() %></td>
						<td><%=orders.get(i).getTotal() %></td>
						<td><%=orders.get(i).getStatus() %></td>
					</tr>
				<%}
			} %>
		</table>
		<%}else if(session.getAttribute("admin")=="da"){ 
			AdminActions is = new AdminActions();
			String email = session.getAttribute("userSession").toString();
			Admin st = is.loadAdmin(email);
			
			String parola = null;
			if(request.getParameterValues("bParola")!=null){
				parola = request.getParameterValues("parola")[0];
				is.modificaParola(st.getStrEmail(), parola);
				response.sendRedirect("myaccount.jsp");
			}
			String nume = null;
			if(request.getParameterValues("bNume")!=null){
				nume = request.getParameter("nume");
				is.modificaNume(st.getStrEmail(), nume);
				response.sendRedirect("myaccount.jsp");
			}
			String prenume = null;
			if(request.getParameterValues("bPrenume")!=null){
				prenume = request.getParameter("prenume");
				is.modificaPrenume(st.getStrEmail(), prenume);
				response.sendRedirect("myaccount.jsp");
			}
		%>
		<h1>Account details</h1>
		<table cellspacing="30"><tr>
		<td>
			<table cellspacing="10">
				<tr>
					<td class="camp">Admin ID </td>
					<td class="valoare"><%=st.getAdminId()+""%></td>
				</tr>
				<tr>
					<td class="camp">Email </td>
					<td class="valoare"><%=st.getStrEmail() %></td>
				</tr>
				<tr>
					<td class="camp">Password </td>
					<td class="valoare"> <%=st.getStrPassword() %> </td>
				</tr>
				<tr>
					<td class="camp">First Name </td>
					<td class="valoare"><%=st.getStrPrenume()%></td>
				</tr>
				<tr>
					<td class="camp">Last Name </td>
					<td class="valoare"><%=st.getStrNume() %></td>
				</tr>
			</table>
		</td>
		<td>
			<h4>Modify your account settings</h4><br/>
			<form onsubmit="return valideazaParola()" action="myaccount.jsp" method="post" name="modifica" >
			    &nbsp;&nbsp;&nbsp;New password:  <input type = "text" name = "parola" />
			    <input type = "submit" name = "bParola" value = "Modify password!" onclick = "javascript:valideazaParola();"  style="background-color:black; color:white; padding:3px 15px"/>
			    <div id = "alertParola"></div><br/>
			</form>
			<form onsubmit="return valideazaNume()" action="myaccount.jsp" method="post" name="modifica2" >
			    &nbsp;&nbsp;&nbsp;New last name: <input type = "text" name = "nume" />
			    <input type = "submit" name = "bNume" value = "Modify last name!" onclick = "javascript:valideazaNume();"  style="background-color:black; color:white; padding:3px 15px"/>
			    <div id = "alertNume" class="alert"></div><br/>
			</form>
			<form onsubmit="return valideazaPrenume()" action="myaccount.jsp" method="post" name="modifica3" >
			    &nbsp;&nbsp;&nbsp;New first name: <input type = "text" name = "prenume" />
			    <input type = "submit" name = "bPrenume" value = "Modify first name!" onclick = "valideazaPrenume();"  style="background-color:black; color:white; padding:3px 15px"/>
			    <div id = "alertPrenume"></div><br/>
			</form>
		</td></tr></table>
		<%} %>
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