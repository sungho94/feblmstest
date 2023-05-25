<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="4">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${studentListSearch}" var="list">
									<tr>
										<td>${list.lecture_seq}</td>
										<td>${list.name}</td>
										<td>${list.loginID}</td>
										<td>${list.lecture_name}</td>
										<td>${list.hp}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stotalcnt" name="stotalcnt" value ="${totalcnt}"/>