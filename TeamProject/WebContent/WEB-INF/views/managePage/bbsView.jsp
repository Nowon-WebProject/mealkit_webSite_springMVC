<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="kr.co.EZHOME.dto.BbsDTO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<script type="text/javascript" src="js/sunwoo.js?test=12"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var admin = <%=(Integer)session.getAttribute("admin")%>
			if(admin != 1){
			alert("접근 권한이 없습니다.");
			location.href="index";
			}
		});
</script>
<style>
.table-btn {
	background-color : #f9b868 !important;
}

</style>
</head>
<body>
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
<section style="width: 60%; margin-left: auto; margin-right: auto;">
<%
	Vector<BbsDTO> vec=(Vector<BbsDTO>)request.getAttribute("vec");
	BbsDTO bdto = new BbsDTO();
	bdto=vec.get(0);
	String file = (String) request.getAttribute("file");
%>
	<div align="center">
			<br>
			<br>
			<h2>공지사항</h2>
			<button class="back-btn" onclick="history.back()" style="float:right">이전</button>
			<br>
			<hr>
    </div>
  		<p style="align:left; margin-left: 20px;" style="float:left"> 조회수 : <%=bdto.getBbscount() %></p>
	<form action="bbsView.do" method="post">
	<table class="ezen">
    <thead>
        <tr>
            <th>관리자페이지 - 공지사항 수정삭제</th>
        </tr>
    </thead> 
    <tbody>	
			<tr>
			<td><%=bdto.getBbstitle() %></td>
			</tr>
			<tr>
			<td style="vertical-align:top"height="400px">
			<%if(file != ""){%>
			<img src="images/board/${file }" style="heigth:auto;"></img><br>
			<%} %>
			<%=bdto.getBbscontent() %>
			</td>
			</tr>
    </tbody>
    </table>
    <br>
    <div align="right">
    <div style="width:100px">
    <input type="hidden" name="bbsid" value=<%=bdto.getBbsid() %>>
    <button type="submit" value="수정" name="update" class="table-btn">수정</button>
    <button type="submit" formaction="bbsDelete.do" name="delete"  class="table-btn-a"  value=<%=bdto.getBbsid() %>>삭제</button>
    </div>
    </div>
    </form>
    <br>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>