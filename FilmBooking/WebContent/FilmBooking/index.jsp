<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상영 영화 리스트</title>
</head>
<body>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt=0;
		String[] ids = new String[100];

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost/film_booking";
		String folder_src = "file:///Users/hsl/eclipse-workspace/FilmBooking/WebContent/img/";
		
		out.println("<a href='admin_login_form.html'>admin</a>");
		if (session.getAttribute("memberName") != null) {
			out.print("<div align='right'>사용자 : " + (String)session.getAttribute("memberName"));
	%>
	<br><a href="logout.jsp">logout</a>
	<%out.print("</div>");} %>
	<center>
		<br><br> <strong style="font-size: 150%">상영 영화 리스트</strong> <br> <br>
		<form action="login_join.jsp" name="listTologin" method="post">
			<table border="0" style="width: 100%" align="center">
				<tr style="color: #5882FA">
					<th style="width: 16%">타이틀</th>
					<th style="width: 16%">이미지</th>
					<th style="width: 16%">관람가</th>
					<th style="width: 16%">총 좌석 수</th>
					<th style="width: 16%">상영기간</th>
					<th style="width: 16%">예매</th>
				</tr>
				<%
					try {
						Class.forName(jdbc_driver);
						conn = DriverManager.getConnection(jdbc_url, "root", "1234");
						String sql = "select * from movies;";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							String img_src = folder_src + rs.getString("name_film") + ".jpg";
							String id = "" + rs.getInt("id_film");
							ids[cnt] = id;
				%>

				<tr>
					<td colspan="6">
						<hr>
					</td>
				</tr>
				<tr align="center" style="font-size: 70%">
					<td bgcolor="#EFF2FB"><%=rs.getString("name_film")%></td>
					<td><img alt="영화 포스터" src=<%=img_src%> width="100" height="120"></td>
					<td bgcolor="#EFF2FB"><%=rs.getInt("age_phase")%>세 이용가</td>
					<td><%=rs.getString("seat_num")%></td>
					<td bgcolor="#EFF2FB"><%=rs.getString("date_film")%>
					<td style="height: 20%">
					<input name="<%=cnt %>" type="submit"
						style="background-color: #0B2161; width: 70%; color: white; font-size: 120%"
						value="선택" ></td>
				</tr>
				<%
				cnt++;
					}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				%>
			
			</table>
		</form>
	</center>
	<%
		session.setAttribute("MovieCnt", ""+cnt);
		session.setAttribute("ids", ids);
		conn.close();
		pstmt.close();
		rs.close();
	%>
</body>
</html>