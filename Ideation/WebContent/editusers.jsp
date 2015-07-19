<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@page import="Beans.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="refreshmessage.js"></script>
<title>Edit Users</title>
<style>
.col-centered{
    margin: 0 auto;
    float: none;
}
.centered{
text-align:center;
}
.menu{
background-color:#f0f0f0;
}
.menu a{
margin-right:0px;
}
.menu a:link,
.menu a:visited
{
	color:black;
	text-decoration:none;
}
	
.menu a:hover,
.menu a:active{
color:black;
	text-decoration:none;
background-color:#c0c0c0;
}

</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
history.pushState(null,null,"editusers.jsp");
window.addEventListener('popstate',function(event){
	history.pushState(null,null,"editusers.jsp");
});
$(document).ready(function(){
   var url="userdisplaycontroller";
        $.post(url, function(data){
        	document.getElementById("users").innerHTML=data;
        	var heights = $(".equaliseheight").map(function() {
                return $(this).height();
            }).get(),

            maxHeight = Math.max.apply(null, heights);

            $(".equaliseheight").height(maxHeight);
        });
   
    $("#uid").keyup(function(){
    	var form=document.getElementById("edit");
   		var v=form.uid.value;
   var url="userdisplaycontroller?val="+v; 
        $.get(url, function(data){
        	document.getElementById("users").innerHTML=data;
        	var heights = $(".equaliseheight").map(function() {
                return $(this).height();
            }).get(),

            maxHeight = Math.max.apply(null, heights);

            $(".equaliseheight").height(maxHeight);
        });
    });
});

function servletreq(s)
{
	var v=s.innerHTML;
	document.location="edituserscontroller?val="+v;
}
function changestyle1(s)
{
	s.setAttribute("style","color:black;background-color:#c0c0c0;");
}
function changestyle2(s)
{
	s.setAttribute("style","color:blue;background-color:#ffffff;");
}
</script>
</head>
<body>
<%
userbean user=(userbean)session.getAttribute("user");
if(user==null)
{
	response.sendRedirect("Login.jsp");
}
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>
<div class="container-fluid">
<div class="row" style="background-color:#663399;height:50pt;padding-top:15px">
 <div class="col-sm-3 col-md-3 col-lg-5" style="color:#ffffff;font-size:30pt;font-weight:bold;text-indent:10pt;"><p>CSC</p></div>
 <div class="col-sm-3 col-md-3 col-lg-2 "  id="welcome" style="color:#ffffff;font-size:14pt;padding:10px;margin:5pt"><p>Welcome ${sessionScope.user.user_name }</p></div>
 <div class="col-sm-2 col-md-2 col-lg-1 " align="right" id="message"><a href="adminmessage.jsp" style=" text-decoration:none"><button type="button" class="btn btn-info"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> Messages <span id="msg" class="badge"></span></button></a></div>
 <div class="col-sm-2 col-md-2 col-lg-2 " align="right" id="notification"><a href="adminnotification.jsp" style=" text-decoration:none"><button type="button" class="btn btn-info"><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
  Notification <span id="noti" class="badge"></span></button></a>
  </div>
 <div class="col-sm-1 col-md-1 col-lg-1 " align="right" ><button type="button" id="logout" onclick="logout()" class="btn btn-info"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span> Logout</button></div>
</div>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="adminhome.jsp">Home</a></li>
        <li class="active"><a href="adduser.jsp">Manage Users</a></li>
        <li><a href="viewgroups.jsp">Manage Groups</a></li>
        <li><a href="forums/list.page">Manage Forum</a></li>
        <c:if test="${sessionScope.roleid eq 1 }">
        <li><a href='viewadmins.jsp'>Manage Admins</a></li>
        </c:if>
        </ul>
    </div>
  </div>
</nav>
<div class='row'><div class='col-lg-2 col-md-2 col-sm-3 menu equaliseheight'>
<a href="adminhome.jsp" class='col-lg-12 col-md-12 col-sm-12'>Add Single User</a><br>
<a href="addusers.jsp" class='col-lg-12 col-md-12 col-sm-12'>Add Multiple Users</a><br>
<a href="editusers.jsp" class='col-lg-12 col-md-12 col-sm-12' style="background-color:#dfdfdf">Edit Users</a><br>
<a href="removeusers.jsp" class='col-lg-12 col-md-12 col-sm-12'>Remove Users</a><br>
</div>
<div class="col-lg-10 col-md-10 col-sm-9 equaliseheight">
<form role="form" id="edit">
<h3>Select User Id to Edit</h3>
    <div class="col-lg-3 col-md-3 col-sm-4 col-xs-5">
      <label for="uid">User Id:</label>
      <input type="text" class="form-control" id="uid" name="uid" placeholder="Search for user id to edit">
      <span id="users" style="color:blue"></span><br>
    </div><br>
    </form>
</div>
</body>
</html>