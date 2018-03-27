<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 / 회원가입</title>
</head>
<body>
<%
	int index=0;
	int MovieCnt = Integer.parseInt((String)session.getAttribute("MovieCnt"));
	String[] ids = (String[])session.getAttribute("ids");

	for(index=0; index<MovieCnt; index++) {
		if(request.getParameter(""+index)!=null) {
			session.setAttribute("id_film", ids[index]);
		}
	}
	
	if (session.getAttribute("memberName") != null) {
		response.sendRedirect("reserve.jsp");
	}
%>
	<br>
	<br>
	<div style="width: 50%; float: left">
	<form action="login.jsp" method="post" id="form1">
	<table border="0" width="100%">
	<tr align="center">
	<td style="font-size: 150%" colspan="2">
	로그인
	</td>
	</tr>
	<tr>
	<td colspan="2">
	<br>
	</td>
	</tr>
	<tr align="center">
	<td bgcolor="#EFF2FB" style="width: 30%">
	ID
	</td>
	<td>
	<input type="text" name="name_mem" style="width: 95%;">
	</td>
	</tr>
	<tr align="center">
	<td bgcolor="#EFF2FB" style="width: 30%">
	비밀번호
	</td>
	<td>
	<input type="password" name="passwd" style="width: 95%">
	</td>
	</tr>
	<tr align="center">
	<td>
	</td>
	<td height="50">
	<input type="submit" name="Submit" value="로그인" style="background-color: #0B2161; color: white; width: 40%; height: 100%">
	&nbsp; &nbsp;
	<input type="reset" name="Reset" value="초기화" style="background-color: #0B2161; color: white; width: 40%; height: 100%">
	</tr>
	</table>
	</form>
			<!-- ------------------------------------------------------------------------ -->
	</div>
	<div style="width: 50%; float: right">
	<form action="join.jsp" method="post" id="form2">
	<table border="0" width="100%">
<tr align="center">
	<td style="font-size: 150%" colspan="2">
	회원 가입
	</td>
	</tr>
	<tr>
	<td colspan="2">
	<br>
	</td>
	</tr>
	<tr align="center">
	<td bgcolor="#EFF2FB" style="width: 30%">
	ID
	</td>
	<td>
	<input type="text" name="name_mem" style="width: 95%;" maxlength="20">
	</td>
	</tr>
	<tr align="center">
	<td bgcolor="#EFF2FB" style="width: 30%">
	비밀번호
	</td>
	<td>
	<input type="password" name="passwd" style="width: 95%" maxlength="20">
	</td>
	</tr>
	<tr align="center">
	<td bgcolor="#EFF2FB" style="width: 30%">
	비밀번호 확인	
	</td>
	<td>
	<input type="password" name="passwd_2" style="width: 95%" maxlength="20">
	</td>
	</tr>
	<tr align="center">
	<td bgcolor="#EFF2FB" style="width: 30%">
	나이	
	</td>
	<td>
	<input type="text" name="age_mem" style="width: 95%;" maxlength="3">
	</td>
	</tr>
	<tr>
	<td>
	<% SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");%>
	<input type="hidden" name="register_date" value="<%=format.format(new Date()).toString() %>">
	</td>
	</tr>
	<tr align="center">
	<td>
	</td>
	<td height="50">
	<input type="submit" name="Submit" value="승인" style="background-color: #0B2161; color: white; width: 40%; height: 100%">
	&nbsp; &nbsp;
	<input type="reset" name="Reset" value="초기화" style="background-color: #0B2161; color: white; width: 40%; height: 100%">
	</tr>
	</table>
	</form>
	</div>
</body>
</html>