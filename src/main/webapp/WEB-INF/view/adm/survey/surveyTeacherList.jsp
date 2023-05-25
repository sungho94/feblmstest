<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalCnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0 }">
								<c:forEach items="${surveyTeacherList}" var="list">
									<tr>
										<td><a href="javascript:fn_lectureList('${list.loginID}')">${list.loginID}</a></td>
										<td>${list.name}</a></td>
										<td>${list.user_hp}</td>
										<td>${list.user_email}</td>
										<td>${list.user_regdate}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>