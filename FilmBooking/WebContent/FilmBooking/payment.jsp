<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*, data.JoinBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약 목록 화면</title>
</head>
<body>
	<%
		String sql = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		JoinBean member = (JoinBean) session.getAttribute("memberInfo");
		int id = Integer.parseInt((String) session.getAttribute("id_film"));
		int cnt = 0;
		SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd");
		String today = f.format(new Date());
		String mode = "not insert";

		int i, seatNum = 0;
		for (i = 0; i < 9; i++) {
			if (request.getParameter("" + i) != null) {
				seatNum = i + 1;
				mode = "insert";
			}
		}

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost/film_booking";

		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "root", "1234");
			/* ---------------------------------------------------------------------------- */

			String change_resv = request.getParameter("change_resv");
			if (request.getParameter("payment") != null) {
				sql = "update reserves set status='ok' where id_resv=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(request.getParameter("change_resv")));
				pstmt.executeUpdate();
			}

			/* ---------------------------------------------------------------------------- */

			if (seatNum > 0) {
				sql = "update seats set s?=0 where id_film=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, seatNum);
				pstmt.setInt(2, id);
				pstmt.executeUpdate();
			}
			/* ---------------------------------------------------------------------------- */
			
			sql = "select id_resv from reserves";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int valid_id_resv = 80;
			while (rs.next()) {
				if (valid_id_resv < rs.getInt("id_resv") + 1)
					valid_id_resv = rs.getInt("id_resv") + 1;
			}

			if (mode.equals("insert")) {
				sql = "select id_film, name_film, date_film from movies where id_film=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery();
				rs.next();

				sql = "insert into reserves values(?, ?, ?, ?, ? ,? ,? ,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, valid_id_resv);
				pstmt.setInt(2, member.getId_mem());
				pstmt.setString(3, (String) session.getAttribute("id_film"));
				pstmt.setString(4, rs.getString("name_film"));
				pstmt.setString(5, rs.getString("date_film"));
				pstmt.setString(6, today);
				pstmt.setInt(7, seatNum);
				pstmt.setString(8, "-");
				pstmt.executeUpdate();
			}
			mode = "not insert";
			/* ---------------------------------------------------------------------------- */
			sql = null;
			sql = "select * from reserves where id_mem=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member.getId_mem());
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<div align="right">
		<a href="index.jsp">영화목록보기</a>
	</div>
	<br>
	<center>
	<strong style="font-size: 150%">예약 목록 화면</strong> 
	<br>
	<br>	
		<form action="pay_or_del.jsp" method="post" name="form1">
			<table style="width: 96%;" border="0">
				<tr align="center" style="font-size: 120%">
					<td style="width: 16%; color: #5882FA">영화 제목</td>
					<td style="width: 16%; color: #5882FA">상영 기간</td>
					<td style="width: 16%; color: #5882FA">예약일</td>
					<td style="width: 16%; color: #5882FA">좌석 번호</td>
					<td style="width: 16%; color: #5882FA">예약 상황</td>
					<td style="width: 20%; color: #5882FA">결제 및 취소</td>
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

					<td style="background-color: #EFF2FB"><%=rs.getString("film_name")%>
					</td>
					<td><%=rs.getString("date_film")%></td>

					<td style="background-color: #EFF2FB"><%=rs.getString("resv_date")%>
					</td>

					<td><%=rs.getInt("seat_no")%></td>

					<td style="background-color: #EFF2FB"><%=rs.getString("status")%>
					</td>

					<td style="background-color: #EFF2FB;" height="50">
						<%
							if (!rs.getString("status").equals("ok")) {
						%> <input name="pay<%=rs.getInt("id_resv")%>" type="submit"
						value="결제"
						style="background-color: #0B2161; color: white; width: 40%; height: 80%">
						<%
							} else {
						%> <input type="submit" value="결제완료" disabled="disabled"
						style="background-color: #A4A4A4; color: white; width: 40%; height: 80%">
						<%
							}
						%> <input name="del<%=rs.getInt("id_resv")%>" type="submit"
						value="삭제"
						style="background-color: #0B2161; color: white; width: 40%; height: 80%">
					</td>

				</tr>
				<%
					cnt = rs.getInt("id_resv");
					}
					conn.close();
					pstmt.close();
					rs.close();
				%>
				<tr>
					<td><input type="hidden" name="max_resv_id" value="<%=cnt%>">
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>