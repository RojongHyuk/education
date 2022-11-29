<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>강좌목록</h1>
<div>
	검색 수 : <span id = "count"></span>
</div>
<div>
	<form name = "frm">	
		<select name = "key" id = "key">
			<option value = "lcode">강좌번호</option>
			<option value = "lname">강좌이름</option>
			<option value = "pname">담당교수</option>
		</select>
		<input type = "text" id = "word" placeholder = "검색어">
		<select name = "per" id = "per">
			<option value = "2">2행</option>
			<option value = "3">3행</option>
			<option value = "5" selected>5행</option>
			<option value = "10">10행</option>
		</select>
		<button>검색</button>
		<div style = "float: right;">
			<select name = "order" id = "order">
				<option value = "lcode">강좌번호</option>
				<option value = "lname">강좌이름</option>
				<option value = "pname">담당교수</option>
			</select>
			<select name = "desc" id = "desc">
				<option value = "asc">오름차순</option>
				<option value = "desc">내림차순</option>
			</select>
			<a href = "/cou/insert" style="margin-left: 20px;"><button type = "button">강좌등록</button></a>
		</div>
	</form>
	
</div>
<table id = "tbl"></table>
<script id = "temp" type = "text/x-handlebars-template">
	<tr class = "title">
		<td width = 100>강좌번호</td>
		<td width = 300>강좌이름</td>
		<td width = 100>담당교수</td>
		<td width = 100>강의실</td>
		<td width = 150>수강인원</td>
		<td width = 150>강의시수</td>
	</tr>
	{{#each array}}
	<tr class = "row" style = "text-align: center;" onclick = "location.href='/cou/read?lcode={{lcode}}'">
		<td class = "lcode">{{lcode}}</td>
		<td class = "lname">{{lname}}</td>
		<td class = "pname">{{pname}}({{dept}})</td>
		<td class = "room">{{room}}호</td>
		<td class = "persons">{{persons}}/<b>{{capacity}}</b>명</td>			
		<td class="hours">{{hours}}</td>			
	</tr>
	{{/each}}
</script>

<div class = "buttons" style = "text-align: center; margin-top: 20px;">
	<button id = "prev">이전</button>
	<span id = "page">1/10</span>
	<button id = "next">다음</button>
</div>

<script>
	var page = 1;
	getList();
	
	$("#next").on("click", function() {
		page++;
		getList();
	});
	
	$("#prev").on("click", function() {
		page--;
		getList();
	});
	
	$("#per, #order, #desc").on("change", function() {
		page = 1;
		getList();
	});
	
	$(frm).on("submit", function(e) {
		e.preventDefault();
		page = 1;
		getList();
	});
	
	function getList() {
		var key = $(frm.key).val();
		var word = $(frm.word).val();
		var per = $(frm.per).val();
		var order = $(frm.order).val();
		var desc = $(frm.desc).val();
		
		$.ajax ({
			type : "get",
			url : "/cou/list.json",
			dataType : "json",
			data : {key : key, word : word, per : per, order : order, desc : desc, page : page},
			success: function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#count").html(data.total);
				
				if(data.total == 0) {
					$("#tbl").append("<tr><td colspan = 6 class = 'none' style = 'text-align: center; color: red;'> 검색된 자료가 없습니다! </td></tr>");
					$(".buttons").hide();
				} 
				else {
					$("#page").html(page + "/" + data.last);
					
					if(page == 1) {
						$("#prev").attr("disabled", true);
					}
					else {
						$("#prev").attr("disabled", false);
					}
					
					if(page == data.last) {
						$("#next").attr("disabled", true);
					}
					else {
						$("#next").attr("disabled", false);
					}
					$(".buttons").show();
				}
			}
		});
	}
</script>