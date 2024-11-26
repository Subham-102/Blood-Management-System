<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Approve Blood Request</title>
</head>
<body>
    <%
        String requestId = request.getParameter("RequestId");
        String bloodGroupidStr = request.getParameter("BloodgroupId"); 
        String unitStr = request.getParameter("Unit");
        String msg="";

        if (requestId != null && bloodGroupidStr != null && unitStr != null) {
            try {
                
                int bloodGroupId = Integer.parseInt(bloodGroupidStr); 

                int requestedUnits = Integer.parseInt(unitStr);

                
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blood_management", "root", "Subham102@");

                
                String checkStockSql = "SELECT Units FROM blood_stock WHERE BloodgroupId=?";
                PreparedStatement checkStockStmt = con.prepareStatement(checkStockSql);
                checkStockStmt.setInt(1, bloodGroupId);
                ResultSet rs = checkStockStmt.executeQuery();

                if (rs.next()) {
                    int availableUnits = rs.getInt("Units");

                    
                    if (availableUnits >= requestedUnits) {
                        
                        String updateRequestSql = "UPDATE blood_request SET Status='Approved' WHERE RequestId=?";
                        PreparedStatement updateRequestStmt = con.prepareStatement(updateRequestSql);
                        updateRequestStmt.setString(1, requestId);
                        updateRequestStmt.executeUpdate();
                        updateRequestStmt.close();

                        
                        String updateStockSql = "UPDATE blood_stock SET Units=Units-? WHERE BloodgroupId=?";
                        PreparedStatement updateStockStmt = con.prepareStatement(updateStockSql);
                        updateStockStmt.setInt(1, requestedUnits);
                        updateStockStmt.setInt(2, bloodGroupId); 
                        updateStockStmt.executeUpdate();
                        updateStockStmt.close();

                        response.sendRedirect("admin_blood_request.jsp?msg=approved");
                    } else {
                    	response.sendRedirect("admin_blood_request.jsp?msg=error");
                        
                    }
                } else {
                    out.println("<p>Error: Blood group with ID '" + bloodGroupId + "' not found.</p>");
                }

                rs.close();
                checkStockStmt.close();
                con.close();
            } catch (NumberFormatException e) {
                out.println("<p>Error: Invalid unit format.</p>");
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("<p>Error: " + ex.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Error: Missing request parameters. RequestId: " + requestId + ", BloodgroupId: " + bloodGroupidStr + ", Unit: " + unitStr + "</p>");
        }
    %>
</body>
</html>
