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
<title>Reject Blood Donation</title>
</head>
<body>
	<%
		String RequestId=request.getParameter("RequestId");
		String msg="reject";
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management", "root", "Subham102@");
        	String sql = "update blood_donation set Status='Rejected' where RequestId=?";
        	PreparedStatement stmt = con.prepareStatement(sql);
        	stmt.setString(1,RequestId);
        	stmt.executeUpdate();
        	
        	response.sendRedirect("blood_donation.jsp?msg=" +msg);
		}catch (Exception ex) {
        	ex.printStackTrace();
        	response.sendRedirect("blood_donation.jsp?msg=" +msg);
    	}
	%>
</body>
</html>