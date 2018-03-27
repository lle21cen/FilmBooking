<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Member Management</title>
</head>
<body>
	<%
		int index = 0;
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost/film_booking";
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "root", "1234");

			String sql = "select * from members";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	%>

	<a href="admin_movie_list.jsp">Back</a>
	<center>
		<strong>Member management</strong> <br> <br>
		<form action="admin_remove_member.jsp" method="post" name="form1">
			<table style="width: 100%;" border="0">
				<tr align="center" style="font-size: 120%">
					<td style="width: 25%; color: #5882FA">ID</td>
					<td style="width: 25%; color: #5882FA">Age</td>
					<td style="width: 25%; color: #5882FA">Registration date</td>
					<td style="width: 25%; color: #5882FA">Operation</td>
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
					<td><%=rs.getString("name_mem")%>
					<input type="hidden" name="names" value="<%=rs.getString("name_mem")%>"></td>
					<td><%=rs.getInt("age_mem")%></td>
					<td><%=rs.getString("register_date")%></td>
					<td><input type="submit" name="<%=index%>" value="Remove">
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
					<td><input type="hidden" name="index" value="<%=index%>">
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>