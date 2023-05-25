package kr.happyjob.study.all.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.all.dao.QnaDao;
import kr.happyjob.study.all.model.NoticeMgrModel;
import kr.happyjob.study.all.model.QnaModel;

@Service
public class QnaServiceImpl implements QnaService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	QnaDao qnaDao;
	
	// 로그인 사용자 불러오기
	@Override
	public QnaModel userinfo(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return qnaDao.userinfo(paramMap);
	}
	
	/** qna 전체 목록 */
	@Override
	public List<QnaModel> qnalist(Map<String, Object> paramMap) {

		return qnaDao.qnalist(paramMap);
	}

	/** qna 목록 카운트 */
	@Override
	public int qnacnt(Map<String, Object> paramMap) {

		return qnaDao.qnacnt(paramMap);
	}

	/** qna 하단 목록 content (qnacontent) */
	public QnaModel qnacontent(Map<String, Object> paramMap) {
		return qnaDao.qnacontent(paramMap);
	}

	/** QnA 등록 insert (qnainsert) */
	public int qnainsert(Map<String, Object> paramMap) {
		return qnaDao.qnainsert(paramMap);
	}

	/** QnA 등록 update (qnaupdate) */
	public int qnaupdate(Map<String, Object> paramMap) {
		return qnaDao.qnaupdate(paramMap);
	}
	
	/** QnA 삭제 delete (qnadelete) */
	public int qnadelete(Map<String, Object> paramMap) {
		return qnaDao.qnadelete(paramMap);
	}
	
	/** QnA 조회수 viewcount */
	public int viewcount(Map<String, Object> paramMap) {
		return qnaDao.viewcount(paramMap);
	}
}