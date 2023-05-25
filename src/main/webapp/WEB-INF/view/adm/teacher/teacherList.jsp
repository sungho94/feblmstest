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
		
		<c:forEach items="${teacherList}" var ="list">
			<tr>
				<td><a href="javascript:tutInfo('${list.loginID}')">${list.name}(${list.loginID})</a></td>
				<td>${list.user_hp}</td>
				<td>${list.user_email}</td>
				<td>${list.user_regdate}</td>
				<c:if test="${list.user_type eq 'D'}">
				<td>
				   <a class="btnType3 color1" href="javascript:typesearch('${list.loginID}');"><span>미승인</span></a>
				</td>
				</c:if>
				<c:if test="${list.user_type eq 'B'}">
				<td>승인</td>
				</c:if>
		</c:forEach> 
		</c:if>
		<input type="hidden" id="teacherCnt" name="teacherCnt" value ="${totalCnt}"/>