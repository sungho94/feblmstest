<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					
							<c:if test="${stotalcnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${stotalcnt > 0 }">
								<c:forEach items="${studentInfo}" var="list">
									<tr>
										<input type="hidden" id="lecture_seq" name="lecture_seq" value="${list.lecture_seq }" />
										<td>${list.student_name}</td>
										<td>${list.student_no}</td>
										<td>${list.student_hp_no}</td>
										<td>${list.student_birth}</td>
										<td>${list.student_survey}</td>
										<td>${list.student_test}</td>
										<td>${list.student_lecture}</td>
										<td>
										  <c:if test="${list.student_lecture eq 'N' }">
											<a class="btnType blue" id="btnLectureApproval" href="javascript:stdLectureApproval('${list.student_no}',${list.lecture_seq});" name="btn"><span>승인</span></a>
										 </c:if>	
										 <c:if test="${list.student_lecture eq 'Y' }">
											<a class="btnType blue" id="btnLectureDisapproval" href="javascript:stdLectureDisapproval('${list.student_no}',${list.lecture_seq});"  name="btn"><span>취소</span></a>
										</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stotalcnt" name="stotalcnt" value ="${stotalcnt}"/>
						