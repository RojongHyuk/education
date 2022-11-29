<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>교수등록</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td>교수번호</td>
			<td><input type="text" name="pcode" value="${code}" readonly></td>
		</tr>
		<tr>
			<td>교수이름</td>
			<td><input type="text" name="pname"></td>
		</tr>
		<tr>
			<td>교수학과</td>
			<td>
				<select name="dept">
					<option value="전산">컴퓨터정보공학과</option>
					<option value="전자">전자공학과</option>
					<option value="건축">건축공학과</option>					
				</select>
			</td>
		</tr>
		<tr>
			<td>직급</td>
			<td>
				<input type="radio" name="title" value="정교수">정교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="부교수" checked>부교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="조교수">조교수
			</td>
		</tr>
		<tr>
			<td>임용일자</td>
			<td><input type="date" name="hiredate"></td>
		</tr>
		<tr>
			<td>급여</td>
			<td><input type="text" name="salary"></td>
		</tr>
	</table>
	<div class="buttons">
		<button>교수등록</button>
		<button type="reset">등록취소</button>
	</div>
</form>
<script>
	$(frm).on('submit', function(e){
		e.preventDefault();
		var pname=$(frm.pname).val();
		var salary=$(frm.salary).val();
		if(pname==""){
			alert('교수이름을 입력해주세요.');
			$(frm.pname).focus();
			return;
		}
		if(salary.replace(/[0-9]/g,'')){
			alert('급여를 숫자로 입력하세요.');
			$(frm.salary).focus();
			return;
		}
		if(!confirm("등록하시겠습니까?")) return;
		frm.submit();
	});
</script>





