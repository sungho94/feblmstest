<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>






<table class="col">
	<caption>caption</caption>
	<colgroup>
		<col width="15%">
	</colgroup>
	
	<c:if test="${lecturePlanList[0].student_survey eq 'N'}">
	<span class="fr"> <a class="btnType blue"
		href="javascript:surveyQuestion()" name="modal"><span>설문조사</span></a>
	</span>
	</c:if>

	<thead>
		<tr>
			<th>강의 목표</th>
			<td colspan=2>&nbsp&nbsp ${lecturePlanList[0].lecture_goal}</td>
		</tr>
		<tr>
			<th scope="col">주차</th>
			<th scope="col">학습목표</th>
			<th scope="col">학습내용</th>
		</tr>
	</thead>
	<tbody id="lecturePlanList">

		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${totalCnt > 0 }">
		<c:forEach items="${lecturePlanList}" var="list">
			<tr>
				<td>${list.plan_week}</td>
				<td>${list.plan_goal}</td>
				<td>${list.plan_content}</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
<br>
<br>

