<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="kr.co.EZHOME.dto.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.EZHOME.dao.ItemDAO"%>
<%@page import="kr.co.EZHOME.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>이젠, 집에서 | 메인화면</title>
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
input[type='number']{
    width: 42px;
} 


table {
	border: 1px solid orange;
	text-align: center;
	width: 100%;
}

th {
	background-color: orange;
	border: 1px solid orange;
}

td {
	border: 1px solid orange;
}


</style>
<script type="text/javascript">

function loginCheck() {
	var userid = "${userid}";
	if (userid == "") {
		alert("로그인 후 이용 가능합니다.");
	} else {
		alert("장바구니에 담았습니다.");
	}
}

function count(type,item_quantity,item_num){
	 var inputValue = parseInt(document.getElementById(item_num).value,10);
	 
	 if(type=="minus"){
		 if(inputValue != 1){
	 		var result = inputValue -1;
			 $('input[id='+item_num+']').attr('value',result);
		 }										
	 }else{
		 if(inputValue < item_quantity){
	 		var result = inputValue +1;
			 $('input[id='+item_num+']').attr('value',result);
		 }
	 }
}

</script>        
        
</head>
<body>
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<%
		
		
		String check = request.getParameter("check");
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		String priceSort = request.getParameter("priceSort");
		String view = request.getParameter("view");
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int count = Integer.parseInt(request.getAttribute("count").toString());
		int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());
		int pageCount = Integer.parseInt(request.getAttribute("pageCount").toString());
		int endPage = Integer.parseInt(request.getAttribute("endPage").toString());
		int startPage = Integer.parseInt(request.getAttribute("startPage").toString());
		
		

	%>
				

        <!-- Section-->
        <section>
            <div class="container px-4 px-lg-5 mt-5">
      			  <c:choose>
                    <c:when test="${check eq 'all'}">
                    <h1>전체 밀키트</h1>
                    </c:when>
                    <c:when test="${check eq 'best'}">
                    <h1>인기 밀키트</h1>
                    </c:when>
                    <c:otherwise>
                    <h1>신상 밀키트</h1>
                    </c:otherwise>
                </c:choose>
      			  <%if(!category.equals("")||!priceSort.equals("default")||!keyword.equals("")){ 
      				  if(category.equals("")){
      					  category = "모든";
      				  }
      				  if(keyword.equals("")){
      					  keyword = "전체";
      				  }
      			  %>
      			  <h4>'<%=category%>' 카테고리의 '<%=keyword%>' 검색 결과입니다. 가격정렬<%=priceSort%></h4>
      			  <%
   				  category = request.getParameter("category");
   				  keyword = request.getParameter("keyword");
      				  } %>
      			  <hr>
			<div align="right">
			<a href="itemList.do?view=${view}&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=high&keyword=<%=keyword%>" style="color:white;background-color:#FF8868;border-radius:5px;text-decoration-line: none;">&nbsp;가격 높은 순<i class="bi-arrow-bar-up"></i>&nbsp;</a>
			<a href="itemList.do?view=${view}&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=low&keyword=<%=keyword%>" style="color:white;background-color:#FF8868;border-radius:5px;text-decoration-line: none;">&nbsp;가격 낮은순<i class="bi-arrow-bar-down"></i>&nbsp;</a>
			<a href="itemList.do?view=${view}&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=default&keyword=<%=keyword%>" style="color:white;background-color:#FF8868;border-radius:5px;text-decoration-line: none;">&nbsp;가격 정렬 기본&nbsp;</a>
<br>
					<c:choose>
			<c:when test="${view eq 'card'}">	
			<a href="itemList.do?view=list&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=<%=priceSort%>&keyword=<%=keyword%>" style="color:white;background-color:skyblue;border-radius:5px;text-decoration-line: none;">&nbsp;리스트형 보기&nbsp;</a>
      			  </c:when>
      			  <c:otherwise>
			<a href="itemList.do?view=card&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=<%=priceSort%>&keyword=<%=keyword%>" style="color:white;background-color:skyblue;border-radius:5px;text-decoration-line: none;">&nbsp;카드형 보기&nbsp;</a>
      			  </c:otherwise>
      			  </c:choose>
      			  <br>
      			  <c:set var="pageSize" value="${pageSize}"></c:set>
				<c:choose>
					<c:when test="${pageSize == 8}">
						<form action="itemList.do">
							<select name="pageSize">
								<option value="8" selected>8</option>
								<option value="12">12</option>
								<option value="16">16</option>
								<option value="20">20</option>
							</select>
							<input type="hidden" name="view" value="${view}">
							<input type="hidden" name="priceSort" value="<%=priceSort%>">
							<input type="hidden" name="category" value="<%=category%>">
							<input type="hidden" name="check" value="${check}">
							<input type="hidden" name="keyword" value="<%=keyword%>">
							<button type="submit" class="pageSize" >개씩 보기</button>
						</form>
					</c:when>
					<c:when test="${pageSize == 12}">
						<form action="itemList.do">
							<select name="pageSize">
								<option value="8">8</option>
								<option value="12" selected>12</option>
								<option value="16">16</option>
								<option value="20">20</option>
							</select>
							<input type="hidden" name="view" value="${view}">
							<input type="hidden" name="priceSort" value="<%=priceSort%>">
							<input type="hidden" name="category" value="<%=category%>">
							<input type="hidden" name="check" value="${check}">
							<input type="hidden" name="keyword" value="<%=keyword%>">
							<button type="submit" class="pageSize" >개씩 보기</button>
						</form>
					</c:when>
					<c:when test="${pageSize == 16}">
						<form action="itemList.do">
							<select name="pageSize">
								<option value="8">8</option>
								<option value="12">12</option>
								<option value="16" selected>16</option>
								<option value="20">20</option>
							</select>
							<input type="hidden" name="view" value="${view}">
							<input type="hidden" name="priceSort" value="<%=priceSort%>">
							<input type="hidden" name="category" value="<%=category%>">
							<input type="hidden" name="check" value="${check}">
							<input type="hidden" name="keyword" value="<%=keyword%>">
							<button type="submit" class="pageSize" >개씩 보기</button>
						</form>
					</c:when>
					<c:when test="${pageSize == 20}">
						<form action="itemList.do">
							<select name="pageSize">
								<option value="8">8</option>
								<option value="12">12</option>
								<option value="16">16</option>
								<option value="20" selected>20</option>
							</select>
							<input type="hidden" name="view" value="${view}">
							<input type="hidden" name="priceSort" value="<%=priceSort%>">
							<input type="hidden" name="category" value="<%=category%>">
							<input type="hidden" name="check" value="${check}">
							<input type="hidden" name="keyword" value="<%=keyword%>">
							<button type="submit" class="pageSize" >개씩 보기</button>
						</form>
					</c:when>
				</c:choose>

		
			</div>
			<br>
	<% if(count != 0) {		%>
			<c:choose>
			<c:when test="${view eq 'card'}">
			<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-left">
				<c:forEach var="item" items="${ilist}" varStatus="i">
					<form action="cartInsert.do" method="post">
						<div class="col mb-5">
							<div class="card h-100">
								<a href="itemAbout.do?item_num=${item.item_num}">
								<c:choose>
									<c:when test="${item.item_pictureUrl1 == null}">
										<!-- Product image-->
										<img class="card-img-top" src="images/item/no_image1.jpg" alt="..." />
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${item.item_quantity != 0}">
												<img class="card-img-top" src="images/item/${item.item_pictureUrl1}" alt="..." />
											</c:when>
											<c:otherwise>
												<img style="background: #000; opacity: 0.2" class="card-img-top" src="images/item/${item.item_pictureUrl1}" alt="..." />
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${item.item_discount > 0.00}">
										<div style="font-weight: bold;border-radius: 15px; border:2px solid white; margin: 0 auto; width: 50px; height: 50px; top: 0.1rem; right: 0.1rem; position: absolute; background-color: crimson; color: white; text-align: center">SALE<br>
											<fmt:formatNumber value="${item.item_discount*100}" />%
										</div>
									</c:when>
								</c:choose>
								</a>
								<!-- Product details-->
								<div class="card-body p-4">
									<div class="text-center">
										<div
											style="height: 50px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
											<!-- Product name-->
											<c:choose>
												<c:when test="${fn:length(item.item_name)>11}">
													<marquee width="100%" scrollamount="5">
														<h5 class="fw-bolder">${item.item_name}</h5>
													</marquee>
												</c:when>
												<c:otherwise>
													<h5 class="fw-bolder">${item.item_name}</h5>
												</c:otherwise>
											</c:choose>
										</div>
										<div
											style="height: 50px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
											<!-- Product name-->
											<c:choose>
												<c:when test="${fn:length(item.item_content)>15}">
													<marquee width="100%">
														<p style="color: gray">${item.item_content}</p>
													</marquee>
												</c:when>
												<c:otherwise>
													<p style="color: gray">${item.item_content}</p>
												</c:otherwise>
											</c:choose>
										</div>




										<p>
											<c:choose>
												<c:when test="${item.item_starsAvg == 5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 4.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 4.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 3.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 3.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 2.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 2.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 1.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 1.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${item.item_starsAvg >= 0.5}">
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:otherwise>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:otherwise>
											</c:choose>
											<br> <br>

											<!-- Product price-->
											<c:choose>
												<c:when test="${item.item_discount == 0.00 }">
													<fmt:formatNumber value="${item.item_price}" />원<br>
		                                    &nbsp;
                                    	</c:when>
												<c:otherwise>
													<del>
														<fmt:formatNumber value="${item.item_price}" />
														원
													</del>
													<br>
													<fmt:formatNumber
														value="${item.item_price -(item.item_price * item.item_discount)}" />원
                                    	</c:otherwise>
											</c:choose>
									</div>
								</div>
								<!-- Product actions-->
								<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
									<c:choose>
										<c:when test="${item.item_quantity != 0}">
											<%
												String userid = (String) session.getAttribute("userid");
											%>
											<c:set var="userid" value="<%=userid%>" />
											<div class="text-center">
												<a class="btn btn-outline-dark mt-auto"><i class="bi-cart-fill me-1"></i>
												<input type="hidden" name="userid" value="${userid}">
												<input type="hidden" name="item_quantity" value="${item.item_quantity}">
												<input type="hidden" name="item_pictureUrl1" value="${item.item_pictureUrl1}">
												<input type="hidden" name="item_num" value="${item.item_num}">
												<input type="hidden" name="item_name" value="${item.item_name}">
												<fmt:parseNumber var="item_price" integerOnly="true" value="${item.item_price -(item.item_price * item.item_discount)}" />
												<input type="hidden" name="item_price" value="${item_price}">
												<i class="bi-dash-circle" onclick="count('minus',${item.item_quantity},${item.item_num})"></i>
												<input type="number" id="${item.item_num}" name="item_cnt" value="1" readonly>
												<i class="bi-plus-circle" onclick="count('plus',${item.item_quantity},${item.item_num})"></i>
												<input type="submit" class="form-btn" value="장바구니에 담기" 	onClick="loginCheck()"></a>
											</div>
										</c:when>
										<c:otherwise>
											<div class="text-center">
												<br>
												<a class="btn btn-outline-dark mt-auto">품절된 상품입니다.<br></a>
												<br>
												<br>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</form>
				</c:forEach>
			</div>
                   </c:when>
                   <c:otherwise>
				<c:forEach var="item" items="${ilist}">
                	<form action="cartInsert.do" method="post">
                		<table width="100%">
                			<tr>
                				<td width="100px" height="100px"> 
                				                        <c:choose>
						<c:when test="${item.item_pictureUrl1 == null}">
                            <!-- Product image-->
                             <a href="itemAbout.do?item_num=${item.item_num}">
                            <img class="card-img-top" src="images/item/no_image1.jpg" alt="..." />
                            </a>
                            </c:when>
                            <c:otherwise>
                              <a href="itemAbout.do?item_num=${item.item_num}">
                            <img class="card-img-top" src="images/item/${item.item_pictureUrl1}" alt="..." />
                            </a>
                            </c:otherwise>
                            </c:choose>
                				
                				 </td>
                            	<td width="40%">${item.item_name}<br>
                            	${item.item_content}
                            	</td>
                            	<td width="20%"><fmt:formatNumber value="${item.item_price}"/></td>
                            	<c:choose>
                            	<c:when test="${item.item_quantity != 0}">
                            	<% String userid = (String) session.getAttribute("userid");  %>
                         		<c:set var="userid" value="<%=userid%>"/>
                            	<td width="30%"><a class="btn btn-outline-dark mt-auto"><i class="bi-cart-fill me-1"></i>
               					     <input type="hidden" name="userid" value="${userid}">
              					     <input type="hidden" name="item_quantity" value="${item.item_quantity}">
               					     <input type="hidden" name="item_pictureUrl1" value="${item.item_pictureUrl1}">
               					     <input type="hidden" name="item_num" value="${item.item_num}">
               					     <input type="hidden" name="item_name" value="${item.item_name}">
               				     <input type="hidden" name="item_price" value="${item.item_price}">
               				     
                    
                    
                    <i class="bi-dash-circle" onclick="count('minus',${item.item_quantity},${item.item_num})"></i>
                    <input type="number"id="${item.item_num}" name="item_cnt" value="1" readonly>
					<i class="bi-plus-circle" onclick="count('plus',${item.item_quantity},${item.item_num})"></i>
								 <input type="submit" class="form-btn" value="장바구니에 담기" onClick="loginCheck()"></a></td>
								 </c:when>
                  				 <c:otherwise>
                  				 <td width="30%">품절된 상품입니다</td>
               					  </c:otherwise>
							    </c:choose>
                			</tr>
                		</table>
                    </form>
			</c:forEach>
		</c:otherwise> 
		</c:choose>
                </div>
    <%} else {%>
		<div align="center">
			<i style="font-size:200px;color:orange" class="bi-search"></i>
			<div style="font-size:30px;color:gray">검색 결과가 없습니다.</div>
		</div>
	<%
		}
	%>
        <hr>
        <div align="center">
        <form action="itemList.do">
        <input type="hidden" name="priceSort" value="<%=priceSort%>">
        <input type="hidden" name="check" value="${check}">
        <input type="hidden" name="pageSize" value="<%=pageSize%>">
        <input type="hidden" name="view" value="<%=view%>">
		<select name="category">
			<option value="">선택안함</option>
			 <c:forEach var="category" items="${categoryList}" >
         		<option value="${category.item_category}">${category.item_category}</option>
         	</c:forEach>
		</select>      
		&nbsp;
        <i class="bi-search" style="font-size:20px"></i>
		&nbsp;
        <input type="text" name="keyword" placeholder="검색할 상품을 입력해주세요" size="40">
        <input type="submit" value="검색">
        </form>
        </div>
        <hr>
        <div align="center">
        <h4>
		<%
			// 아래는 페이지 표시 과정

			if (startPage > 10) {
		%>
		<a href="itemList.do?pageNum=<%=startPage - 10 %>&view=<%=view%>&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=<%=priceSort%>&keyword=<%=keyword%>"  style="color:black;"><i class="bi-chevron-compact-left"></i></a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
				if(currentPage == i){
					%>
		<a href="itemList.do?pageNum=<%=i %>&view=<%=view%>&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=<%=priceSort%>&keyword=<%=keyword%>" style="color:white;background-color:gray;border-radius:75px;text-decoration-line: none;">　<%=i %>　</a>
		<%
				}else{
					%>
		<a href="itemList.do?pageNum=<%=i %>&view=<%=view%>&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=<%=priceSort%>&keyword=<%=keyword%>" style="color:black;text-decoration-line: none;">　<%=i %>　</a>
					
					<%
				}
			}
			if (endPage < pageCount) {
		%>
		<a href="itemList.do?pageNum=<%=startPage + 10 %>&view=<%=view%>&pageSize=<%=pageSize%>&check=${check}&category=<%=category%>&priceSort=<%=priceSort%>&keyword=<%=keyword%>" style="color:black;"><i class="bi-chevron-compact-right"></i></a>
		<%
			}
		%>
		</h4>
		</div>
		</section>
		<br>
		<br>
<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>