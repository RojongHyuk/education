<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.title{border:1px solid skyblue;}
	td {border:1px solid skyblue;}
</style>
<h1>교수정보</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100 class="title">교수번호</td>
			<td width=100><input type="text" name="pcode" value="${vo.pcode}" size=5></td>
			<td width=100 class="title">교수학과</td>
			<td width=200>
				<select name="dept">
					<option value="전산" <c:out value="${vo.dept=='전산'?'selected':''}"/>>컴퓨터정보공학과</option>
					<option value="전자" <c:out value="${vo.dept=='전자'?'selected':''}"/>>전자공학과
					<option value="건축" <c:out value="${vo.dept=='건축'?'selected':''}"/>>건축공학과</option>
				</select>
			</td>
			<td width=100 class="title">임용일자</td>
			<td width=300><input type="date" value="${vo.hiredate}" name="hiredate"></td>
		</tr>
		<tr>
			<td class="title">교수이름</td>
			<td><input type="text" name="pname" value="${vo.pname}"></td>
			<td class="title">교수급여</td>
			<td><input type="text" name="salary" value="${vo.salary}"></td>
			<td class="title">교수직급</td>
			<td>
				<input type="radio" name="title" value="정교수" <c:out value="${vo.title=='정교수'?'checked':''}"/>>정교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="부교수" <c:out value="${vo.title=='부교수'?'checked':''}"/>>부교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="조교수" <c:out value="${vo.title=='조교수'?'checked':''}"/>>조교수
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button>정보수정</button>
		<button type="reset">수정취소</button>
	</div>
</form>

<h2>담당과목</h2>
<table id="clist" width="960"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=100>강좌번호</td>
		<td width=100>강좌이름</td>
		<td width=100>강의실</td>
		<td width=100>강의시수</td>
		<td width=100>수강인원</td>
		<td width=100>강좌정보</td>
	</tr>
	{{#each .}}
	<tr class="row">
		<td>{{lcode}}</td>
		<td>{{lname}}</td>
		<td>{{room}}호</td>
		<td>{{hours}}</td>
		<td>{{persons}}/<b>{{capacity}}</b>명</td>
		<td><button>강좌정보</button></td>
	</tr>
	{{/each}}
</script>
<br>
<h2>담당학생</h2>
<table id="slist" width="960"></table>
<script id="temp1" type="text/x-handlebars-template">
	<tr class="title">
		<td width=100>학생번호</td>
		<td width=100>학생이름</td>
		<td width=100>학과</td>
		<td width=100>학년</td>
		<td width=100>생년월일</td>
		<td width=100>학생정보</td>
	</tr>
	{{#each .}}
	<tr class="row">
		<td>{{scode}}</td>
		<td>{{sname}}</td>
		<td>{{dept}}</td>
		<td>{{year}}학년</td>
		<td>{{birthday}}</td>
		<td><button>학생정보</button></td>
	</tr>
	{{/each}}
</script>

<script>
	var pcode="${vo.pcode}";
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("정보를 수정하시겠습니까?")) return;
		frm.action='/pro/update';
		frm.submit();
	});
	//담당과목출력하기
	$.ajax({
		type:'get',
		url:'/pro/clist.json',
		data:{pcode:pcode},
		dataType:'json',
		success:function(data){
			var temp=Handlebars.compile($("#temp").html());
			if(data.length==0){
				 $("#clist").append("<tr><td colspan=6 class='none'>담당강좌가 없습니다.</td></tr>");
			}else{
				$("#clist").html(temp(data));
			}
		}
	});
	
	//담당학생출력하기
	$.ajax({
		type:'get',
		url:'/pro/slist.json',
		data:{pcode:pcode},
		dataType:'json',
		success:function(data){
			var temp=Handlebars.compile($("#temp1").html());
			if(data.length==0){
				 $("#slist").append("<tr><td colspan=6 class='none'>담당학생이 없습니다.</td></tr>");
			}else{
				$("#slist").html(temp(data));
			}
		}
	});
</script>

