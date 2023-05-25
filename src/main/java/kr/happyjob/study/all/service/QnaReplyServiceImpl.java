package kr.happyjob.study.all.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.all.dao.QnaDao;
import kr.happyjob.study.all.dao.QnaReplyDao;
import kr.happyjob.study.all.model.NoticeMgrModel;
import kr.happyjob.study.all.model.QnaModel;
import kr.happyjob.study.all.model.QnaReplyModel;

@Service
public class QnaReplyServiceImpl implements QnaReplyService {
	
	@Autowired
	QnaReplyDao replyDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/** list 조회 */
	@Override
	public List<QnaReplyModel> replylist(Map<String, Object> paramMap) {
		return replyDao.replylist(paramMap);
	}
	
	/** reply 총 갯수 조회 replycnt */
	public int replycnt(Map<String, Object> paramMap) {
		return replyDao.replycnt(paramMap);
	}
	
	/** QnA 등록 insert (replyinsert) */
	public int replyinsert(Map<String, Object> paramMap) {
		return replyDao.replyinsert(paramMap);
	}
	
	/** QnA 등록 delete (replydelete) */
	public int replydelete(Map<String, Object> paramMap) {
		return replyDao.replydelete(paramMap);
	}
}