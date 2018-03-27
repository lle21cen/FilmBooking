<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결제 화면</title>
</head>
<body>
	<%
		SimpleDateFormat date_format = new SimpleDateFormat("yyyy");
		int cur_year = Integer.parseInt(date_format.format(new Date()));
		int i;

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String mode = "pay";

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost/film_booking";

		int max_id_resv = Integer.parseInt(request.getParameter("max_resv_id"));
		int del_id_resv = 0;

		int sel_id_resv = 0;

		for (i = 80; i <= max_id_resv; i++) {
			if (request.getParameter("del" + i) != null) {
				del_id_resv = i;
				mode = "del";
				break;
			}
		}

		try {
			if (mode.equals("del")) {
				Class.forName(jdbc_driver);
				conn = DriverManager.getConnection(jdbc_url, "root", "1234");

				sql = "select id_film, seat_no from reserves where id_resv=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, del_id_resv);
				ResultSet rs = pstmt.executeQuery();
				rs.next();
				int seat_no = rs.getInt("seat_no");
				
				sql = "update seats set s?=1 where id_film=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, seat_no);
				pstmt.setInt(2, rs.getInt("id_film"));
				pstmt.executeUpdate();
				
				sql = "delete from reserves where id_resv=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, del_id_resv);
				pstmt.executeUpdate();
				
				conn.close();
				pstmt.close();
				response.sendRedirect("payment.jsp?mode=del");
				/* 	---------------------------------삭제 모드------------------------------------------- */
			}
			for (i = 80; i <= max_id_resv; i++) {
				if (request.getParameter("pay" + i) != null) {
					sel_id_resv = i;
					break;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
	<center>
		<br>
		<br>
		<h2 style="font-size: 200%;">카드결제</h2>

		<form action="payment.jsp" method="post" name="form1">
			<table style="width: 100%;" border="0">
				<tr align="center" style="font-size: 120%" height="50">
					<td bgcolor="#EFF2FB" style="width: 20%; color: #5882FA">카드 번호
					</td>
					<td><input type="text" name="card_num" value=""
						style="width: 60%; background-color: #F2F2F2"></td>
				</tr>
				<tr align="center" style="font-size: 120%" height="50">
					<td bgcolor="#EFF2FB" style="width: 20%; color: #5882FA">유효 기간
					</td>
					<td><select name="month" style="background-color: #F2F2F2">
							<option selected="selected">month</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>

					</select> <select name="year" style="background-color: #F2F2F2">
							<option selected="selected">year</option>
							<%
								for (i = cur_year; i <= cur_year + 20; i++) {
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr align="center" style="font-size: 120%" height="50">
					<td bgcolor="#EFF2FB" style="width: 20%; color: #5882FA">cvc</td>
					<td><input type="password" name="cvc" value="" maxlength="3"
						style="background-color: #F2F2F2"></td>
				</tr>

				<tr align="center">
					<td><input type="hidden" name="change_resv"
						value="<%=sel_id_resv%>"></td>
					<td height="50"><input type="submit" name="payment" value="결제"
						style="background-color: #0B2161; color: white; width: 20%; height: 100%; font-size: 145%">
						&nbsp; &nbsp; <input type="button" name="cancel" value="취소"
						style="background-color: #0B2161; color: white; width: 20%; height: 100%; font-size: 145%"
						onclick="javascript:history.back()">
				</tr>

			</table>
		</form>

	</center>
</body>
</html>