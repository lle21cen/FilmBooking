<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:useBean id="update" class="data.JoinBean" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="update"/>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if (!request.getParameter("passwd").equals(request.getParameter("passwd_2"))) {
	out.print("<SCRIPT LANGUAGE='JavaScript'>alert('비밀번호가 일치하지 않습니다.')</SCRIPT>");
	out.print("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");			
}
else if(request.getParameter("name_mem").equals("")) {
	out.print("<SCRIPT LANGUAGE='JavaScript'>alert('ID는 필수입력 사항입니다.')</SCRIPT>");
	out.print("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");			
}
else if(request.getParameter("passwd").equals("")) {
	out.print("<SCRIPT LANGUAGE='JavaScript'>alert('비밀번호는 필수입력 사항입니다.')</SCRIPT>");
	out.print("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");			
}
else if(request.getParameter("age_mem").equals("")) {
	out.print("<SCRIPT LANGUAGE='JavaScript'>alert('나이는 필수입력 사항입니다.')</SCRIPT>");
	out.print("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");			
}
else if(update.updateData()){
	out.print("<SCRIPT LANGUAGE='JavaScript'>alert('회원정보 변경 성공')</SCRIPT>");
	session.setAttribute("memberInfo", update);
	response.sendRedirect("reserve.jsp");
}
%>
</body>
</html>