<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.EZHOME.dto.BbsDTO"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
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
a:link {
  color : black;
  text-decoration:none;
}
a:visited {
  color : black;
}
a:hover {
  color : black;
}
a:active {
  color : black;
}
</style>
<script type="text/javascript" src="js/sunwoo.js"></script>
</head>
<body>
	<%
	   Vector<BbsDTO> vec=(Vector<BbsDTO>)request.getAttribute("vec");
	   int start = (int)request.getAttribute("start");
	   int end = (int)request.getAttribute("end");
	   int all = (int)request.getAttribute("all");
	   String pageNum = (String)request.getAttribute("page");
	   int Page = Integer.parseInt(pageNum);
	   String[] arr=(String[])request.getAttribute("arr");
%>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section style="width: 60%; margin-left: auto; margin-right: auto;">
	<%  int check = (int) request.getAttribute("check");
	   if (check == 0){
%>
			<h2>공지사항 관리</h2>
			<div style="float:right">
				<form action="bbsList.do" method="post" name="frm">
			<select name="size">
				<option value="10" <%=arr[0] %>>10</option>
				<option value="15" <%=arr[1] %>>15</option>
				<option value="20" <%=arr[2] %>>20</option>
			</select> <input type="hidden" value="<%=pageNum%>" name="page"> <input
				type="submit" value="개씩 보기" class="page">
				</form>
				</div>
				<br>
			<hr>
		<table class="ezen">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<vec.size();i++){
    		BbsDTO bdto=vec.get(i);		
    %>
				<tr>
					<td style="text-align:center"><%=bdto.getBbsid() %></td>
					<td width="40%"><a href="javascript:method('<%=bdto.getBbsid()%>')"><%=bdto.getBbstitle() %></a></td>
					<td style="text-align:center"><%=bdto.getUserid() %></td>
					<td style="text-align:center"><%=bdto.getBbsdate() %></td>
					<td style="text-align:center"><%=bdto.getBbscount() %></td>
				</tr>
				<%} %>

			</tbody>
		</table>
	<br>
	<div align="center">
        <h4>
      <%
         if (start > 10) {
      %>
      <a href="javascript:method3('<%=start - 10 %>')" style="color:black;"><i class="bi-chevron-compact-left"></i></a>
      <%
         }
         for (int i = start; i <= end; i++) {
            if(Page == i){
               %>
      <a href="javascript:method3('<%=i %>')" style="color:white;background-color:gray;border-radius:75px;text-decoration-line: none;">　<%=i %>　</a>
      <%
            }else{
               %>
      <a href="javascript:method3('<%=i %>')" style="color:black;text-decoration-line: none;">　<%=i %>　</a>
               
               <%
            }
         }
         if (all > end) {
      %>
      <a href="javascript:method3('<%=start + 10 %>')" style="color:black;"><i class="bi-chevron-compact-right"></i></a>
      <%
         }
      %>
      </h4>
			
			<br> <br> 
		
	</div>
			<%}else{ %>
	<br>
	<br>
	<br>
	<br>
	<br>
		<div align="center">
			<i style="font-size:200px;color:orange" class="bi bi-megaphone-fill"></i>
			<div style="font-size:30px;color:gray">공지사항이 없습니다.</div>
			</div>
			<%} %>
	
	<div align="right">
		<form action="bbsWrite">
		<h2>
			<input type="submit" class="back-btn" value="글쓰기">
		</h2>
		</form>
	</div>

	<br>
	<br>
	<br>
	<br>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>