<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salary</title>
</head>
<body>
<jsp:include page="header.jsp" />

<section style="position: fixed; top: 60px; width: 100%; height: 100%;
		background-color: lightgray;">
<h2 style="text-align: center;"><b>회원 매출 조회</b></h2><br>

<form style="display: flex; align-items: center; justify-content: center; text-align: center">
<table border="1">
	<tr>
		<td>회원번호</td>
		<td>회원성명</td>
		<td>고객등급</td>
		<td>매출</td>
	</tr>
	
	<%
		Connection conn = null;
		Statement stmt = null;
		String grade = "";
		//String custno = "";
		//String custname = "";
		//String price = "";
		
		try {
			conn = Util.getConnection(); //DB 연결
			stmt = conn.createStatement(); //sql 실행하기 위한 변수 생성
			String sql = "SELECT me.custno, me.custname, me.grade, sum(mo.price) price " +	// +로 연결시 뒤에 공백 필수
						"FROM member_tbl_02 me, money_tbl_02 mo " +
						"WHERE me.custno = mo.custno " + 
						"GROUP BY me.custno, me.custname, me.grade " + //함수는 GROUP BY절에 쓸 수 없다.
						"ORDER BY sum(mo.price) desc ";
			ResultSet rs = stmt.executeQuery(sql); //stmt 통해서 sql 실행 결과	
			//custno = rs.getString("me.custno") ;
			//custname = rs.getString("me.custname") ;
			//price = rs.getString("me.price") ;
			while(rs.next()) {
				grade = rs.getString("grade") ;
				switch(grade) {
				case "A" : 
					grade = "VIP";
					break;
				case "B" :
					grade = "일반";
					break;
				case "C" :
					grade = "직원";
					break;
				}	
	%>
				<tr>
					<td><%= rs.getString("custno") %></td>
					<td><%= rs.getString("custname") %></td>
					<td><%= grade %></td>
					<td><%= rs.getString("price") %></td>
				</tr>
	<%
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	%>	
</table>
</form>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>