<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movie List</title>
</head>
<body>

	<%
	if (request.getParameter("id") != null && request.getParameter("passwd") != null) {
 	if (request.getParameter("id").equals("admin") && request.getParameter("passwd").equals("admin")) {
			out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Welcome, Administrator.')</SCRIPT>");
		} else {
			if (request.getParameter("id").equals("")) {
				out.print("<SCRIPT LANGUAGE='JavaScript'>alert('ID는 필수입력 사항입니다.')</SCRIPT>");
				out.print("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");
			} else if (request.getParameter("passwd").equals("")) {
				out.print("<SCRIPT LANGUAGE='JavaScript'>alert('비밀번호는 필수입력 사항입니다.')</SCRIPT>");
				out.print("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");
			} else {
				out.print("<SCRIPT LANGUAGE='JavaScript'>alert('ID혹은 비밀번호가 올바르지 않습니다.')</SCRIPT>");
				out.print("<SCRIPT LANGUAGE='JavaScript'>history.go(-1)</SCRIPT>");
			}
		}
	}
 		int index = 0;
 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost/film_booking";
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "root", "1234");

			String sql = "select * from movies";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	%>
	<a href="admin_insert_movie_form.html">Insert film</a> &nbsp;
	<a href="admin_member_list.jsp">Member management</a>
	<div align="right"><a href="index.jsp">Movie List</a> </div>
	
	<center>
	<strong style="font-size: 150%">영화 목록 화면</strong> 
	<br>
	<br>	
		<form action="admin_remove_movie.jsp" method="post" name="form1">
			<table style="width: 100%%;" border="0">
				<tr align="center" style="font-size: 120%">
					<td style="width: 20%; color: #5882FA">Title</td>
					<td style="width: 20%; color: #5882FA">Age</td>
					<td style="width: 20%; color: #5882FA">Total seat</td>
					<td style="width: 20%; color: #5882FA">Date</td>
					<td style="width: 20%; color: #5882FA">Operation</td>
				</tr>
				<tr>
					<td colspan="6">
						<hr>
					</td>
				</tr>
	
	<%
		while (rs.next()) {
	%>
	<tr align="center">
	<td>
	<%=rs.getString("name_film") %>
	<input type="hidden" name="names" value="<%=rs.getString("name_film")%>">
	</td>
	<td>
	<%=rs.getInt("age_phase") %>
	</td>
	<td>
	<%=rs.getInt("seat_num") %>
	</td>
	<td>
	<%=rs.getString("date_film") %>
	</td>
	<td>
	<input type="submit" name="<%=index%>" value="Remove">
	</td>
	</tr>
	<%	
	index++;
		}
			conn.close();
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
	<tr>
	<td>
	<input type="hidden" name="index" value="<%=index%>">
	</td>
	</tr>
	</table>
	</form>
	</center>
</body>
</html>