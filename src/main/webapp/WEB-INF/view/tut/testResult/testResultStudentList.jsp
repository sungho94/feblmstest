<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${testStudentSelectList}" var="list">
									<tr>
										<td>${list.loginID}</td>
										<td>${list.name}</td>
										<td>${list.SCORE}</td>
										<td>
										<c:choose>
										    <c:when test="${list.SCORE >= 60 }">
										   		<div>통과</div>
										    </c:when>
										    <c:otherwise>
												<div>과락</div>
										    </c:otherwise>
										</c:choose>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stotalcnt" name="stotalcnt" value ="${totalcnt}"/>