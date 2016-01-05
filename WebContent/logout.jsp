<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*,database.*,actions.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delogare</title>
</head>
<body>
<% 
if (session.getAttribute("userSession")!=null){
	session.removeAttribute("userSession");
	session.invalidate();
}

response.sendRedirect("login.jsp");
%>
</body>
</html>