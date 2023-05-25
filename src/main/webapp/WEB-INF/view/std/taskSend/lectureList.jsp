<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="7"> 수강 내역이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${totalCnt > 0 }">
		<c:forEach items="${lectureList}" var ="list">
			<tr>
				<td>${list.lectureSeq}</td>
				<td>${list.lectureName}</td>
				<td>${list.teacherName}</td>
				<td>${list.lectureStart} ~ ${list.lectureEnd}</td>
				<td>
				   <a class="btnType3 color1" href="javascript:fn_clickTask('${list.lectureSeq}');"><span>과제 관리</span></a>
				</td>
				
		</c:forEach> 
		</c:if>
		<input type="hidden" id="lectureCnt" name="lectureCnt" value ="${totalCnt}"/>