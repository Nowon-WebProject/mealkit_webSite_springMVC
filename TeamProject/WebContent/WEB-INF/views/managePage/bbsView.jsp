<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="kr.co.EZHOME.dto.BbsDTO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/sunwoo.js?test=12"></script>
<style>
.cart {
	margin-left: auto; margin-right: auto;
	border: 1px solid orange;
	overflow : auto;
}

.cart table {
	
	border: 1px solid orange;
	text-align: center;
	width: 100%;
}
.cart th {
	background-color: orange;
	border: 1px solid orange;

	
}


.cart td {
	border: 1px solid orange;
	
}
.cart tbody tr:nth-child(2n+1){
    background-color: 	#F8AD7B;
}
</style>
</head>
<body>
<%
	Vector<BbsDTO> vec=(Vector<BbsDTO>)request.getAttribute("vec");
	BbsDTO bdto = new BbsDTO();
	bdto=vec.get(0);
%>
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<div align="center">
        <br><br>
        <a href="javascript:method3()"><b><font size="6" color="gray">공지 사항 </font></b></a>
        <br><br><br>
    </div>
    <p style="align:left; margin-left: 20px;"> 조회수 : <%=bdto.getBbscount() %></p>
	<div class="cart">
	<form action="bbsView.do" method="post">
	<table>
    <thead>
        <tr>
            <th colspan="2"></th>
            
        </tr>
    </thead> 
    <tbody>	
			<tr>
			<td><%=bdto.getBbstitle() %></td>
			</tr>
			<tr>
			<td>

			<img src="images/board/${file }" style = "width:20%; heigth:auto;"></img><br>
			<%=bdto.getBbscontent() %>
			</td>
			</tr>
    </tbody>
    </table>
    </div>
    <br>
    <div align="center">
    <input type="hidden" name="bbsid" value=<%=bdto.getBbsid() %>>
    <button type="submit" value="수정" name="update">수정</button>
    <button type="submit" formaction="bbsDelete.do" name="delete" value=<%=bdto.getBbsid() %>>삭제</button>
    </div>
    </form>
	<br>
	<br>
	<br>
	<br>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>

</body>
</html>