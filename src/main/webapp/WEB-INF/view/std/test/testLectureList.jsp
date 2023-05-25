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
								<c:forEach items="${testLectureList}" var="list">
									<tr>
										<td>${list.num}</td>
										<td>${list.lecture_name}</a></td>
										<td>${list.teacher_name}(${list.loginID})</td>
										<td>${list.lecture_start} ~ ${list.lecture_end}</td>
										<td>
											<c:if test="${list.student_test eq 'Y' }">
												<c:if test="${list.score >= 60 }">
													통과
												</c:if>
												<c:if test="${list.score < 60 }">
													과락
												</c:if>
											</c:if>
											<c:if test="${list.student_test eq 'N' }">
													미응시
											</c:if>
										</td>
										<td>
											<c:if test="${list.student_test eq 'Y'}">
												응시완료
											</c:if>
											<c:if test="${list.student_test eq 'N'}">
												<a class="btnType blue" href="javascript:fn_test(${list.lecture_seq})" name="modal"><span>시험응시</span></a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>