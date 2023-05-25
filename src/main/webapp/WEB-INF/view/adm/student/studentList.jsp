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
								<c:forEach items="${studentList}" var="list">
									<tr>
										<td>
										<a href="javascript:fn_studentSelect('${list.loginID}')">
										${list.name}(${list.loginID})
										</a>
										</td>
										<td>${list.lecture_name}</td>
										<td>${list.hp}</td>
										<td>${list.regdate}</td>
										<td></td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stotalCnt" name="stotalCnt" value ="${totalCnt}"/>