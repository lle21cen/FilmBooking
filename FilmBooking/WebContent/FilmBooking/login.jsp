<%@page import="javax.websocket.SendResult"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="login" class="data.LoginBean" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="login"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<center>
<%

	if (!login.checkUser()) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('아이디 혹은 비밀번호가 일치하지 않습니다.')</SCRIPT>");
		out.println(login.getName_mem() + " " + login.getSelected_id());
		out.println("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");
	} else {
		session.setAttribute("memberInfo", login.j);
		session.setAttribute("memberName", login.getName_mem());
		response.sendRedirect("reserve.jsp");		 
	}
%>
</center>
</body>
</html>