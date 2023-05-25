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
								<c:set var = "loginid" value="${loginId }"/>
								<c:forEach items="${replylist}" var="list">
									<tr>
										<td>${list.loginID}</td>
										<td>${list.reply_content}</td>
										<td>${list.reply_date}</td>
										<td>
										<c:choose>
											<c:when test="${list.loginID eq loginid }">
											<a href="javascript:fn_replydelete('${list.qna_no}', '${list.reply_no}')" class="btnType blue" id="reply_delbtn" name="btn">
												<span>삭제</span></a>
											</c:when>
											<c:otherwise>
											
											</c:otherwise>
										</c:choose>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="loginId" value="${loginId}" /> <!-- 현재 로그인한 아이디 -->
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>