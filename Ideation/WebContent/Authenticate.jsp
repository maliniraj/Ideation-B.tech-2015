<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@page import = "java.sql.*" %>
<%@page import = "java.io.*" %>
<%@page import = "java.util.Properties" %>

<%@page import = "Beans.*" %>
<%@page import = "dao.*" %>
<%@page import = "utility.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:8888/ideation","myuser","tina");
Statement stmt=con.createStatement();
String sql="select * from user where user_id='"+request.getParameter("email")+"' and valid=true";
ResultSet rs1=null;
ResultSet rs=stmt.executeQuery(sql);
String user_id=request.getParameter("email");
String pass=request.getParameter("password");
if(!user_id.equals("superadmin"))
pass=Misc.Encrypt(pass);
 response.setContentType("text/html; charset:\"UTF-8\"");
 if(rs.next()){
	 if(rs.getString("password").equals(pass))
	 {
		 
		 userbean user=new userdao().getUserbyId(user_id);
		 System.out.println("use "+user.getUser_name());
		 session.setAttribute("user",user);
		 user_rolebean userrole=new user_roledao().getRolebyUId(user_id);
		 session.setAttribute("roleid", userrole.getRole_id());
		 sql="select * from user where manager_id_1='"+rs.getString("user_id")+"' or manager_id_2='"+rs.getString("user_id")+"'";
		 rs1=stmt.executeQuery(sql);
		 int pos = rs1.next() ? 1 : 0 ;
		 messagedao messaged=new messagedao();
			notificationsdao notificationsd=new notificationsdao();
		 session.setAttribute("pos",pos);
		 String grps=new user_group_assodao().getUserGroupbyUId(user_id);
		 session.setAttribute("groups",grps);
		 session.setAttribute("message",messaged.getMessageCount(user_id));
			session.setAttribute("notification", notificationsd.getNotificationCount(user_id));
		 if(userrole.getRole_id()==3)
		 {
		 out.println("USER");
		 }
		 else
			 {
			 out.println("ADMIN");
			 }
	 }
	 else{
		 out.println("Invalid login or password. Please try again."); 
	 }
 }
else{
	 out.println("Invalid login or password. Please try again.");
 }
%>
</body>
</html>