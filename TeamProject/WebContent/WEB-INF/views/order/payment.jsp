<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 결제</title>
<link href="css/styles.css" rel="stylesheet" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">

</style>
</head>
<body>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<section>
    <script>
/*          	   var item_name_encode = encodeURIComponent('${item_name}');
         	   var item_num_encode = encodeURIComponent('${item_num}');
         	   var item_cnt_encode = encodeURIComponent('${item_cnt}');
               var deli_pwd_encode = encodeURIComponent('${param.deli_pwd}');
               
               location.href='/TeamProject/orderOk.do?userid=${userid}&item_name='+item_name_encode+'&total_price=${amount}&deli_name=${deli_name}&deli_addr=${deli_addr}&deli_phone=${deli_phone}&deli_msg=${deli_msg}&deli_pwd='+deli_pwd_encode+'&deli_status=${deli_status}&usePoint=${usePoint}&point=${point}&deli_postcode=${deli_postcode}&item_num='+item_num_encode+'&item_cnt='+item_cnt_encode;
          */
        $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('imp79971809'); // "가맹점 식별코드"
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : '${order_num}',
            name : '이젠, 집에서) ${item_name}',
            amount : ${amount},
            buyer_name : '${deli_name}',
            buyer_tel : '${deli_phone}',
            buyer_postcode : '${deli_postcode}', //우편번호 임시
            buyer_addr : '${deli_addr}',
        }, function(rsp) {
            if ( rsp.success ) {
                jQuery.ajax({
                    url: "/payments/complete",
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                })
                //성공시 이동할 페이지
         	   var item_name_encode = encodeURIComponent('${item_name}');
         	   var item_num_encode = encodeURIComponent('${item_num}');
         	   var item_cnt_encode = encodeURIComponent('${item_cnt}');
               var deli_pwd_encode = encodeURIComponent('${param.deli_pwd}');
               
               location.href='/TeamProject/orderOk.do?userid=${userid}&item_name='+item_name_encode+'&total_price=${amount}&deli_name=${deli_name}&deli_addr=${deli_addr}&deli_phone=${deli_phone}&deli_msg=${deli_msg}&deli_pwd='+deli_pwd_encode+'&deli_status=${deli_status}&usePoint=${usePoint}&point=${point}&deli_postcode=${deli_postcode}&item_num='+item_num_encode+'&item_cnt='+item_cnt_encode;
              
            } else {
                msg = '결제에 실패하였습니다. 장바구니로 돌아갑니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                 location.href='/TeamProject/cartList.do';
                alert(msg);
            }
        });
        
    }); 
    </script>
  	</section>
<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>