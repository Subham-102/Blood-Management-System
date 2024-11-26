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
<title>Admin Dashboard</title>
<link rel="stylesheet" href="admin_dashboard.css">
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
        <div class="main-content">
            <%
        String apos ="";
        String aneg="";
        String bpos="";
        String bneg="";
        String abpos="";
        String abneg="";
        String opos="";
        String oneg="";
        int unitsum=0;
        String total_donor="";
        String total_request="";
        String approved_request="";
        	try{
        		Class.forName("com.mysql.cj.jdbc.Driver");
    			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
    			
    			PreparedStatement stmt1=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='A+'");
    			ResultSet rs=stmt1.executeQuery();
    			if(rs.next()) {
    				apos=rs.getString(1);
    			}	
    			stmt1.close();
    			
    			PreparedStatement stmt2=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='A-'");
    			ResultSet rs2=stmt2.executeQuery();
    			if(rs2.next()) {
    				aneg=rs2.getString(1);
    			}	
    			stmt2.close();
    			
    			PreparedStatement stmt3=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='B+'");
    			ResultSet rs3=stmt3.executeQuery();
    			if(rs3.next()) {
    				bpos=rs3.getString(1);
    			}	
    			stmt3.close();
    			
    			PreparedStatement stmt4=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='B-'");
    			ResultSet rs4=stmt4.executeQuery();
    			if(rs4.next()) {
    				bneg=rs4.getString(1);
    			}	
    			stmt4.close();
    			
    			PreparedStatement stmt5=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='AB+'");
    			ResultSet rs5=stmt5.executeQuery();
    			if(rs5.next()) {
    				abpos=rs5.getString(1);
    			}	
    			stmt5.close();
    			
    			PreparedStatement stmt6=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='AB-'");
    			ResultSet rs6=stmt6.executeQuery();
    			if(rs6.next()) {
    				abneg=rs6.getString(1);
    			}	
    			stmt6.close();
    			
    			PreparedStatement stmt7=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='O+'");
    			ResultSet rs7=stmt7.executeQuery();
    			if(rs7.next()) {
    				opos=rs7.getString(1);
    			}	
    			stmt7.close();
    			
    			PreparedStatement stmt8=con.prepareStatement("SELECT Units FROM blood_stock where Blood_Group='O-'");
    			ResultSet rs8=stmt8.executeQuery();
    			if(rs8.next()) {
    				oneg=rs8.getString(1);
    			}	
    			stmt8.close();
    			
    			
    			PreparedStatement stmt9=con.prepareStatement("select sum(Units) as unitsum from blood_stock");
    			ResultSet rs9=stmt9.executeQuery();
    			if(rs9.next()) {
    				unitsum=rs9.getInt(1);
    			}	
    			stmt9.close();
    			
    			PreparedStatement stmt10=con.prepareStatement(" select count(*) from blood_donation where Status='Approved'");
    			ResultSet rs10=stmt10.executeQuery();
    			if(rs10.next()) {
    				total_donor=rs10.getString(1);
    			}	
    			stmt10.close();
    			
    			PreparedStatement stmt11=con.prepareStatement(" select count(*) from blood_request");
    			ResultSet rs11=stmt11.executeQuery();
    			if(rs11.next()) {
    				total_request=rs11.getString(1);
    			}	
    			stmt11.close();
    			
    			PreparedStatement stmt12=con.prepareStatement(" select count(*) from blood_request where Status='Approved'");
    			ResultSet rs12=stmt12.executeQuery();
    			if(rs12.next()) {
    				approved_request=rs12.getString(1);
    			}	
    			stmt12.close();
    			con.close();
    		}catch(Exception ex){
    			ex.printStackTrace();
    		}
    	
    			
        	
        %>
            <div class="blood-units">
                <div class="box1"><h1>A+    <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=apos %></p></div>
                <div class="box1"><h1>A-    <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=aneg %></p></div>
                <div class="box1"><h1>B+    <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=bpos %></p></div>
                <div class="box1"><h1>B-    <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=bneg %></p></div>
            </div>
            <div class="blood-units">
                <div class="box1"><h1>AB+    <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=abpos %></p></div>
                <div class="box1"><h1>AB-    <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=abneg %></p></div>
                <div class="box1"><h1>O+   <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=opos %></p></div>
                <div class="box1"><h1>O-   <i class="ri-contrast-drop-2-line"></i></h1><p>Units left : <%=oneg %></p></div>
            </div>
            <div class="blood-data">
                <div class="box2"><h1><i class="ri-group-fill"></i></h1><h3>Total Donors : <%=total_donor %></h3></div>
                <div class="box2"><h1><i class="ri-align-item-bottom-line"></i></h1><h3>Total Requests : <%=total_request %></h3></div>
                <div class="box2"><h1><i class="ri-checkbox-circle-line"></i></h1><h3>Approved Requests : <%=approved_request %></h3></div>
                <div class="box2"><h1><i class="ri-contrast-drop-2-fill"></i></h1><h3>Total Blood Units : <%=unitsum %></h3></div>
            </div>
        </div>
    </div>
</body>
</html>