<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
        <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String name=request.getParameter("name");
String pwd=request.getParameter("pwd");
String mail=request.getParameter("mail");
String day=request.getParameter("day");
String month=request.getParameter("month");
String year=request.getParameter("year");
String proff=request.getParameter("proff");
String phone=request.getParameter("phone");
String dob=day+"/"+month+"/"+year;
UUID idOne = UUID.randomUUID();
String hai=idOne.toString();
String u1=hai.substring(0,7);
String key=u1.toUpperCase();
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/gmail","root","");
PreparedStatement pst=con.prepareStatement("insert into register values(?,?,AES_ENCRYPT('key',?),?,?,?,?)");
pst.setString(1,name);
pst.setString(2,mail);
pst.setString(3,pwd);
pst.setString(4,dob);
pst.setString(5,phone);
pst.setString(6,proff);
pst.setString(7,key);
int i=pst.executeUpdate();
if(i>0)
{
response.sendRedirect("codesending?key="+key+"&mail="+mail+"&pwd="+pwd);
System.out.println("Success");	
	
}
else
{
	System.out.println("not inserted ");
}
%>
</body>
</html>