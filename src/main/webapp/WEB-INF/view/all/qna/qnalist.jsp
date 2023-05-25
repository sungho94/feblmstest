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
								<c:forEach items="${qnalist}" var="list">
									<tr>
										<td>${list.qna_no}</td>
										<td>
											<a href="javascript:fn_qnalistsearch('${list.qna_no}')" >
												${list.qna_title}
											</a>
										</td>
										<td>${list.qna_date}</td>
										<td>${list.name}</td>
										<td>${list.qna_count}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="loginId" value="${loginId}" />
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>