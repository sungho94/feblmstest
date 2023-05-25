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
								<c:forEach items="${resumeLectureSelect}" var="list">
									<tr>
										<td>${list.loginID}</td>
										<td>${list.name}</td>
										<td>${list.user_hp}</td>
										<td>${list.user_email}</td>
										<td><c:choose>
                                  			<c:when test="${list.resume_file != null}">
                                       			<a href="javascript:fn_resumeDownload('${list.loginID}');">[다운로드]</a>
                                  			</c:when>
                                  				<c:otherwise>
                                  				</c:otherwise>
                              				</c:choose>
                              			</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stotalcnt" name="stotalcnt" value ="${totalcnt}"/>