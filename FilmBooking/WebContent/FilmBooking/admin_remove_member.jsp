<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	int index = Integer.parseInt(request.getParameter("index"));
	for (int i=0; i<index; i++) {
		if(request.getParameter(""+i) != null) {
			index = i;
		}
	}
	
	String[] names = request.getParameterValues("names");

	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = null;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/film_booking";

	try {
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, "root", "1234");

		sql = "delete from members where name_mem=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, names[index]);
		pstmt.executeUpdate();

		conn.close();
		pstmt.close();
		response.sendRedirect("admin_member_list.jsp");
	} catch (SQLException e) {
		out.println(e.getMessage());
		e.printStackTrace();
	}

	%>
</body>
</html>