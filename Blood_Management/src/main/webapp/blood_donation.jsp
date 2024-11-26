<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Blood Donation Details</title>
<link rel="stylesheet" href="blood_donation_detail.css">
<link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body style="background-color: #ddd;" onload="hideMessage()">
    <%
    HttpSession session1 = request.getSession();
    String user = (String) session1.getAttribute("user");
    String fullname = "";
    if (user == null) {
        response.sendRedirect("admin_login.jsp");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management", "root", "Subham102@");
            String sql = "SELECT Fullname FROM admin_register WHERE Username=?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, user);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                fullname = rs.getString(1);
            }
            stmt.close();
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    %>
    <div class="header">
        <h2>Welcome, <%= fullname %></h2>
        <h1 style="font-family:Gowun Batang;"><i class="ri-service-fill"></i> E-RaktKendra </h1>
        <a href="logout.jsp">Logout <i class="ri-logout-box-r-line"></i></a>
    </div>
    <div class="content">
        <div class="options">
            <div class="opt"><a href="admin_dashboard.jsp"><i class="ri-home-8-line"></i> Home</a></div>
            <div class="opt"><a href="donor_detail.jsp"><i class="ri-user-shared-2-fill"></i> Donor Details</a></div>
            <div class="opt"><a href="patient_detail.jsp"><i class="ri-user-heart-fill"></i> Patient Details</a></div>
            <div class="opt"><a href="blood_donation.jsp"><i class="ri-hand-heart-fill"></i>    Blood Donation</a></div>
            <div class="opt"><a href="blood_donation_history.jsp"><i class="ri-hand-heart-fill"></i>    Blood Donation History</a></div>
            <div class="opt"><a href="admin_blood_request.jsp"><i class="ri-hand"></i> Blood Request</a></div>
            <div class="opt"><a href="admin_blood_request_history.jsp"><i class="ri-history-fill"></i> Blood Request History</a></div>
            <div class="opt-last"><a href="blood_stock.jsp"><i class="ri-funds-box-line"></i> Blood Stock</a></div>
        </div>
        <div class="main-container">
            <div class="donor-heading">
                <h1>BLOOD DONATION DETAILS</h1>
            </div>
            <%
            			
            String msg=request.getParameter("msg");			
            if("reject".equals(msg)){
            				
            		%>
            			<h2 class="donor-heading" id="message" style="color:red;">Donation Rejected!! </h2>
            		<% } %>
            <%
            			
            		
            if("approved".equals(msg)){
            				
            		%>
            			<h2 class="donor-heading" id="message" style="color:green;">Donation Approved Successfully!! </h2>
            		<% } %>
            <div class="container2">
                <div class="input-field">
                    <label>Enter Fullname to filter</label>
                    <input type="text" id='userInput' onkeyup='return filterTable()'>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>RequestId</th>
                            <th>Donor_Name</th>
                            <th>Donor_Age</th>
                            <th>Disease</th>
                            <th>Bloodgroup</th>
                            <th>Unit</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id='table'>
                        <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management", "root", "Subham102@");
                            String sql = "select * from blood_donation where Status='Pending'";
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
                                    <td>
                                        <a href="approve_blood_donation.jsp?RequestId=<%= rs.getInt(1) %>&BloodgroupId=<%= rs.getString(8) %>&Unit=<%= rs.getString(6) %>" 
                           style="padding: 5px 11px; border-radius: 5px;margin-right: 15px; background: #4CAF50; color: white; text-decoration: none;">Approve</a>
                                        <a href="reject_blood_donation.jsp?RequestId=<%= rs.getInt(1) %>" style="padding: 4px 14px; background: #f44336; color: white; border: 2px solid #f44336; text-decoration: none; border-radius: 6px; outline: none; font-weight: 510;">Reject</a>
                                    </td>
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
    <script>
    function hideMessage() {
            const messageElement = document.getElementById("message");
            if (messageElement) {
                setTimeout(() => {
                    messageElement.style.display = 'none';
                }, 3000);
            }
        }
    </script>
</body>
</html>
