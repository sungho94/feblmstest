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
								<c:forEach items="${noticemgrlist}" var="list">
									<tr>
										<td>${list.notice_no}</td>
										<td>
											<a href="javascript:fn_notionlistsearch('${list.notice_no }')" >
												${list.notice_title}
											</a>
										</td>
										<td>${list.loginID}</td>
										<td>${list.notice_date}</td>
										<td>${list.notice_count}</td>
									</tr>
								</c:forEach>
							</c:if>
							<input type="hidden" id="loginId" value="${loginId}" />
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>