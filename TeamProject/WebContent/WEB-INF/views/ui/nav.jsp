<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- 메인 페이지  navigation bar 부분 -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="js/sunwoo.js"></script>
        
</head>
<body>
<%
	String name = (String)session.getAttribute("name");
	int admin;
	int cartCnt = (Integer)session.getAttribute("cartCnt");
	//세션이 없는 경우
	if (name == null)
		admin = -1;
	else
	{
		admin = (Integer)session.getAttribute("admin");
	}
%>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="index">이젠, 집에서</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link" href="about">사이트 소개</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">게시판</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="javascript:method2();">공지사항</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="#!">문의하기</a></li>
                                <li><a class="dropdown-item" href="#!">자주묻는 질문</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">밀키트</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="itemList.do?view=card&pageSize=12&check=all&category=&priceSort=default&keyword=">전체 밀키트</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="itemList.do?view=card&pageSize=12&check=best&category=&priceSort=default&keyword=">인기 밀키트</a></li>
                                <li><a class="dropdown-item" href="itemList.do?view=card&pageSize=12&check=new&category=&priceSort=default&keyword=">신상 밀키트</a></li>
                            </ul>
                        </li>
                    </ul>

                    &nbsp;&nbsp;&nbsp;
                    <%if(name != null){ %>
	                <form action ="myPage" class="d-flex">
	                    <button class="btn btn-outline-dark" type="submit">
	                            	마이페이지
	                    </button>
	                </form>
	                <br>
	                <form action="cartList.do" method="get" class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            	장바구니
                            <span class="badge bg-dark text-white ms-1 rounded-pill">${sessionScope.cartCnt } <!-- 장바구니에 담긴 수 --></span>
                        </button>
                    </form>
	                <br>
                    <form action ="logout" class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            		로그아웃
                        </button>
                    </form>    

	                    <%if(admin == 1){ %>
	                    <form action ="managePage" method="get" class="d-flex">
	                        <button class="btn btn-outline-dark" type="submit">
	                            	관리자페이지
	                        </button>
	                    </form>
	                    
	                    <%} %>      
	                
                    <%} else { %>
                    <form action ="login" class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            	로그인/회원가입</button>
                    </form>
                    <%} %>
                    


                </div>
            </div>
        </nav>

</body>
</html>