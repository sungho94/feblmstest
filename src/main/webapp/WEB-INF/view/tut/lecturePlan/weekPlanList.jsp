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
								<c:forEach items="${weekPlanList}" var="list">
									<tr>
										<td>${list.plan_week}</td>
										<td>${list.plan_goal}</td>
										<td>${list.plan_content}</td>
										<td>
											<a href="javascript:fn_WeekPlan('${list.plan_no}')"><span>수정</span></a>
										</td>
									</tr>
								<input type="hidden" id="max" name="max" value ="${list.maxWeek}"/>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="weektotalcnt" name="weektotalcnt" value ="${totalcnt}"/>