<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="7">데이터가 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${totalCnt > 0 }">
		<c:forEach items="${taskList}" var ="list">
			<tr>
				<td><a href="javascript:fn_taskPopup('${list.planNo}')"
				       onmouseover="this.style.fontWeight='bold'" 
				       onmouseout="this.style.fontWeight=''">${list.taskTitle}</a></td>
				<td>${list.taskStart}</td>
				<td>${list.taskEnd}</td>
				<td>
				<a class="btnType3 color1" href="javascript:SendInfosearch('${list.planNo}');"><span>목록 보기</span></a>
				</td>
		</c:forEach> 
		</c:if>
		<input type="hidden" id="taskcnt" name="totalcnt" value ="${totalCnt}"/>