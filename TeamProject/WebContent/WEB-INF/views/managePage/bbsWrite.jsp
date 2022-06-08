<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.cart {
	margin-left: auto; margin-right: auto;
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
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
<section>
	<div align="center">
        <br><br>
        <b><font size="6" color="gray">공지 사항 </font></b>
        <br><br><br>
    </div>
	<div class="cart" align="center">
	<table>
    <thead>
        <tr>
            <th colspan="2">글쓰기</th>
            
        </tr>
    </thead> 
    <form action="bbsWrite.do" method="post" encType="multipart/form-data">
    <tbody>	
			<tr>
			<td><input type="text" name="bbstitle" placeholder="제목" maxlength="50" style="width:50%;"></td>
			</tr>
			<tr>
			<td><textarea type="text" name="bbscontent" placeholder="글내용" maxlength="2048" style="width:100%; height:350px;"></textarea></td>
			</tr>
    </tbody>
    </table>
    <br>
    	<input type="file" name="mediaFile">
    </div>
    <br>
    <div align="center">
	<input type="submit" value="등록">
	</form>
	</div>
	<br>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>