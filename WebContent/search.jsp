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
			document.getElementById("alertISBN").innerHTML= "<h5 class='alert'>You must fill in the ISBN</h5>";
			return false;
		}
	}

	function valideazaAuthor(){
		if(modifica1.Author.value =="" || modifica2.Author.value ==null){
			document.getElementById("alertAuthor").innerHTML= "<h5 class='alert'>You must fill in the Author</h5>";
			return false;
		}
	}
	function valideazaTitlu(){
		if(modifica2.Title.value =="" || modifica3.Title.value ==null){
			document.getElementById("alertTitlu").innerHTML= "<h5 class='alert'>You must fill in the Title</h5>";
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
            <li><a href="search.jsp" class="current">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>     
            <li><a href="customers.jsp">Customers</a></li>
            <li><a href="items.jsp">Items</a></li>
            <li><a href="myaccount.jsp">My account</a></li>       
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else if(session.getAttribute("customer")=="da"){%>
			<li><a href="index.jsp">Home</a></li>
            <li><a href="search.jsp" class="current">Search</a></li>
            <li><a href="contact.jsp">Contact</a></li>  
            <li><a href="myaccount.jsp">My account</a></li>  
            <li><a href="cart.jsp">Cart</a></li>          
            <li><a href="logout.jsp">Logout</a></li>  
			<%}else{%>
			<li><a href="index.jsp">Home</a></li>
            <li><a href="search.jsp" class="current">Search</a></li>
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

			<h1>Search items</h1>
            <div class="cleaner_with_height">&nbsp;</div>
            
            <form onsubmit="return valideazaISBN()" action="search.jsp" method="post" name="modifica" >
			    &nbsp;&nbsp;&nbsp;Search ISBN:  <input type = "text" name = "ISBN" />
			    <input type = "submit" name = "bISBN" value = "Search" onclick = "javascript:valideazaISBN();"  style="background-color:black; color:white; padding:3px 15px"/>
			    <div id = "alertISBN"></div><br/>
			</form>
			<%
				String eroare = "";
			
				if ((request.getParameter("ISBN") != null) && (request.getParameter("ISBN") != "")) {
					GuestActions is = new GuestActions();
					String ISBN = request.getParameter("ISBN");
					ArrayList<Item> ar = new ArrayList<Item>();
					ar = is.searchByISBN(ISBN);
					if(ar.size()>0)
						for(int i = 0;i<ar.size();i++)
						{
							//String ISBN = ar.get(i).getIsbn();
							String author = ar.get(i).getAuthor();
							String title = ar.get(i).getTitle();
							String volume = ar.get(i).getVolume();
							String publisher = ar.get(i).getPublisher();
							int yearPublished = ar.get(i).getYearPublished();
							double price = ar.get(i).getPrice();
							%>
							<table cellspacing="10">
								<tr>
									<td>ISBN </td>
									<td class="valoare"><%out.print(ISBN);%></td>
								</tr>
								<tr>
									<td>Author </td>
									<td class="valoare"><%out.print(author);%></td>
								</tr>
								<tr>
									<td>Title </td>
									<td class="valoare"><%out.print(title);%></td>
								</tr>
								<tr>
									<td>Volume </td>
									<td class="valoare"><%out.print(volume);%></td>
								</tr>
								<tr>
									<td>YearPublished </td>
									<td class="valoare"><%out.print(yearPublished);%></td>
								</tr>
								<tr>
									<td>Price </td>
									<td class="valoare"><%out.print(price);%></td>
								</tr>
								<%if(session.getAttribute("customer")=="da"){ %>
								<tr>
									<td> </td>
									<td class="valoare"><div class="buy_now_button"><a href="cart.jsp?addproduct=<%=ISBN %>">Buy Now</a></div></td>
								</tr>
								<%} %>
								<tr>
								</tr>
							</table>
							<%
						}
					else{
						eroare = "No item was found";
						out.print(eroare);
					}
					
				}
			%>
			 <form onsubmit="return valideazaAuthor()" action="search.jsp" method="post" name="modifica1" >
			    &nbsp;&nbsp;&nbsp;Search by Author:  <input type = "text" name = "Author" />
			    <input type = "submit" name = "bAuthor" value = "Search" onclick = "javascript:valideazaAuthor();"  style="background-color:black; color:white; padding:3px 15px"/>
			    <div id = "alertAuthor"></div><br/>
			</form>
			<%
				
			
				if ((request.getParameter("Author") != null) && (request.getParameter("Author") != "")) {
					GuestActions is = new GuestActions();
					String author = request.getParameter("Author");
					ArrayList<Item> ar = new ArrayList<Item>();
					ar = is.searchByAuthor(author);
					if(ar.size()>0)
						for(int i = 0;i<ar.size();i++)
						{
							String ISBN = ar.get(i).getIsbn();
							//String author = ar.get(i).getAuthor();
							String title = ar.get(i).getTitle();
							String volume = ar.get(i).getVolume();
							String publisher = ar.get(i).getPublisher();
							int yearPublished = ar.get(i).getYearPublished();
							double price = ar.get(i).getPrice();
							%>
							<table cellspacing="10">
								<tr>
									<td>ISBN </td>
									<td class="valoare"><%out.print(ISBN);%></td>
								</tr>
								<tr>
									<td>Author </td>
									<td class="valoare"><%out.print(author);%></td>
								</tr>
								<tr>
									<td>Title </td>
									<td class="valoare"><%out.print(title);%></td>
								</tr>
								<tr>
									<td>Volume </td>
									<td class="valoare"><%out.print(volume);%></td>
								</tr>
								<tr>
									<td>YearPublished </td>
									<td class="valoare"><%out.print(yearPublished);%></td>
								</tr>
								<tr>
									<td>Price </td>
									<td class="valoare"><%out.print(price);%></td>
								</tr>
								<%if(session.getAttribute("customer")=="da"){ %>
								<tr>
									<td> </td>
									<td class="valoare"><div class="buy_now_button"><a href="cart.jsp?addproduct=<%=ISBN %>">Buy Now</a></div></td>
								</tr>
								<%} %>
								<tr>
								</tr>
							</table>
							<%
						}
					else{
						eroare = "No item was found";
						out.print(eroare);
					}
					
				}
			%>
			 <form onsubmit="return valideazaTitlu()" action="search.jsp" method="post" name="modifica2" >
			    &nbsp;&nbsp;&nbsp;Search by Title:  <input type = "text" name = "Title" />
			    <input type = "submit" name = "bTitle" value = "Search" onclick = "javascript:valideazaTitlu();"  style="background-color:black; color:white; padding:3px 15px"/>
			    <div id = "alertTitlu"></div><br/>
			</form>
			<%
				
			
				if ((request.getParameter("Title") != null) && (request.getParameter("Title") != "")) {
					GuestActions is = new GuestActions();
					String Title = request.getParameter("Title");
					ArrayList<Item> ar = new ArrayList<Item>();
					ar = is.searchByTitle(Title);
					if(ar.size()>0)
						for(int i = 0;i<ar.size();i++)
						{
							String ISBN = ar.get(i).getIsbn();
							String author = ar.get(i).getAuthor();
							String title = ar.get(i).getTitle();
							String volume = ar.get(i).getVolume();
							String publisher = ar.get(i).getPublisher();
							int yearPublished = ar.get(i).getYearPublished();
							double price = ar.get(i).getPrice();
							%>
							<table cellspacing="10">
								<tr>
									<td>ISBN </td>
									<td class="valoare"><%out.print(ISBN);%></td>
								</tr>
								<tr>
									<td>Author </td>
									<td class="valoare"><%out.print(author);%></td>
								</tr>
								<tr>
									<td>Title </td>
									<td class="valoare"><%out.print(title);%></td>
								</tr>
								<tr>
									<td>Volume </td>
									<td class="valoare"><%out.print(volume);%></td>
								</tr>
								<tr>
									<td>YearPublished </td>
									<td class="valoare"><%out.print(yearPublished);%></td>
								</tr>
								<tr>
									<td>Price </td>
									<td class="valoare"><%out.print(price);%></td>
								</tr>
								<%if(session.getAttribute("customer")=="da"){ %>
								<tr>
									<td> </td>
									<td class="valoare"><div class="buy_now_button"><a href="cart.jsp?addproduct=<%=ISBN %>">Buy Now</a></div></td>
								</tr>
								<%} %>
								<tr>
								</tr>
							</table>
							<%
						}
					else{
						eroare = "No item was found";
						out.print(eroare);
					}
					
				}
			%>

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