package kr.happyjob.study.all.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.all.model.NoticeMgrModel;
import kr.happyjob.study.all.model.QnaModel;
import kr.happyjob.study.all.model.QnaReplyModel;

public interface QnaReplyService {
	
	/** reply 목록 조회 */
	public List<QnaReplyModel> replylist(Map<String, Object> paramMap);
	
	/** reply 총 갯수 조회 replycnt */
	public int replycnt(Map<String, Object> paramMap);
	
	/** reply 등록 insert (replyinsert) */
	public int replyinsert(Map<String, Object> paramMap);
	
	/** reply 삭제 delete (replydelete) */
	public int replydelete(Map<String, Object> paramMap);
}