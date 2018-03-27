<%@page import="java.sql.ResultSet"%>
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
<title>Remove_movie</title>
</head>
<body>
	<%
		int index = Integer.parseInt(request.getParameter("index"));
		int id_film = 0;

		for (int i = 0; i < 10; i++) {
			if (request.getParameter("" + i) != null) {
				index = i;
				break;
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

			sql = "select id_film from movies where name_film=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, names[index]);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			id_film = rs.getInt("id_film");

			sql = "delete from movies where name_film=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, names[index]);
			pstmt.executeUpdate();
			/* ------------------------Delete Movies Table Data-----------------------------*/

			sql = "delete from seats where id_film=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id_film);
			pstmt.executeUpdate();
			/* ------------------------Delete Seats Table Data-----------------------------*/

			conn.close();
			pstmt.close();
			response.sendRedirect("admin_movie_list.jsp");
		} catch (SQLException e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
	%>
</body>
</html>