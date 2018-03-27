<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, data.JoinBean, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 예매 화면</title>
</head>
<body>

<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
JoinBean member = (JoinBean)session.getAttribute("memberInfo");
int id = Integer.parseInt((String)session.getAttribute("id_film"));
int[] seats = new int[9];
int seat_num=0, cnt=0;
SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd");
String today = f.format(new Date());

String jdbc_driver="com.mysql.jdbc.Driver";
String jdbc_url="jdbc:mysql://localhost/film_booking";
try {
	Class.forName(jdbc_driver);
	conn = DriverManager.getConnection(jdbc_url, "root", "1234");
	
	 String sql = "select age_phase from movies where id_film=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, id);
	rs = pstmt.executeQuery();
	if (!rs.next()) {
		conn.close();
		pstmt.close();
		rs.close();
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('해당 영화는 이미 상영이 종료되었습니다.')</SCRIPT>");
		out.println("<SCRIPT LANGUAGE='JavaScript'>location.href='index.jsp'</SCRIPT>");
	}
	JoinBean j = (JoinBean)session.getAttribute("memberInfo");
	if (rs.getInt("age_phase") > j.getAge_mem()) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('관람가 미만')</SCRIPT>");
		out.println("<SCRIPT LANGUAGE='JavaScript'>location.href='index.jsp'</SCRIPT>");
	}
	sql = null;
	/* ---------------------------------------------------------------------------- */
	sql = "select * from seats where id_film=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, id);
	rs = pstmt.executeQuery();
	rs.next();
	for(int i=0; i<9; i++) {
		seats[i] = rs.getInt(i+3);
	}
	for(int i=0; i<9; i++) {
		if(seats[i]==1) break;
		else if(i==8) {
			conn.close();
			pstmt.close();
			rs.close();
			out.println("<SCRIPT LANGUAGE='JavaScript'>alert('예매 가능한 좌석이 없습니다.')</SCRIPT>");
			out.println("<SCRIPT LANGUAGE='JavaScript'>location.href='index.jsp'</SCRIPT>");
		}
	}
	/* ---------------------------------------------------------------------------- */

}catch (SQLException e) {
	e.printStackTrace();
}

%>
<div align="right">사용자 : <%=session.getAttribute("memberName") %><br><a href="change_member.jsp">회원정보변경</a></div>

<br><br><br>
<center>
<form action="payment.jsp" method="post" name="form1">
<table style="width: 99%;" border="0">
<tr align="center">
<td style="font-size: 130%; width: 33%; color: #5882FA">
좌석 번호
</td>
<td style="font-size: 130%; width: 33%; color: #5882FA">
좌석 현황
</td>
<td style="font-size: 130%; width: 33%; color: #5882FA">
예매
</td>
</tr>
<tr>
<td colspan="3"><hr></td>
</tr>
<%
for(seat_num=0; seat_num<9;seat_num++, cnt++) {
	if(seats[seat_num]==0) continue;
%>
<tr align="center">

<td style="background-color: #EFF2FB">
<%=seat_num+1 %>

</td>
<td style="font-size: 80%">
예매 가능
</td>
<td style="background-color: #EFF2FB;"  height="40">
<input name="<%=cnt %>" type="submit" value="영화 예매" style="background-color: #0B2161; color: white; width: 40%; height: 80%">
</td>

</tr>
<%
}
%>

</table>
</form>
</center>
<%	
	conn.close();
	pstmt.close();
	rs.close();
%>
</body>
</html>