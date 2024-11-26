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
<title>Blood Request History</title>
<link rel="stylesheet" href="admin_blood_request.css">
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
		response.sendRedirect("admin_login.jsp");
	}else{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
			String sql="SELECT Fullname FROM admin_register WHERE Username=?";
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
            <div class="opt"><a href="admin_dashboard.jsp"><i class="ri-home-8-line"></i> Home</a></div>
            <div class="opt"><a href="donor_detail.jsp"><i class="ri-user-shared-2-fill"></i>    Donor Details</a></div>
            <div class="opt"><a href="patient_detail.jsp"><i class="ri-user-heart-fill"></i>    Patient Details</a></div>
            <div class="opt"><a href="blood_donation.jsp"><i class="ri-hand-heart-fill"></i>    Blood Donation</a></div>
            <div class="opt"><a href="blood_donation_history.jsp"><i class="ri-hand-heart-fill"></i>    Blood Donation History</a></div>
            <div class="opt"><a href="admin_blood_request.jsp"><i class="ri-hand"></i>    Blood Request</a></div>
            <div class="opt"><a href="admin_blood_request_history.jsp"><i class="ri-history-fill"></i>   Blood Request History</a></div>
            <div class="opt-last"><a href="blood_stock.jsp"><i class="ri-funds-box-line"></i>    Blood Stock</a></div>
        </div>
        <div class="main-container">
        	<div class="donor-heading">
        		<h1>BLOOD REQUEST HISTORY</h1>
        	</div>
			<div class="container2" >
				<div class="input-field">
					<label>Enter Fullname to filter</label>
					<input type="text" id='userInput' onkeyup='return filterTable()'>
				</div>
				<table>
					<thead>
						<tr>
							<th>RequestId</th>
							<th>Patient_Name</th>
							<th>Patient_Age</th>
							<th>Reason</th>
							<th>Bloodgroup</th>
							<th>Unit</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody id='table'>
						<%
                    	try {
                        	Class.forName("com.mysql.cj.jdbc.Driver");
                        	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management", "root", "Subham102@");
                        	String sql = "SELECT * FROM blood_request";
                        	PreparedStatement stmt = con.prepareStatement(sql);
                        	ResultSet rs = stmt.executeQuery();
                        	boolean hasUsers = false;
                        	while (rs.next()) {
                            	hasUsers = true;
                    	%>
                            	<tr>
                                	<td><%= rs.getInt(1) %></td>
                                	<td><%= rs.getString(2) %></td>
                                	<td><%= rs.getString(3) %></td>
                                	<td><%= rs.getString(4) %></td>
                                	<td><%= rs.getString(5) %></td>
                                	<td><%= rs.getString(6) %></td>
                                	<td><%= rs.getString(7) %></td>
                                    	
                                    	
                               	 	
                            	</tr>
                    	<%
                        	}
                        	if (!hasUsers) {
                    	%>
                            	<tr>
                                	<td colspan="7">No Users Available!!</td>
                            	</tr>
                    	<%
                        	}
                        	stmt.close();
                        	con.close();
                    	} catch (Exception ex) {
                        	ex.printStackTrace();
                    	}
      	%>
					
					
					</tbody>
				</table>
			</div>
		</div>
    </div>    
   
</body>
</html>