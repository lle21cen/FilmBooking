<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

<jsp:useBean id="film" class="data.MovieBean" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="film"/>

</head>
<body>
	<%	
		try {
			if(film.insertData())
				response.sendRedirect("admin_movie_list.jsp");
		} catch(Exception e) {
			out.println(e.getMessage());
		}
	%>
</body>
</html>