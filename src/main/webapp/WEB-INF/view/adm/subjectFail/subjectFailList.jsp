<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:if test="${ subjectFailCount eq 0 }">
	<tr>
		<td colspan="5">검색된 강의가 없습니다.</td>
	</tr>
</c:if>

<c:if test="${ subjectFailCount > 0 }">
	<c:forEach items="${ subjectFailList }" var="list">
		<tr onClick = "detailRatio('${ list.lectureSeq }')">
			<td>${ list.lectureName }</td>
			<td>${ list.lectureStart }</td>
			<td>${ list.lectureEnd }</td>
			<td>${ list.days } 일</td>
			<td>${ list.lectureTotal } 명</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="subjectFailsCount" value="${ subjectFailCount }" />