<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<link rel="stylesheet" href="style.css">
<link
    href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
    rel="stylesheet"
/>
</head>
<body>
	<div class="header">
		<h1><i class="ri-service-fill"></i>E-RaktKendra</h1>
		<div class="option">
			<a href="index.jsp"> <i class="ri-home-heart-fill"></i>Home</a>
			<a href="patient_login.jsp"><i class="ri-user-fill"></i>Patient </a>
			<a href="donor_login.jsp"><i class="ri-hand-heart-fill"></i>Donor </a>
			<a href="admin_login.jsp"><i class="ri-admin-fill"></i>Admin</a>
		</div>
	</div>
	<div class="content1">
			<div class="content-image">
			</div>
			<div class="text">
				<h1 style="padding-left:150px;">What is it?</h1><br>
			    <br>
				Blood Collected straight from the donor into a blood bag and<br> mixed with an anticoagulant is called as whole blood.<br> This collected whole blood is then centrifuged and red cell,<br> platelets and plasma are separated. The separated Red cells<br> are mixed with a preservative to be called as packed red blood cells.<br>
                <br>
                <h1 style="padding-left:140px;">Who can donate?</h1>
                <br>
                <br>You need to be 18-65 years old, weight 45kg or more and be fit and healthy.
                <div class="buton">
                	<a href="donor_login.jsp">Become a Donor</a>
                	<a href="patient_login.jsp">Request for Blood</a>
                </div>
			</div>
	</div>
	<div class="content2">
		<div class="content-image2"> 
		</div>
	</div>
	<div class="about">
		<div class="about-text">
		<h1 style="padding-left:200px">About Us</h1>
		<p style="padding-left:50px">Blood bank is a place where blood bag that is collected from blood<br> donation events is stored in one place .The term "blood bank" refers to <br> division of a hospital laboratory where the storage of blood product <br> occurs and where proper testing is performed to reduce the risk of <br> tranfusion related events. The process of managing the blood bag that<br> is received from the blood donation events needs a proper and <br> systematic management .The blood bag must be handled with care and treated thoroughly as it is related to someone's life.The development of <br> Web-based Blood Bank And Donation Management System(BBDMS) is<br> proposed to provide a management functional to the blood bank in <br> order to handle the blood bag and to make entries of the individuals<br> who want to donate blood and who are in need </p>
		</div>
		<div class="about-image">
		</div>
	</div>
	<div class="footer-container">
		<div class="footer-content">
			<div class="footer-text">
				<h2 style="padding:20px 20px;">Looking For Blood</h2>
				<a style="padding-left:20px;" href="#">Blood Availability</a><br>
				<a style="padding-left:20px;" href="#">Blood Bank Directory</a>
			</div>
			<div class="footer-text">
				<h2 style="padding:20px 0; text-wrap: no-wrap;">Want To Donate Blood</h2>
				<a href="#" >Blood Donation Camps</a><br>
				<a href="#" >Donor Login</a><br>
				<a href="#" >About Blood Donation</a><br>
			</div>
		</div>
		<div class="footer-contact">
			<button class="glow-on-hover">Contact Us</button>
			<p><i  class="ri-phone-fill"></i>	Contact No - <a href="tel:+919046616031">+91 9046616031</a><br> <i  class="ri-mail-fill"></i>	Email - <a href="mailto:sanjeevnisrivastava46@gmail.com" style="text-decoration: none; padding-bottom: 15px;">sanjeevnisrivastava46@gmail.com</a><br> </p><br>
			<a href="https://www.linkedin.com/in/sanjeevni-srivastava-17492a2b9/" class="icons"><i style="background-color: #0077B5;" class="ri-linkedin-fill"></i></a>
			<a href="https://github.com/Subham-102" class="icons"><i style="background-color: #181717;" class="ri-github-fill"></i></a>
			<a href="https://facebook.com" class="icons"><i style="background-color: rgba(0,0,255,0.9);" class="ri-facebook-circle-fill"></i></a>
			<a href="#" class="icons"><i style="background: linear-gradient(45deg, #F58529, #DD2A7B, #8134AF, #515BD4);" class="ri-instagram-line"></i></a>
			<a href="#" class="icons"><i style="background-color: #25D366;" class="ri-whatsapp-line"></i></a>
		</div>
	</div>
	<div class="footer">
		<i class="ri-copyright-line"></i>
		<p ><pre> </pre>CopyRight. All Rights Reserved.2022-2026
	</div>
	<button id="backToTop" class="back-to-top"><i class="ri-arrow-up-fill"></i></button>
	<script>
		const backToTopButton = document.getElementById("backToTop");
		window.onscroll = function() {
	    	if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
	        	backToTopButton.style.display = "block";
	    	} else {
	        	backToTopButton.style.display = "none";
	    	}
		};
		backToTopButton.onclick = function() {
	    	window.scrollTo({top: 0, behavior: 'smooth'});
		};
	</script>
</body>
</html>
