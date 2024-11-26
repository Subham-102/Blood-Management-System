<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Stock</title>
</head>
<body>
	<%
		String blood_group=request.getParameter("blood_group");
		String units=request.getParameter("units");
		
		if (blood_group != null && units != null && !blood_group.isEmpty() && !units.isEmpty()) {
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
			
				String sql="update blood_stock set Units=? where Blood_Group=?";
				PreparedStatement stmt=con.prepareStatement(sql);
			
				stmt.setString(1, units);
				stmt.setString(2, blood_group);
			
			
				stmt.executeUpdate();
				String msg = "valid";
				stmt.close();
				con.close();
				response.sendRedirect("blood_stock.jsp?msg=" +msg);
			}
			catch(Exception ex){
			response.sendRedirect("blood_stock.jsp?msg=invalid");
			ex.printStackTrace();
		}}else{response.sendRedirect("blood_stock.jsp?msg=invalid");}
	%>
</body>
</html>