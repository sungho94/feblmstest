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
		<c:forEach items="${tasksendinfo}" var = "list">
			<tr>
				<td>${list.stdName}</td>
				<td><a href="javascript:fn_taskSendDetail('${list.sendNo}')")>${list.sendTitle}</a></td>
				<td>${list.sendDate}</td>
			</tr>
		</c:forEach>
		</c:if>
		<input type="hidden" id="sendcnt" name="sendcnt" value ="${totalCnt}"/>
		