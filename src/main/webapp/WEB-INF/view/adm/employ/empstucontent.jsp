<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${employdetaillist}" var="list">
									<tr>
										<td>${list.employ_no}</td>
										<td>${list.loginID}</td>
										<td>${list.name}</td>
										<td>${list.employ_name}</td>
										<td>${list.employ_state}</td>
										<td>${list.employ_join}</td>
										<td>${list.employ_leave}</td>
										<td>
											<a href="javascript:empupdate('${list.employ_no}', '${list.employ_name}', '${list.employ_state}', '${list.employ_join}', '${list.employ_leave}')" >
												수정
											</a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="loginId" value="${loginID}" />
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>