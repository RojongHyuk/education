<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.title {
	background: gray;
	color: white;
	text-align: center;
}

td {
	border: 1px solid black;
}

button {
	background: cornflowerblue;
	padding: 5px 10px;
}
</style>
<h1>강좌정보</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100 class="title">강좌번호</td>
			<td width=150><input type="text" name="lcode"
				value="${vo.lcode}" size=5></td>
			<td width=100 class="title">강의실</td>
			<td width=150><input type="text" name="room" value="${vo.room}"
				size=5></td>
			<td width=200 class="title">강의시수</td>
			<td width=150><input type="text" name="hours"
				value="${vo.hours}" size=5></td>
		</tr>
		<tr>
			<td class="title">강좌이름</td>
			<td colspan=3><input type="text" name="lname"
				value="${vo.lname}" size=50></td>
			<td class="title">최대수강인원</td>
			<td colspan=3><input type="text" name="capacity"
				value="${vo.capacity}" size=5></td>
		</tr>
		<tr>
			<td class="title">담당교수</td>
			<td colspan=3><input type="text" name="instructor"
				value="${vo.instructor}" size=5> <span>${vo.pname}</span></td>
			<td class="title">수강신청인원</td>
			<td colspan=3><span>${vo.persons}명</span></td>
		</tr>
	</table>
	<div class="buttons">
		<button type="submit">정보수정</button>
		<button type="reset">수정취소</button>
	</div>
</form>
<h2 style="margin-bottom: 20px;">수강신청학생</h2>
<button id="update">선택수정</button>
<table id="slist"></table>
<script id="stemp" type="text/x-handlebars-template">
	<tr class = "title">
		<td><input type="checkbox" id="all"></td>
		<td width = 100>학번</td>
		<td width = 100>이름</td>
		<td width = 100>학과</td>
		<td width = 100>학년</td>
		<td width = 200>수강신청일</td>
		<td width = 200>점수</td>
	</tr>
	{{#each .}}
	<tr class = "row" style = "text-align: center;">
		<td><input type="checkbox" class="chk"></td>
		<td class="scode">{{scode}}</td>
		<td>{{sname}}</td>
		<td>{{dept}}</td>
		<td>{{year}}학년</td>
		<td>{{edate}}</td>
		<td>
			<input type="text" class="grade" value="{{grade}}" size=3>
			<button>수정</button>
		</td>
	</tr>
	{{/each}}
</script>
<script>
	var lcode="${vo.lcode}";
	getList();
	

	
	//선택수정버튼을 클릭한 경우
	$("#update").on("click", function(){
		var chk=$("#slist .row .chk:checked").length;
		if(chk==0){
			alert("수정할 학생들을 선택하세요!");
			return;
		}
		
		if(!confirm(chk + "명 학생들의 점수를 수정하실래요?")) return;
		
		$("#slist .row .chk:checked").each(function(){
			var row=$(this).parent().parent();
			var scode=row.find(".scode").html();
			var grade=row.find(".grade").val();
			$.ajax({
				type:"post",
				url:"/enroll/update",
				data:{lcode:lcode,scode:scode,grade:grade},
				success:function(){}
			})	
		});
			
		alert("학생들 점수가 수정되었습니다.")
		getList();
	});
	
	//전체선택 체크박스를 클릭한 경우
	$("#slist").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#slist .row .chk").each(function(){
				$(this).prop("checked", true);
			})
		}else{
			$("#slist .row .chk").each(function(){
				$(this).prop("checked", false);
			})
		}
	});
	
	//각행의 체크박스를 클릭한 경우
	$("#slist").on("click", ".row .chk", function(){
		var all=$("#slist .row .chk").length;
		var chk=$("#slist .row .chk:checked").length;
		
		if(all==chk) $("#all").prop("checked", true);
		else $("#all").prop("checked", false);
	});
	
	//수정버튼을 클릭한 경우
	$("#slist").on("click", ".row button", function(){
		var row=$(this).parent().parent();
		var scode=row.find(".scode").html();
		var grade=row.find(".grade").val();
		if(!confirm(scode + "학생의 점수를 " + grade + "로 수정하실래요?")) return;	
		$.ajax({
			type:"post",
			url:"/enroll/update",
			data:{lcode:lcode,scode:scode,grade:grade},
			success:function(){
				alert("성적이 수정되었습니다.");
				getList();
			}
		})
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/enroll/slist.json",
			data:{lcode:lcode},
			dataType:"json",
			success:function(data){
				var temp=Handlebars.compile($("#stemp").html());
				$("#slist").html(temp(data));
			}
		})
	}
</script>






