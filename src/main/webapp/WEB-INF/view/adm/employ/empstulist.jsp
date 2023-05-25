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
								<c:forEach items="${empclasslist}" var="list">
									<tr>
										<td>${list.name}</td>
										<td>${list.user_hp}</td>
										<td>${list.loginID}</td>
										<td>${list.user_regdate}</td>
										<td>
											<a href="javascript:fn_studentdetail('${list.loginID}', '${list.name}')" class="btn btn-primary btn-xs" id="emp_updbtn" name="btn" >
												<span>확인</span>
											</a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="loginId" value="${loginID}" />
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>