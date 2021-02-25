<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<style>
	table {
	margin:0 auto;/*가운데정렬*/
	border-collapse: collapse;/*테이블간격없애기*/
	border:1px solid black; 
	}
	tr,th,td {border:1px solid black;}
	div {text-align :center;}
	input {width:80px;}
	</style>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- 아래내용은 필요없음 참고용
	<script src="https://github.com/jquery/jquery-ui/blob/main/ui/i18n/datepicker-ko.js"></script>
	 -->
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<div>
<h3>회원등록</h3>
<form name="form_insert" action="<c:url value='/'/>member_insert" method="post">
<div>
<label>아이디</label>
<input name="userid" ype="test" required />
<label>암호</label>
<input name="userpw" type="password" required/>
<label>이름</label>
<input name="username" type="text" required />
<label>이메일</label>
<input name="email" type="text" required />
<button type="submit">회원등록</button>
</div>
</form>
<h3>회원리스트</h3>
<table>
<tr>
<th>사용자ID</th>
<th>암호</th>
<th>이름</th>
<th>이메일</th>
<th>등록일</th>
<th>수정일</th>
<th>수정/삭제</th>
</tr>
<c:forEach items="${memberList}" var="memberVO" varStatus="cnt">
	<tr>
	<form name="form_action" action="<c:url value='/' />member_update" method="post">
	<td><input name="userid" value="${memberVO.userid}"></td>
	<td><input name="userpw" value="${memberVO.userpw}"></td>
	<td><input name="username" value="${memberVO.username}"></td>
	<td><input name="email" value="${memberVO.email}"></td> 
	<td><input class="date1" name="regdate" value='<fmt:formatDate pattern="yyyy-MM-dd hh:MM:ss" value="${memberVO.regdate}"/>' ></td>
	<td><input class="date2" name="updatedate" value='<fmt:formatDate pattern="yyyy-MM-dd hh:MM:ss" value="${memberVO.updatedate}"/>' ></td>
	<td>
	<button class="btn_update" type="button">수정</button>
	<button class="btn_delete" type="button">삭제</button>
	</td>
	</form>
	</tr>
</c:forEach>
</table>
</div>
<script>
$(document).ready(function(){
	$(".date1").datepicker({
		dateFormat: 'yy-mm-dd' //Input Display Format 변경
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
            ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
            ,minDate: "-3Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            ,maxDate: "+3Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
	});//j쿼리달력 작동시작
	$(".date2").datepicker({
		dateFormat:"yy-mm-dd"
			,showOn: "both"   
			,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			,buttonImageOnly: true 
	});
	$(".btn_update").on("click",function(){
		//alert("수정버튼클릭");
		var click_element = $(this).parent().parent().find("form[name='form_action']");
		//alert(click_element.attr('name'));//디버그
		click_element.submit();
	});
	$(".btn_delete").on("click",function(){
		//alert("삭제버튼클릭");
		if(confirm("정말로 삭제하시겠습니까?")){
			var click_element = $(this).parent().parent().find("form[name='form_action']");
			click_element.attr("action","<c:url value='/' />member_delete");
			click_element.submit();
		}
	});
});
</script>
</body>
</html>
