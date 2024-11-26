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
<title>Admin Register</title>
<link
    href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
    rel="stylesheet"
/>
<link rel="stylesheet" href="admin_register.css">
</head>
<body>
	<div class="container">
		<div class="background"></div>
		<form action='admin_register.jsp' method='post' id="regForm" onsubmit='return validateForm()'>
			<div class="title">
				<h1>Admin Register</h1>
			</div>
			<div class="form-field">
				<i class="ri-user-4-fill"></i>
				<input type="text" placeholder="fullname" name="fullname">
			</div>
			<div class="form-field">
				<i class="ri-user-3-fill"></i>
				<input type="email" placeholder="username" name="username">
			</div>
			<div class="form-field">
				<i class="ri-contacts-fill"></i>
				<input type="number" placeholder="contact" name="contact">
			</div>
			<div class="form-field">
				<i class="ri-lock-password-fill"></i>
				<input type="password" placeholder="password" name="pwd">
			</div>
			<div class="form-field">
				<i class="ri-lock-password-line"></i>
				<input type="password" placeholder="confirm password" name="cnf">
			</div>
			<div class="button-field">
				<input type="submit" value="Register">
			</div><br>
			<p style='margin-top: 5px;
    font-weight: 510;'>Already have an account?<br>
			<a href="admin_login.jsp" style="text-decoration:none">click here</a> to Login</p>
		</form>
		
	</div>
	
	<%
		String fullname=request.getParameter("fullname");
		String username=request.getParameter("username");
		String contact=request.getParameter("contact");
		String pwd=request.getParameter("pwd");
		String cnf=request.getParameter("cnf");
		if(fullname!=null || username!=null || contact!=null || pwd!=null || cnf!=null ){
			System.out.println(fullname+" "+username+" "+contact+" "+pwd+" "+cnf);
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management","root","Subham102@");
				String sql1="INSERT INTO admin_register (Fullname,Username,ContactNo) Values(?,?,?)";
				PreparedStatement stmt1 = con.prepareStatement(sql1);
				stmt1.setString(1,fullname);
				stmt1.setString(2,username);
				stmt1.setString(3,contact);
				stmt1.executeUpdate();
				
				String sql2="INSERT INTO admin_login VALUES(?,?)";
				PreparedStatement stmt2 = con.prepareStatement(sql2);
				stmt2.setString(1,username);
				stmt2.setString(2,pwd);
				stmt2.executeUpdate();
				stmt1.close();
				stmt2.close();
				con.close();
				response.sendRedirect("admin_login.jsp");
				
				
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		
	%>
	<script>
		function validateForm(){
			var fullname = document.getElementById("regForm").fullname.value;
			var username = document.getElementById("regForm").username.value;
			var contact = document.getElementById("regForm").contact.value;
			var pwd = document.getElementById("regForm").pwd.value;
			var cnf = document.getElementById("regForm").cnf.value;
			if(fullname==='' || username==='' || contact==='' || pwd==='' || cnf==='' ){
				alert('All field required!!')
				return false;
			}
			if(pwd!=cnf){
				alert("Password does'nt match!!")
				var pwd=document.getElementById("regForm").pwd.value=''
				var cnf=document.getElementById("regForm").cnf.value=''
				
				return false;
			}
			if(contact.length!=10){
				alert("Invalid contact number!!")
				return false
			}
			return true
		}
		
			
		
	</script>
	
	
</body>
</html>