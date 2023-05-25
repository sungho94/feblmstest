<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="8">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${totalCnt > 0 }">
		<c:forEach items="${lectureList}" var = "list">
			<tr>
				<td>${list.lectureSeq}</td>
				<td><a href="javascript:planlistsearch('${list.lectureSeq}')"
				       onmouseover="this.style.fontWeight='bold'" 
				       onmouseout="this.style.fontWeight=''">${list.lectureName}</a></td>
				<td>${list.tutName}</td>
				<td>${list.lectureStart}</td>
				<td>${list.lectureEnd}</td>
				<td>${list.roomNo}</td>
				<td>${list.lecturePerson}</td>
			</tr>
		</c:forEach>
		</c:if>
		<input type="hidden" id="lectureCnt" name=lectureCnt value ="${totalCnt}"/>