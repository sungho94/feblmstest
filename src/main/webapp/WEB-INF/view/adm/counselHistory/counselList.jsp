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
		
		<c:forEach items="${counselList}" var ="list">
			<tr>
				<td>${list.lecture_name}</td>
				<td>${list.stu_name}(${list.stu_loginID})</td>
				<td>${list.consultant_counsel}</td>
				<td>${list.consultant_date}</td>
				<td>${list.teacher_name}</td>
				<td> 
					<a class="btnType3 color1" href="javascript: fn_selectCounsel ('${list.consultant_no}');"><span>상세조회</span></a>
				</td>
				
		</c:forEach> 
		</c:if>
		<input type="hidden" id="counselCnt" name="counselCnt" value ="${totalCnt}"/>
		