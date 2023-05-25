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
		<c:forEach items="${planList}" var = "list">
			<tr>
				<td>${list.planWeek }</td>
				<td><a href="javascript:tasklistsearch('${list.planNo}')"  
				        onmouseover="this.style.fontWeight='bold'" 
				        onmouseout="this.style.fontWeight=''">${list.planGoal}</a>
				 </td>
			</tr>
		</c:forEach>
		</c:if>
		<input type="hidden" id="plancnt" name="plancnt" value ="${totalCnt}"/>
		
		
		
