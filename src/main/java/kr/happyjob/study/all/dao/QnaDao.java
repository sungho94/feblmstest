package kr.happyjob.study.all.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.all.model.NoticeMgrModel;
import kr.happyjob.study.all.model.QnaModel;

public interface QnaDao {
	// 로그인 사용자 정보 불러오기
	public QnaModel userinfo(Map<String, Object> paramMap);

	/** QnA 목록 조회 */
	public List<QnaModel> qnalist(Map<String, Object> paramMap);

	/** QnA 목록 count */
	public int qnacnt(Map<String, Object> paramMap);

	/** QnA 상세 목록 content (qnacontent) */
	public QnaModel qnacontent(Map<String, Object> paramMap);

	/** QnA 등록 insert (qnainsert) */
	public int qnainsert(Map<String, Object> paramMap);

	/** QnA 수정 update (qnaupdate) */
	public int qnaupdate(Map<String, Object> paramMap);
	
	/** QnA 삭제 delete (qnadelete) */
	public int qnadelete(Map<String, Object> paramMap);
	
	/** QnA 조회수 viewcount */
	public int viewcount(Map<String, Object> paramMap);
}