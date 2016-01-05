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

<script language="javascript">

	function valideazaISBN(){
		if(modifica.ISBN.value =="" || modifica.parola.value ==null){
			document.getElementById("alertISBN").innerHTML= "<h5 class='alert'>You must fill the ISBN</h5>";
			return false;
		}
	}
	function validate(){
		if(document.insert.ISBN.value == "" ||
				document.insert.title.value == "" ||
				document.insert.author.value == "" ||
				document.insert.editura.value == "" ||
				document.insert.pret.value == ""){
			document.getElementById("alert").innerHTML = 'You must complete all marked with *';
			return false;
		}
		return true;
	}
	function validateEdit(){
		if(document.edit.ISBNe.value == "" ||
				(document.edit.Quantity.value == "" &&
				document.edit.Price.value == "")){
			document.getElementById("alertEdit").innerHTML = 'You must complete ISBN and new Quantity or Price*';
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
            <li><a href="items.jsp" class="current">Items</a></li>
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
        			Vector<Item> vc = aa.loadItems();
     		   %>
					
					<h1>Item list</h1>
		<%for(int i= 0; i<vc.size() ;i++)
				{%>
			<div class="items"><table cellspacing="10">
				<tr>
					<td class="camp">ISBN</td>
					<td class="valoare"><%out.print(vc.get(i).getIsbn());%></td>
				</tr>
				<tr>
					<td class="camp">Title </td>
					<td class="valoare"><%out.print(vc.get(i).getTitle());%></td>
				</tr>
				<tr>
					<td class="camp">Author </td>
					<td class="valoare"><%out.print(vc.get(i).getAuthor());%></td>
				</tr>
				<tr>
					<td class="camp">Publisher </td>
					<td class="valoare"><%out.print(vc.get(i).getPublisher());%></td>
				</tr>
				<tr>
					<td class="camp">Price</td>
					<td class="valoare"><%out.print(vc.get(i).getPrice());%></td>
				</tr>
				<tr>
					<td class="camp">Quantity</td>
					<td class="valoare"><%out.print(vc.get(i).getQuantity());%></td>
				</tr>
				</table>
				</div>
				<%} %>
				<div class="cleaner"></div>
				<h1>Delete book</h1>
				 <form onsubmit="return valideazaISBN()" action="items.jsp" method="post" name="modifica" >
			    &nbsp;&nbsp;&nbsp;
			    Insert ISBN:  <input type = "text" name = "ISBN" />
			    <input type = "submit" name = "bISBN" value = "Delete" onclick = "javascript:valideazaISBN();" style="background-color:black; color:white; padding:3px 15px" />
			    <div id = "alertISBN"></div><br/>
				</form>
				<%
				String eroare = "";
			
				if ((request.getParameter("ISBN") != null) && (request.getParameter("ISBN") != "")) {
					AdminActions a = new AdminActions();
					String ISBN = request.getParameter("ISBN");
					aa.deleteItem(ISBN);
					response.sendRedirect("items.jsp");
				}%>
			
			<h1>Insert new item</h1>
			
			<%
				
				if ((request.getParameter("ISBN1") != null) && (request.getParameter("ISBN1") != "")) {
					String ISBN1 = request.getParameter("ISBN1");
					String titlu = request.getParameter("titlu");
					String autor = request.getParameter("autor");
					String editura = request.getParameter("editura");
					double pret = Double.parseDouble(request.getParameter("pret"));
					String volume = request.getParameter("volume");
					int yearPublished = Integer.parseInt(request.getParameter("yearPublished"));
					int cant = Integer.parseInt(request.getParameter("cantitate"));
					AdminActions ac = new AdminActions();
					Item i = new Item(ISBN1,titlu,autor,volume,editura,yearPublished,pret,cant);
					ac.addItem(i);	
					response.sendRedirect("items.jsp");
				}
			%>
			
        	<form name="insert" action="items.jsp" method="post">
		<table cellspacing="30">
			<tr>
				<td>* ISBN </td>
				<td><input type="text" name="ISBN1"/></td>
			</tr>
			<tr>
				<td>* Title </td>
				<td><input type="text" name="titlu"/></td>
			</tr>
			<tr>
				<td>* Author </td>
				<td><input type="text" name="autor"/></td>
			</tr>
			<tr>
				<td>* Publisher </td>
				<td><input type="text" name="editura"/></td>
			</tr>
			<tr>
				<td>* Price </td>
				<td><input type="text" name="pret"/></td>
			</tr>
			<tr>
				<td>* Volume </td>
				<td><input type="text" name="volume"/></td>
			</tr>
			<tr>
				<td>* Year Published </td>
				<td><input type="text" name="yearPublished"/></td>
			</tr>
			<tr>
				<td>* Quantity </td>
				<td><input type="text" name="cantitate"/></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="insert"  onclick="return validate()" style="background-color:black; color:white; padding:3px 15px"/></td>
			</tr>
		</table>
		<table>
			<tr>
				<td id="alert" style="color:red;"><%=eroare%></td>
			</tr>
		</table>
	</form>
            <div class="cleaner_with_height">&nbsp;</div>
            
            <h1>Edit item</h1>
   			<%
				if ((request.getParameter("ISBNe") != null) && (request.getParameter("ISBNe") != ""))
				{
					String ISBNe = request.getParameter("ISBNe");
					String Quantity = request.getParameter("Quantity");
					String Price = request.getParameter("Price");
					AdminActions edit = new AdminActions();
					edit.editItem(ISBNe, Price, Quantity);
					response.sendRedirect("items.jsp");
				}
			%>
			<form name="edit" action="items.jsp" method="post">
		<table cellspacing="30">
			<tr>
				<td>* ISBN </td>
				<td><input type="text" name="ISBNe"/></td>
			</tr>
			<tr>
				<td>* Quantity </td>
				<td><input type="text" name="Quantity"/></td>
			</tr>
			<tr>
				<td>* Price </td>
				<td><input type="text" name="Price"/></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Edit"  onclick="return validateEdit()" style="background-color:black; color:white; padding:3px 15px"/></td>
			</tr>
		</table>
		<table>
			<tr>
				<td id="alertEdit" style="color:red;"><%=eroare%></td>
			</tr>
		</table>
	</form>
			<% } %>
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