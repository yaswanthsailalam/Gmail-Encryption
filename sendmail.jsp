<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="javax.crypto.spec.IvParameterSpec"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.security.Key"%> 

<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>

<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.sql.DriverManager"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String random="";




double l=Math.random();
int[] str={9,9,9,9,9};

int d = 0;
for(int i=0;i<str.length;i++){
	d=(int) (Math.random()*str[i]);
	random+=Integer.toString(d);

}


String key = "Bar12345Bar12345"; // 128 bit key
String initVector = "RandomInitVector"; // 16 bytes IV
String mail=request.getParameter("mail");
String salt="";
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/gmail","root","");
PreparedStatement pst=con.prepareStatement("select * from register where gmail=?");
pst.setString(1,mail);
ResultSet rs=pst.executeQuery();
if(rs.next())
{
	salt=rs.getString(7);
}
String sub=request.getParameter("sub");
String msg=request.getParameter("msg");
IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");

Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);

byte[] encrypted = cipher.doFinal(msg.getBytes());
System.out.println("encrypted string: "
        + Base64.encodeBase64String(encrypted));



//System.out.println("dskf"+eValue);
String from = (String) session.getAttribute("gmail");
String pwd = (String) session.getAttribute("pwd");
PreparedStatement pst1=con.prepareStatement("update  register set  danger='"+random+"' where gmail='"+mail+"'");
pst1.executeUpdate();
response.sendRedirect("sendmail?msg="+ Base64.encodeBase64String(encrypted)+"&mail="+mail+"&sub="+sub+"&from="+from+"&pwd="+pwd+"&rand="+random);
%>

</body>
</html>