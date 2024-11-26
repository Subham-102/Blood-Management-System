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
<title>Make Donation</title>
<link rel="stylesheet" href="make_donation.css">
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
		response.sendRedirect("donor_login.jsp");
	}else{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
			String sql="SELECT Fullname FROM donor_register WHERE Username=?";
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
            <div class="opt"><a href="donor_dashboard.jsp"><i class="ri-home-8-line"></i> Home</a></div>
            <div class="opt"><a href="make_donation.jsp"><i class="ri-user-shared-2-fill"></i>    Donate Blood</a></div>
            <div class="opt"><a href="donation_history.jsp"><i class="ri-user-heart-fill"></i>    Donation History</a></div>
        </div>
        <div class="container">
		
		<form action='make_donation.jsp' method='post' id="regForm" onsubmit='return validateForm()'>
			<div class="title">
				<h1>Donate Blood</h1>
			</div>
			<div class="form-field">
				<i class="ri-user-4-fill"></i>
				<input type="text" placeholder="Donor Name" name="donorname">
			</div>
			<div class="form-field">
				<i class="ri-user-3-fill"></i>
				<input type="text" placeholder="Donor Age" name="age">
			</div>
			<div class="form-field">
				<i class="ri-questionnaire-line"></i>
				<input type="text" placeholder="Disease" name="disease">
			</div>
			<div class="form-field">
			<i class="ri-contrast-drop-2-line"></i>
			<select  name="bloodgroup">
                    		<option selected value="">Choose Blood group</option>
                    		<option value="A+">A+</option>
                    		<option value="A-">A-</option>
                    		<option value="B+">B+</option>
                    		<option value="B-">B-</option>
                    		<option value="AB+">AB+</option>
                    		<option value="AB-">AB-</option>
                    		<option value="O+">O+</option>
                    		<option value="O-">O-</option>
                    	</select>
                    	<select  name="bloodgroupid">
                    		<option selected value="">Blood group Id</option>
                    		<option value="1">1 (A+)</option>
                    		<option value="2">2 (A-)</option>
                    		<option value="3">3 (B+)</option>
                    		<option value="4">4 (B-)</option>
                    		<option value="5">5 (AB+)</option>
                    		<option value="6">6 (AB-)</option>
                    		<option value="7">7 (O+)</option>
                    		<option value="8">8 (O-)</option>
                    	</select>
			</div>
			
			<div class="form-field">
				<i class="ri-align-item-bottom-line"></i>
				<input type="number" placeholder="Unit (in ml)" name="unit">
			</div>
			
			<div class="button-field">
				<input type="submit" value="Donate">
			</div>
			
		</form>
		
	</div>
    </div> 
    <%
		String donorname=request.getParameter("donorname");
		String age=request.getParameter("age");
		String disease=request.getParameter("disease");
		String bloodgroup=request.getParameter("bloodgroup");
		String bloodgroupid=request.getParameter("bloodgroupid");
		String unit=request.getParameter("unit");
		
		if(donorname!=null ||age!=null ||disease!=null || bloodgroup!=null ||bloodgroupid!=null || unit!=null  ){
			System.out.println(donorname+" "+age+" "+disease+" "+bloodgroup+" "+bloodgroupid+" "+unit);
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
				String sql1="INSERT INTO blood_donation (Donor_Name,Donor_Age,Disease,Bloodgroup,Unit,Status,BloodgroupId) Values(?,?,?,?,?,'Pending',?)";
				PreparedStatement stmt1 = con.prepareStatement(sql1);
				stmt1.setString(1,donorname);
				stmt1.setString(2,age);
				stmt1.setString(3,disease);
				stmt1.setString(4,bloodgroup);
				stmt1.setString(5,unit);
				stmt1.setString(6,bloodgroupid);
				stmt1.executeUpdate();
				
				
				stmt1.close();
				
				con.close();
				response.sendRedirect("donation_history.jsp");
				
				
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		
	%> 
    <script>
		function validateForm(){
			var donorname = document.getElementById("regForm").donorname.value;
			var age = document.getElementById("regForm").age.value;
			var disease = document.getElementById("regForm").disease.value;
			var bloodgroup = document.getElementById("regForm").bloodgroup.value;
			var bloodgroupid = document.getElementById("regForm").bloodgroupid.value;
			var unit = document.getElementById("regForm").unit.value;
			if(donorname==='' || age==='' || disease==='' || bloodgroup==='' ||bloodgroupid==='' || unit==='' ){
				alert('All field required!!')
				return false;
			}
			
			
			if(age>100){
				alert("Invalid Age!!")
				return false
			}
			
			if(age<=0){
				alert("Invalid Age!!")
				return false
			}
			if(unit>1000){
				alert("Enter unit below 1000!!")
				return false
			}
			if(unit<=0){
				alert("Enter positive unit !!")
				return false
			}
			return true
		}
		
			
		
	</script>
        
            
</body>
</html>