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
<title>Patient Dashboard</title>
<link rel="stylesheet" href="patient_dashboard.css">
<link
    href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
    rel="stylesheet"/>
</head>
<body style="background-color: #ddd;">
	<%
	HttpSession session1=request.getSession();
	String user=(String)session1.getAttribute("user");
	String fullname="";
	if(user==null){
		response.sendRedirect("patient_login.jsp");
	}else{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
			String sql="SELECT Fullname FROM patient_register WHERE Username=?";
			PreparedStatement stmt=con.prepareStatement(sql);
			stmt.setString(1, user);
			ResultSet rs=stmt.executeQuery();
			if(rs.next()) {
				fullname=rs.getString(1);
			}	
			stmt.close();
			con.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	%>
	<div class="header">
        <h2>Welcome, <%=fullname %></h2>
        <h1 style="font-family:Gowun Batang;"><i class="ri-service-fill"></i>		E-RaktKendra </h1>
        <a href="logout.jsp">Logout <i class="ri-logout-box-r-line"></i></a>
	</div>
	<div class="content">
        <div class="options">
            <div class="opt"><a href="patient_dashboard.jsp"><i class="ri-home-8-line"></i> Home</a></div>
            <div class="opt"><a href="make_request.jsp"><i class="ri-user-shared-2-fill"></i>    Make Request</a></div>
            <div class="opt"><a href="request_history.jsp"><i class="ri-user-heart-fill"></i>    Request History</a></div>
        </div>
        <div class="main-content">
        <%
        	String total_request="";
        	String pending_request="";
        	String approved_request="";
        	String rejected_request="";
        	try{
        		Class.forName("com.mysql.cj.jdbc.Driver");
    			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
    			
    			PreparedStatement stmt1=con.prepareStatement("SELECT count(*) from blood_request");
    			ResultSet rs=stmt1.executeQuery();
    			if(rs.next()) {
    				total_request=rs.getString(1);
    			}	
    			stmt1.close();
    			
    			PreparedStatement stmt2=con.prepareStatement("SELECT count(*) from blood_request where Status='Pending'");
    			ResultSet rs2=stmt2.executeQuery();
    			if(rs2.next()) {
    				pending_request=rs2.getString(1);
    			}	
    			stmt2.close();
    			
    			PreparedStatement stmt3=con.prepareStatement("SELECT count(*) from blood_request where Status='Approved'");
    			ResultSet rs3=stmt3.executeQuery();
    			if(rs3.next()) {
    				approved_request=rs3.getString(1);
    			}	
    			stmt3.close();
    			
    			PreparedStatement stmt4=con.prepareStatement("SELECT count(*) from blood_request where Status='Rejected'");
    			ResultSet rs4=stmt4.executeQuery();
    			if(rs4.next()) {
    				rejected_request=rs4.getString(1);
    			}	
    			stmt4.close();
    			con.close();
    		}catch(Exception ex){
    			ex.printStackTrace();
    		}
        %>
            <div class="blood-data">
                <div class="box2"><h1><i class="ri-user-heart-fill"></i></h1><h3>Request Made : <%=total_request %></h3></div>
                <div class="box2"><h1><i class="ri-loop-right-line"></i></h1><h3>Pending Request : <%=pending_request %></h3></div>
                <div class="box2"><h1><i class="ri-checkbox-circle-line"></i></h1><h3>Approved Request : <%=approved_request %></h3></div>
                <div class="box2"><h1><i class="ri-close-circle-line"></i></h1><h3>Rejected Request : <%=rejected_request %></h3></div>
            </div>
        </div>
    </div>        
</body>
</html>