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
								<c:forEach items="${referenceselectlist}" var="list">
									<tr>
										<td>${list.reference_title}</td>
										<td>${list.reference_date}</td>
										<td>${list.reference_file}</td>
										<td>
											<a href="javascript:fn_referencedownload('${list.reference_no}')"><span>수정 / 삭제</span></a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="rtotalcnt" name="rtotalcnt" value ="${totalcnt}"/>